#import "GPUImageLensBlurFilter.h"

@implementation GPUImageLensBlurFilter

@synthesize texelSpacingMultiplier = _texelSpacingMultiplier;
@synthesize blurRadiusInPixels = _blurRadiusInPixels;
@synthesize blurRadiusAsFractionOfImageWidth  = _blurRadiusAsFractionOfImageWidth;
@synthesize blurRadiusAsFractionOfImageHeight = _blurRadiusAsFractionOfImageHeight;
@synthesize blurPasses = _blurPasses;

#pragma mark -
#pragma mark Initialization and teardown

- (id)initWithFirstStageVertexShaderFromString:(NSString *)firstStageVertexShaderString firstStageFragmentShaderFromString:(NSString *)firstStageFragmentShaderString secondStageVertexShaderFromString:(NSString *)secondStageVertexShaderString secondStageFragmentShaderFromString:(NSString *)secondStageFragmentShaderString
{
    if (!(self = [super initWithFirstStageVertexShaderFromString:firstStageVertexShaderString firstStageFragmentShaderFromString:firstStageFragmentShaderString secondStageVertexShaderFromString:secondStageVertexShaderString secondStageFragmentShaderFromString:secondStageFragmentShaderString]))
    {
        return nil;
    }
    
    self.texelSpacingMultiplier = 1.0;
    _blurRadiusInPixels = 2.0;
    shouldResizeBlurRadiusWithImageSize = NO;
    
    return self;
}

- (id)init;
{
    self = [super init];
    if(self){
        NSString *currentGaussianBlurVertexShader = [self vertexShaderForOptimizedBlurOfRadius:4 sigma:2.0];
        NSString *currentGaussianBlurFragmentShader = [self fragmentShaderForOptimizedBlurOfRadius:4 sigma:2.0];
        
        return [self initWithFirstStageVertexShaderFromString:currentGaussianBlurVertexShader firstStageFragmentShaderFromString:currentGaussianBlurFragmentShader secondStageVertexShaderFromString:currentGaussianBlurVertexShader secondStageFragmentShaderFromString:currentGaussianBlurFragmentShader];
    }
    return nil;
}

#pragma mark -
#pragma mark Auto-generation of optimized Gaussian shaders

// "Implementation limit of 32 varying components exceeded" - Max number of varyings for these GPUs

- (NSString *)vertexShaderForStandardBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
{
    if (blurRadius < 1)
    {
        return kGPUImageVertexShaderString;
    }
    
    //    NSLog(@"Max varyings: %d", [GPUImageContext maximumVaryingVectorsForThisDevice]);
    NSMutableString *shaderString = [[NSMutableString alloc] init];
    
    // Header
    [shaderString appendFormat:@"\
     attribute vec4 position;\n\
     attribute vec4 inputTextureCoordinate;\n\
     \n\
     uniform float texelWidthOffset;\n\
     uniform float texelHeightOffset;\n\
     \n\
     varying vec2 blurCoordinates[%lu];\n\
     \n\
     void main()\n\
     {\n\
     gl_Position = position;\n\
     \n\
     vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);\n", (unsigned long)(blurRadius * 2 + 1) ];
    
    // Inner offset loop
    for (NSUInteger currentBlurCoordinateIndex = 0; currentBlurCoordinateIndex < (blurRadius * 2 + 1); currentBlurCoordinateIndex++)
    {
        NSInteger offsetFromCenter = currentBlurCoordinateIndex - blurRadius;
        if (offsetFromCenter < 0)
        {
            [shaderString appendFormat:@"blurCoordinates[%ld] = inputTextureCoordinate.xy - singleStepOffset * %f;\n", (unsigned long)currentBlurCoordinateIndex, (GLfloat)(-offsetFromCenter)];
        }
        else if (offsetFromCenter > 0)
        {
            [shaderString appendFormat:@"blurCoordinates[%ld] = inputTextureCoordinate.xy + singleStepOffset * %f;\n", (unsigned long)currentBlurCoordinateIndex, (GLfloat)(offsetFromCenter)];
        }
        else
        {
            [shaderString appendFormat:@"blurCoordinates[%ld] = inputTextureCoordinate.xy;\n", (unsigned long)currentBlurCoordinateIndex];
        }
    }
    
    // Footer
    [shaderString appendString:@"}\n"];
    
    return shaderString;
}

