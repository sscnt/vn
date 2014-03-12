//
//  GPUImageAllAdjustmentsInOneFilter.m
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUImageAllAdjustmentsInOneFilter.h"
#import "GPUImageFilter.h"
#import "GPUImageTwoInputFilter.h"
#import "GPUImageGaussianBlurFilter.h"

#define GammaCorrection(color, gamma)								pow(color, 1.0 / gamma)

/*
 ** Levels control (input (+gamma), output)
 ** Details: http://blog.mouaif.org/2009/01/28/levels-control-shader/
 */

#define LevelsControlInputRange(color, minInput, maxInput)				min(max(color - minInput, vec3(0.0)) / (maxInput - minInput), vec3(1.0))
#define LevelsControlInput(color, minInput, gamma, maxInput)				GammaCorrection(LevelsControlInputRange(color, minInput, maxInput), gamma)
#define LevelsControlOutputRange(color, minOutput, maxOutput) 			mix(minOutput, maxOutput, color)
#define LevelsControl(color, minInput, gamma, maxInput, minOutput, maxOutput) 	LevelsControlOutputRange(LevelsControlInput(color, minInput, gamma, maxInput), minOutput, maxOutput)


#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageAllAdjustmentsInOneFilterFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 uniform mediump float brightness;
 uniform mediump float clarityIntensity;
 uniform mediump vec3 levelsMin;
 uniform mediump vec3 levelsMid;
 uniform mediump vec3 levelsMax;
 uniform mediump vec3 levelsMinOutput;
 uniform mediump vec3 levelsMaxOutput;
 uniform mediump float contrast;
 
 
 mediump vec3 rgb2yuv(mediump vec3 rgb){
     mediump float r = rgb.r * 0.8588 + 0.0625;
     mediump float g = rgb.g * 0.8588 + 0.0625;
     mediump float b = rgb.b * 0.8588 + 0.0625;
     
     mediump float y = 0.299 * r + 0.587 * g + 0.114 * b;
     mediump float u = -0.169 * r - 0.331 * g + 0.500 * b;
     mediump float v = 0.500 * r - 0.419 * g - 0.081 * b;
     return mediump vec3(y, u, v);
 }
 
 mediump vec3 yuv2rgb(mediump vec3 yuv){
     mediump float r = yuv.x + 1.402 * yuv.z - 0.0625;
     mediump float g = yuv.x - 0.344 * yuv.y - 0.714 * yuv.z - 0.0625;
     mediump float b = yuv.x + 1.772 * yuv.y - 0.0625;
     
     r *= 1.164;
     g *= 1.164;
     b *= 1.164;
     
     r = max(0.0, min(1.0, r));
     g = max(0.0, min(1.0, g));
     b = max(0.0, min(1.0, b));
     return mediump vec3(r, g, b);
 }

 
 void main()
 {
     mediump vec4 basePixel = texture2D(inputImageTexture, textureCoordinate);
     mediump vec3 blurredImageColor = texture2D(inputImageTexture2, textureCoordinate2).rgb;
     
     mediump vec3 pixel = basePixel.rgb;
     mediump vec3 yuv;
     mediump vec3 tmpvec;
     mediump float lum;
     mediump float tmp;
     mediump float weight;
     
     //// Clarity
     if(clarityIntensity != 0.0){
         pixel = vec3(basePixel.rgb * clarityIntensity + blurredImageColor * (1.0 - clarityIntensity));
         if(basePixel.r < pixel.r){
             pixel.r = basePixel.r;
         }
         if(basePixel.g < pixel.g){
             pixel.g = basePixel.g;
         }
         if(basePixel.b < pixel.b){
             pixel.b = basePixel.b;
         }
     }

     //// Brightness
     if(brightness != 0.0){
         yuv = rgb2yuv(pixel.rgb);
         lum = yuv.x;
         yuv.x += brightness;
         if(yuv.x > 1.0){
             yuv.x = 1.0;
         }else if(yuv.x < 0.0){
             yuv.x = 0.0;
         }
         if(brightness > 0.0){
             pixel.r = pow(pixel.r / lum, 0.6) * yuv.x;
             pixel.g = pow(pixel.g / lum, 0.6) * yuv.x;
             pixel.b = pow(pixel.b / lum, 0.6) * yuv.x;
         }else{
             pixel.rgb = yuv2rgb(yuv);
         }
     }
     
     //// Levels
     if(levelsMid.x < 0.99 || levelsMid.x > 1.01){
         yuv = rgb2yuv(pixel.rgb);
         lum = yuv.x;
         tmp = lum - 0.3;
         if(tmp < 0.0){
             tmp = 0.0;
         }
         weight = 1.0 - pow(tmp, 5.0);
         tmpvec = LevelsControl(pixel, levelsMin, levelsMid, levelsMax, levelsMinOutput, levelsMaxOutput);
         if(levelsMid.x > 1.0){
             yuv = rgb2yuv(tmpvec);
             
             tmpvec.r = pow(pixel.r / lum, 0.6) * yuv.x;
             tmpvec.g = pow(pixel.g / lum, 0.6) * yuv.x;
             tmpvec.b = pow(pixel.b / lum, 0.6) * yuv.x;
             
             pixel.r = weight * tmpvec.r + (1.0 - weight) * pixel.r;
             pixel.g = weight * tmpvec.g + (1.0 - weight) * pixel.g;
             pixel.b = weight * tmpvec.b + (1.0 - weight) * pixel.g;
         }else{
             pixel = tmpvec;
         }
     }
     
     //// Contrast
     if(contrast != 1.0){
         pixel = vec3(((pixel.rgb - vec3(0.5)) * contrast + vec3(0.5)));
     }

     gl_FragColor = vec4(pixel, basePixel.a);
 }
 );