- (NSString *)fragmentShaderForStandardBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
{
    if (blurRadius < 1)
    {
        return kGPUImagePassthroughFragmentShaderString;
    }
    
    // First, generate the normal Gaussian weights for a given sigma
    GLfloat *standardGaussianWeights = calloc(blurRadius + 1, sizeof(GLfloat));
    GLfloat sumOfWeights = 0.0;
    for (NSUInteger currentGaussianWeightIndex = 0; currentGaussianWeightIndex < blurRadius + 1; currentGaussianWeightIndex++)
    {
        standardGaussianWeights[currentGaussianWeightIndex] = (1.0 / sqrt(2.0 * M_PI * pow(sigma, 2.0))) * exp(-pow(currentGaussianWeightIndex, 2.0) / (2.0 * pow(sigma, 2.0)));
        
        if (currentGaussianWeightIndex == 0)
        {
            sumOfWeights += standardGaussianWeights[currentGaussianWeightIndex];
        }
        else
        {
            sumOfWeights += 2.0 * standardGaussianWeights[currentGaussianWeightIndex];
        }
    }
    
    // Next, normalize these weights to prevent the clipping of the Gaussian curve at the end of the discrete samples from reducing luminance
    for (NSUInteger currentGaussianWeightIndex = 0; currentGaussianWeightIndex < blurRadius + 1; currentGaussianWeightIndex++)
    {
        standardGaussianWeights[currentGaussianWeightIndex] = standardGaussianWeights[currentGaussianWeightIndex] / sumOfWeights;
    }
    
    // Finally, generate the shader from these weights
    NSMutableString *shaderString = [[NSMutableString alloc] init];
    
    // Header
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    [shaderString appendFormat:@"\
     uniform sampler2D inputImageTexture;\n\
     \n\
     varying highp vec2 blurCoordinates[%lu];\n\
     \n\
     void main()\n\
     {\n\
     lowp vec4 sum = vec4(0.0);\n", (unsigned long)(blurRadius * 2 + 1) ];
#else
    [shaderString appendFormat:@"\
     uniform sampler2D inputImageTexture;\n\
     \n\
     varying vec2 blurCoordinates[%lu];\n\
     \n\
     void main()\n\
     {\n\
     vec4 sum = vec4(0.0);\n", (blurRadius * 2 + 1) ];
#endif
    
    // Inner texture loop
    for (NSUInteger currentBlurCoordinateIndex = 0; currentBlurCoordinateIndex < (blurRadius * 2 + 1); currentBlurCoordinateIndex++)
    {
        NSInteger offsetFromCenter = currentBlurCoordinateIndex - blurRadius;
        if (offsetFromCenter < 0)
        {
            [shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[%lu]) * %f;\n", (unsigned long)currentBlurCoordinateIndex, standardGaussianWeights[-offsetFromCenter]];
        }
        else
        {
            [shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[%lu]) * %f;\n", (unsigned long)currentBlurCoordinateIndex, standardGaussianWeights[offsetFromCenter]];
        }
    }
    
    // Footer
    [shaderString appendString:@"\
     gl_FragColor = sum;\n\
     }\n"];
    
    free(standardGaussianWeights);
    return shaderString;
}

- (NSString *)vertexShaderForOptimizedBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
{
    if (blurRadius < 1)
    {
        return kGPUImageVertexShaderString;
    }
    
    // First, generate the normal Gaussian weights for a given sigma
    GLfloat *standardGaussianWeights = calloc(blurRadius + 1, sizeof(GLfloat));
    GLfloat sumOfWeights = 0.0;
    for (NSUInteger currentGaussianWeightIndex = 0; currentGaussianWeightIndex < blurRadius + 1; currentGaussianWeightIndex++)
    {
        standardGaussianWeights[currentGaussianWeightIndex] = (1.0 / sqrt(2.0 * M_PI * pow(sigma, 2.0))) * exp(-pow(currentGaussianWeightIndex, 2.0) / (2.0 * pow(sigma, 2.0)));
        
        if (currentGaussianWeightIndex == 0)
        {
            sumOfWeights += standardGaussianWeights[currentGaussianWeightIndex];
        }
        else
        {
            sumOfWeights += 2.0 * standardGaussianWeights[currentGaussianWeightIndex];
        }
    }
    
    // Next, normalize these weights to prevent the clipping of the Gaussian curve at the end of the discrete samples from reducing luminance
    for (NSUInteger currentGaussianWeightIndex = 0; currentGaussianWeightIndex < blurRadius + 1; currentGaussianWeightIndex++)
    {
        standardGaussianWeights[currentGaussianWeightIndex] = standardGaussianWeights[currentGaussianWeightIndex] / sumOfWeights;
    }
    
    // From these weights we calculate the offsets to read interpolated values from
    NSUInteger numberOfOptimizedOffsets = MIN(blurRadius / 2 + (blurRadius % 2), 7);
    GLfloat *optimizedGaussianOffsets = calloc(numberOfOptimizedOffsets, sizeof(GLfloat));
    
    for (NSUInteger currentOptimizedOffset = 0; currentOptimizedOffset < numberOfOptimizedOffsets; currentOptimizedOffset++)
    {
        GLfloat firstWeight = standardGaussianWeights[currentOptimizedOffset*2 + 1];
        GLfloat secondWeight = standardGaussianWeights[currentOptimizedOffset*2 + 2];
        
        GLfloat optimizedWeight = firstWeight + secondWeight;
        
        optimizedGaussianOffsets[currentOptimizedOffset] = (firstWeight * (currentOptimizedOffset*2 + 1) + secondWeight * (currentOptimizedOffset*2 + 2)) / optimizedWeight;
    }
    
    NSMutableString *shaderString = [[NSMutableString alloc] init];
    // Header
    [shaderString appendFormat:@"\
     attribute vec4 position;\n\
     attribute vec4 inputTextureCoordinate;\n\
     \n\
     uniform float texelWidthOffset;\n\
     uniform float texelHeightOffset;\n\
     \n\
     varying vec2 blurCoordinates[%lu];\n\
     \n\
     void main()\n\
     {\n\
     gl_Position = position;\n\
     \n\
     vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);\n", (unsigned long)(1 + (numberOfOptimizedOffsets * 2))];
    
    // Inner offset loop
    [shaderString appendString:@"blurCoordinates[0] = inputTextureCoordinate.xy;\n"];
    for (NSUInteger currentOptimizedOffset = 0; currentOptimizedOffset < numberOfOptimizedOffsets; currentOptimizedOffset++)
    {
        [shaderString appendFormat:@"\
         blurCoordinates[%lu] = inputTextureCoordinate.xy + singleStepOffset * %f;\n\
         blurCoordinates[%lu] = inputTextureCoordinate.xy - singleStepOffset * %f;\n", (unsigned long)((currentOptimizedOffset * 2) + 1), optimizedGaussianOffsets[currentOptimizedOffset], (unsigned long)((currentOptimizedOffset * 2) + 2), optimizedGaussianOffsets[currentOptimizedOffset]];
    }
    
    // Footer
    [shaderString appendString:@"}\n"];
    
    free(optimizedGaussianOffsets);
    free(standardGaussianWeights);
    return shaderString;
}

- (NSString *)fragmentShaderForOptimizedBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
{
    if (blurRadius < 1)
    {
        return kGPUImagePassthroughFragmentShaderString;
    }
    
    // First, generate the normal Gaussian weights for a given sigma
    GLfloat *standardGaussianWeights = calloc(blurRadius + 1, sizeof(GLfloat));
    GLfloat sumOfWeights = 0.0;
    for (NSUInteger currentGaussianWeightIndex = 0; currentGaussianWeightIndex < blurRadius + 1; currentGaussianWeightIndex++)
    {
        standardGaussianWeights[currentGaussianWeightIndex] = (1.0 / sqrt(2.0 * M_PI * pow(sigma, 2.0))) * exp(-pow(currentGaussianWeightIndex, 2.0) / (2.0 * pow(sigma, 2.0)));
        
        if (currentGaussianWeightIndex == 0)
        {
            sumOfWeights += standardGaussianWeights[currentGaussianWeightIndex];
        }
        else
        {
            sumOfWeights += 2.0 * standardGaussianWeights[currentGaussianWeightIndex];
        }
    }
    
    // Next, normalize these weights to prevent the clipping of the Gaussian curve at the end of the discrete samples from reducing luminance
    for (NSUInteger currentGaussianWeightIndex = 0; currentGaussianWeightIndex < blurRadius + 1; currentGaussianWeightIndex++)
    {
        standardGaussianWeights[currentGaussianWeightIndex] = standardGaussianWeights[currentGaussianWeightIndex] / sumOfWeights;
    }
    
    // From these weights we calculate the offsets to read interpolated values from
    NSUInteger numberOfOptimizedOffsets = MIN(blurRadius / 2 + (blurRadius % 2), 7);
    NSUInteger trueNumberOfOptimizedOffsets = blurRadius / 2 + (blurRadius % 2);
    LOG(@"++Init");
    LOG(@"radius: %lu", (unsigned long)blurRadius);
    LOG(@"number: %lu", (unsigned long)numberOfOptimizedOffsets);
    LOG(@"true  : %lu", (unsigned long)trueNumberOfOptimizedOffsets);
    LOG(@"dist  : %f", _distance);
    
    NSMutableString *shaderString = [[NSMutableString alloc] init];

    // Header
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    [shaderString appendFormat:@"\
     uniform sampler2D inputImageTexture;\n\
     uniform highp float texelWidthOffset;\n\
     uniform highp float texelHeightOffset;\n\
     int trueNumberOfOffsets = %lu;\n\
     \n\
     varying highp vec2 blurCoordinates[%lu];\n\
     \n\
     void main()\n\
     {\n\
     mediump float dist = %f;\n\
     mediump float x = blurCoordinates[0].x - 0.5;\n\
     mediump float y = blurCoordinates[0].y - 0.5;\n\
     //mediump float d = sqrt(x * x + y * y) / 0.70710678118 + (dist - 1.0);\n\
     mediump float d = abs(y) * 2.0 + (dist / 2.0 - 1.0);\n\
     mediump float w[%lu];\n\
     mediump float sumOfWeights = 0.0;\n\
     d = 1.0 / (1.0 + pow(3.0, -d * (6.0 - 3.0 * dist)));\n\
     d = %f * d;\n\
     //d = 4.0;\n\
     mediump float radius = floor(d + 0.5);\n\
     if(radius < 1.0){\n\
        gl_FragColor = texture2D(inputImageTexture, blurCoordinates[0]);\n\
        return;\n\
     }\n\
     mediump float calculatedSampleRadius = floor(sqrt(-2.0 * radius * radius * log(1.0 / 256.0 * sqrt(2.0 * 3.14159265359 * radius * radius))));\n\
     calculatedSampleRadius += mod(calculatedSampleRadius, 2.0);\n\
     radius = calculatedSampleRadius;\n\
     int trueNumberOfOffsets = int(floor(radius / 2.0) + mod(radius, 2.0));\n\
     int numberOfOffsets = trueNumberOfOffsets;\n\
     if(numberOfOffsets > 7){\n\
        numberOfOffsets = 7;\n\
     }\n\
     int blurRadiusPlus1 = int(radius) + 1;\n\
     for(int i=0;i<blurRadiusPlus1;i++){\n\
        w[i]=(1.0 / sqrt(2.0 * 3.14159265359 * d * d)) * exp(-float(i * i) / (2.0 * d * d));\n\
        w[i]=min(1.0, w[i]);\n\
        if(i==0){\n\
            sumOfWeights += w[i];\n\
        }else{\n\
            sumOfWeights += 2.0 * w[i];\n\
        }\n\
     }\n\
     mediump float optimizedWeight;\n\
     mediump vec4 sum = vec4(0.0);\n\
     sum += texture2D(inputImageTexture, blurCoordinates[0]) * w[0] / sumOfWeights;\n\
     for(int i=0;i<numberOfOffsets;i++){\n\
        optimizedWeight = (w[i * 2 + 1] + w[i * 2 + 2]) / sumOfWeights;\n\
        sum += texture2D(inputImageTexture, blurCoordinates[i * 2 + 1]) * optimizedWeight;\n\
        sum += texture2D(inputImageTexture, blurCoordinates[i * 2 + 2]) * optimizedWeight;\n\
     }\n\
     if(trueNumberOfOffsets>numberOfOffsets){\n\
        mediump vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);\n\
        mediump float optimizedOffset;\n\
        for(int i=numberOfOffsets;i<trueNumberOfOffsets;i++){\n\
            optimizedWeight = (w[i * 2 + 1] + w[i * 2 + 2]) / sumOfWeights;\n\
            optimizedOffset = (w[i * 2 + 1] * float(i * 2 + 1) + w[i * 2 + 2] * float(i * 2 + 2)) / optimizedWeight;\n\
            sum += texture2D(inputImageTexture, blurCoordinates[0] + singleStepOffset * optimizedOffset) * optimizedWeight;\n\
            sum += texture2D(inputImageTexture, blurCoordinates[0] - singleStepOffset * optimizedOffset) * optimizedWeight;\n\
        }\n\
     }\n\
     ", (unsigned long)trueNumberOfOptimizedOffsets, (unsigned long)(1 + (numberOfOptimizedOffsets * 2)), _distance, (unsigned long)(1 + (numberOfOptimizedOffsets * 2)), _strength];
#else
    [shaderString appendFormat:@"\
     uniform sampler2D inputImageTexture;\n\
     uniform float texelWidthOffset;\n\
     uniform float texelHeightOffset;\n\
     \n\
     varying vec2 blurCoordinates[%lu];\n\
     \n\
     void main()\n\
     {\n\
     vec4 sum = vec4(0.0);\n", 1 + (numberOfOptimizedOffsets * 2) ];
#endif
    /*
    // Inner texture loop
    LOG(@"++Inner Texture Loop");
    [shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[0]) * %f;\n", standardGaussianWeights[0]];
    LOG(@"[%d]: %f", 0, standardGaussianWeights[0]);
    
    for (NSUInteger currentBlurCoordinateIndex = 0; currentBlurCoordinateIndex < numberOfOptimizedOffsets; currentBlurCoordinateIndex++)
    {
        GLfloat firstWeight = standardGaussianWeights[currentBlurCoordinateIndex * 2 + 1];
        GLfloat secondWeight = standardGaussianWeights[currentBlurCoordinateIndex * 2 + 2];
        GLfloat optimizedWeight = firstWeight + secondWeight;
        
        [shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[%lu]) * (w[%lu] + w[%lu + 1]) / sumOfWeights;// * %f;\n", (unsigned long)((currentBlurCoordinateIndex * 2) + 1), (unsigned long)((currentBlurCoordinateIndex * 2) + 1), (unsigned long)((currentBlurCoordinateIndex * 2) + 1), optimizedWeight];
        [shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[%lu]) * (w[%lu] + w[%lu - 1]) / sumOfWeights;// * %f;\n", (unsigned long)((currentBlurCoordinateIndex * 2) + 2), (unsigned long)((currentBlurCoordinateIndex * 2) + 2), (unsigned long)((currentBlurCoordinateIndex * 2) + 2), optimizedWeight];
        
        //[shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[%lu]) * %f;\n", (unsigned long)((currentBlurCoordinateIndex * 2) + 1), optimizedWeight];
        //[shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[%lu]) * %f;\n", (unsigned long)((currentBlurCoordinateIndex * 2) + 2), optimizedWeight];
        LOG(@"[%lu]: %f", (unsigned long)((currentBlurCoordinateIndex * 2) + 1), optimizedWeight);
        LOG(@"[%lu]: %f", (unsigned long)((currentBlurCoordinateIndex * 2) + 2), optimizedWeight);
    }
     
     */
    
    // If the number of required samples exceeds the amount we can pass in via varyings, we have to do dependent texture reads in the fragment shader
    if (trueNumberOfOptimizedOffsets > numberOfOptimizedOffsets)
    {
        LOG(@"++Another Texture Loop");
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
        
        //[shaderString appendFormat:@"\
         mediump vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);\n\
         mediump float optimizedOffset;\n\
         for(int i=numberOfOffsets;i<trueNumberOfOffsets;i++){\n\
            optimizedWeight = (w[i * 2 + 1] + w[i * 2 + 2]) / sumOfWeights;\n\
            optimizedOffset = (w[i * 2 + 1] * float(i * 2 + 1) + w[i * 2 + 2] * float(i * 2 + 2)) / optimizedWeight;\n\
            sum += texture2D(inputImageTexture, blurCoordinates[0] + singleStepOffset * optimizedOffset) * optimizedWeight;\n\
            sum += texture2D(inputImageTexture, blurCoordinates[0] - singleStepOffset * optimizedOffset) * optimizedWeight;\n\
         }\n"];
#else
        [shaderString appendString:@"vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);\n"];
#endif
        
        for (NSUInteger currentOverlowTextureRead = numberOfOptimizedOffsets; currentOverlowTextureRead < trueNumberOfOptimizedOffsets; currentOverlowTextureRead++)
        {
            GLfloat firstWeight = standardGaussianWeights[currentOverlowTextureRead * 2 + 1];
            GLfloat secondWeight = standardGaussianWeights[currentOverlowTextureRead * 2 + 2];
            
            GLfloat optimizedWeight = firstWeight + secondWeight;
            GLfloat optimizedOffset = (firstWeight * (currentOverlowTextureRead * 2 + 1) + secondWeight * (currentOverlowTextureRead * 2 + 2)) / optimizedWeight;
            
            //[shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[0] + singleStepOffset * %f) * %f;\n", optimizedOffset, optimizedWeight];
            //[shaderString appendFormat:@"sum += texture2D(inputImageTexture, blurCoordinates[0] - singleStepOffset * %f) * %f;\n", optimizedOffset, optimizedWeight];
            LOG(@"[%lu]: %f", (unsigned long)((currentOverlowTextureRead * 2) + 1), optimizedWeight);
            LOG(@"[%lu]: %f", (unsigned long)((currentOverlowTextureRead * 2) + 2), optimizedWeight);
        }
    }
    
    // Footer
    [shaderString appendString:@"\
     gl_FragColor = sum;\n\
     }\n"];
    //LOG(@"++Shader");
    //NSLog(@"%@",shaderString);
    free(standardGaussianWeights);
    return shaderString;
}