#else
#endif

@implementation GPUImageAllAdjustmentsInOneFilter

- (id)init;
{
    if (!(self = [super init]))
    {
		return nil;
    }
    
    // First pass: apply a variable Gaussian blur
    blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    [self addFilter:blurFilter];
    
    // Second pass: combine the blurred image with the original sharp one
    unsharpMaskFilter = [[GPUImageTwoInputFilter alloc] initWithFragmentShaderFromString:kGPUImageAllAdjustmentsInOneFilterFragmentShaderString];
    [self addFilter:unsharpMaskFilter];
    
    // Texture location 0 needs to be the sharp image for both the blur and the second stage processing
    [blurFilter addTarget:unsharpMaskFilter atTextureLocation:1];
    
    self.initialFilters = [NSArray arrayWithObjects:blurFilter, unsharpMaskFilter, nil];
    self.terminalFilter = unsharpMaskFilter;
    
    //// Brightness
    self.brightness = 0.0f;
    
    //// Clarity
    self.clarityIntensity = 0.0f;
    self.clarityBlurRadiusInPixels = 40.0f;
    
    //// Levels
    [self setLevelsRedMin:0.0 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [self setLevelsGreenMin:0.0 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [self setLevelsBlueMin:0.0 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    
    //// Contrast
    self.contrast = 1.0f;
    
    return self;
}

#pragma mark Brightness
- (void)setBrightness:(CGFloat)brightness
{
    _brightness = brightness;
    [unsharpMaskFilter setFloat:brightness forUniformName:@"brightness"];
}

#pragma mark Clarity
- (void)setClarityBlurRadiusInPixels:(CGFloat)clarityBlurRadiusInPixels
{
    blurFilter.blurRadiusInPixels = clarityBlurRadiusInPixels;
}

- (CGFloat)clarityBlurRadiusInPixels
{
    return blurFilter.blurRadiusInPixels;
}

- (void)setClarityIntensity:(CGFloat)clarityIntensity
{
    _clarityIntensity = clarityIntensity;
    [unsharpMaskFilter setFloat:clarityIntensity forUniformName:@"clarityIntensity"];
}

#pragma mark Levels
- (void)updateUniforms {
    [unsharpMaskFilter setFloatVec3:levelsMinVector forUniformName:@"levelsMin"];
    [unsharpMaskFilter setFloatVec3:levelsMidVector forUniformName:@"levelsMid"];
    [unsharpMaskFilter setFloatVec3:levelsMaxVector forUniformName:@"levelsMax"];
    [unsharpMaskFilter setFloatVec3:levelsMinOutputVector forUniformName:@"levelsMinOutput"];
    [unsharpMaskFilter setFloatVec3:levlesMaxOutputVector forUniformName:@"levelsMaxOutput"];
}

- (void)setLevelsMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut {
    [self setLevelsRedMin:min gamma:mid max:max minOut:minOut maxOut:maxOut];
    [self setLevelsGreenMin:min gamma:mid max:max minOut:minOut maxOut:maxOut];
    [self setLevelsBlueMin:min gamma:mid max:max minOut:minOut maxOut:maxOut];
}

- (void)setLevelsMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max {
    [self setLevelsMin:min gamma:mid max:max minOut:0.0 maxOut:1.0];
}

- (void)setLevelsRedMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut {
    levelsMinVector.one = min;
    levelsMidVector.one = mid;
    levelsMaxVector.one = max;
    levelsMinOutputVector.one = minOut;
    levlesMaxOutputVector.one = maxOut;
    
    [self updateUniforms];
}

- (void)setLevelsRedMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max {
    [self setLevelsRedMin:min gamma:mid max:max minOut:0.0 maxOut:1.0];
}

- (void)setLevelsGreenMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut {
    levelsMinVector.two = min;
    levelsMidVector.two = mid;
    levelsMaxVector.two = max;
    levelsMinOutputVector.two = minOut;
    levlesMaxOutputVector.two = maxOut;
    
    [self updateUniforms];
}

- (void)setLevelsGreenMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max {
    [self setLevelsGreenMin:min gamma:mid max:max minOut:0.0 maxOut:1.0];
}

- (void)setLevelsBlueMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max minOut:(CGFloat)minOut maxOut:(CGFloat)maxOut {
    levelsMinVector.three = min;
    levelsMidVector.three = mid;
    levelsMaxVector.three = max;
    levelsMinOutputVector.three = minOut;
    levlesMaxOutputVector.three = maxOut;
    
    [self updateUniforms];
}

- (void)setLevelsBlueMin:(CGFloat)min gamma:(CGFloat)mid max:(CGFloat)max {
    [self setLevelsBlueMin:min gamma:mid max:max minOut:0.0 maxOut:1.0];
}

#pragma mark Contrast

- (void)setContrast:(CGFloat)newValue;
{
    _contrast = newValue;
    [unsharpMaskFilter setFloat:newValue forUniformName:@"contrast"];
}


@end