- (void)setupFilterForSize:(CGSize)filterFrameSize;
{
    [super setupFilterForSize:filterFrameSize];
    
    if (shouldResizeBlurRadiusWithImageSize == YES)
    {
        
    }
}

#pragma mark -
#pragma mark Rendering

- (void)renderToTextureWithVertices:(const GLfloat *)vertices textureCoordinates:(const GLfloat *)textureCoordinates sourceTexture:(GLuint)sourceTexture;
{
    [super renderToTextureWithVertices:vertices textureCoordinates:textureCoordinates sourceTexture:sourceTexture];
    
    for (NSUInteger currentAdditionalBlurPass = 1; currentAdditionalBlurPass < _blurPasses; currentAdditionalBlurPass++)
    {
        [super renderToTextureWithVertices:vertices textureCoordinates:[[self class] textureCoordinatesForRotation:kGPUImageNoRotation] sourceTexture:secondFilterOutputTexture];
    }
}

- (void)switchToVertexShader:(NSString *)newVertexShader fragmentShader:(NSString *)newFragmentShader;
{
    runSynchronouslyOnVideoProcessingQueue(^{
        [GPUImageContext useImageProcessingContext];
        
        filterProgram = [[GPUImageContext sharedImageProcessingContext] programForVertexShaderString:newVertexShader fragmentShaderString:newFragmentShader];
        
        if (!filterProgram.initialized)
        {
            [self initializeAttributes];
            
            if (![filterProgram link])
            {
                NSString *progLog = [filterProgram programLog];
                NSLog(@"Program link log: %@", progLog);
                NSString *fragLog = [filterProgram fragmentShaderLog];
                NSLog(@"Fragment shader compile log: %@", fragLog);
                NSString *vertLog = [filterProgram vertexShaderLog];
                NSLog(@"Vertex shader compile log: %@", vertLog);
                filterProgram = nil;
                NSAssert(NO, @"Filter shader link failed");
            }
        }
        
        filterPositionAttribute = [filterProgram attributeIndex:@"position"];
        filterTextureCoordinateAttribute = [filterProgram attributeIndex:@"inputTextureCoordinate"];
        filterInputTextureUniform = [filterProgram uniformIndex:@"inputImageTexture"]; // This does assume a name of "inputImageTexture" for the fragment shader
        verticalPassTexelWidthOffsetUniform = [filterProgram uniformIndex:@"texelWidthOffset"];
        verticalPassTexelHeightOffsetUniform = [filterProgram uniformIndex:@"texelHeightOffset"];
        [GPUImageContext setActiveShaderProgram:filterProgram];
        
        glEnableVertexAttribArray(filterPositionAttribute);
        glEnableVertexAttribArray(filterTextureCoordinateAttribute);
        
        secondFilterProgram = [[GPUImageContext sharedImageProcessingContext] programForVertexShaderString:newVertexShader fragmentShaderString:newFragmentShader];
        
        if (!secondFilterProgram.initialized)
        {
            [self initializeSecondaryAttributes];
            
            if (![secondFilterProgram link])
            {
                NSString *progLog = [secondFilterProgram programLog];
                NSLog(@"Program link log: %@", progLog);
                NSString *fragLog = [secondFilterProgram fragmentShaderLog];
                NSLog(@"Fragment shader compile log: %@", fragLog);
                NSString *vertLog = [secondFilterProgram vertexShaderLog];
                NSLog(@"Vertex shader compile log: %@", vertLog);
                secondFilterProgram = nil;
                NSAssert(NO, @"Filter shader link failed");
            }
        }
        
        secondFilterPositionAttribute = [secondFilterProgram attributeIndex:@"position"];
        secondFilterTextureCoordinateAttribute = [secondFilterProgram attributeIndex:@"inputTextureCoordinate"];
        secondFilterInputTextureUniform = [secondFilterProgram uniformIndex:@"inputImageTexture"]; // This does assume a name of "inputImageTexture" for the fragment shader
        secondFilterInputTextureUniform2 = [secondFilterProgram uniformIndex:@"inputImageTexture2"]; // This does assume a name of "inputImageTexture2" for second input texture in the fragment shader
        horizontalPassTexelWidthOffsetUniform = [secondFilterProgram uniformIndex:@"texelWidthOffset"];
        horizontalPassTexelHeightOffsetUniform = [secondFilterProgram uniformIndex:@"texelHeightOffset"];
        [GPUImageContext setActiveShaderProgram:secondFilterProgram];
        
        glEnableVertexAttribArray(secondFilterPositionAttribute);
        glEnableVertexAttribArray(secondFilterTextureCoordinateAttribute);
        
        [self setupFilterForSize:[self sizeOfFBO]];
        glFinish();
    });
    
}

#pragma mark -
#pragma mark Accessors

- (void)setTexelSpacingMultiplier:(CGFloat)newValue;
{
    _texelSpacingMultiplier = newValue;
    
    _verticalTexelSpacing = _texelSpacingMultiplier;
    _horizontalTexelSpacing = _texelSpacingMultiplier;
    
    [self setupFilterForSize:[self sizeOfFBO]];
}

- (void)setDistance:(CGFloat)distance
{
    _distance = distance;
}

- (void)setStrength:(CGFloat)strength
{
    _strength = strength;
    _strength = 1.0 + _strength * 10.0f;
    self.blurRadiusInPixels = 20.0f;
}

// inputRadius for Core Image's CIGaussianBlur is really sigma in the Gaussian equation, so I'm using that for my blur radius, to be consistent
- (void)setBlurRadiusInPixels:(CGFloat)newValue;
{
    // 7.0 is the limit for blur size for hardcoded varying offsets
    
    if (round(newValue) != _blurRadiusInPixels)
    {
        _blurRadiusInPixels = round(newValue); // For now, only do integral sigmas
        
        // Calculate the number of pixels to sample from by setting a bottom limit for the contribution of the outermost pixel
        CGFloat minimumWeightToFindEdgeOfSamplingArea = 1.0/256.0;
        NSUInteger calculatedSampleRadius = floor(sqrt(-2.0 * pow(_blurRadiusInPixels, 2.0) * log(minimumWeightToFindEdgeOfSamplingArea * sqrt(2.0 * M_PI * pow(_blurRadiusInPixels, 2.0))) ));
        calculatedSampleRadius += calculatedSampleRadius % 2; // There's nothing to gain from handling odd radius sizes, due to the optimizations I use
        
        //        NSLog(@"Blur radius: %f, calculated sample radius: %d", _blurRadiusInPixels, calculatedSampleRadius);
        //
        NSString *newGaussianBlurVertexShader = [self vertexShaderForOptimizedBlurOfRadius:calculatedSampleRadius sigma:_blurRadiusInPixels];
        NSString *newGaussianBlurFragmentShader = [self fragmentShaderForOptimizedBlurOfRadius:calculatedSampleRadius sigma:_blurRadiusInPixels];
        
        //        NSLog(@"Optimized vertex shader: \n%@", newGaussianBlurVertexShader);
        //        NSLog(@"Optimized fragment shader: \n%@", newGaussianBlurFragmentShader);
        //
        [self switchToVertexShader:newGaussianBlurVertexShader fragmentShader:newGaussianBlurFragmentShader];
    }
    shouldResizeBlurRadiusWithImageSize = NO;
}

@end
