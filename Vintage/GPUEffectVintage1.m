//
//  GPUEffectVintage1.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/23.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectVintage1.h"

@implementation GPUEffectVintage1

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;

    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:237.0f/255.0f green:215.0f/255.0f blue:128.0f/255.0 alpha:1.0f];

        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.51f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:12.0f/255.0f blue:27.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:1.0f blendingMode:MergeBlendingModeExclusion];
    }

    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:0 Magenta:0 Yellow:3 Black:0];
        [selectiveColor setYellowsCyan:-100 Magenta:43 Yellow:-50 Black:0];
        [selectiveColor setGreensCyan:1 Magenta:-1 Yellow:-1 Black:0];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:selectiveColor];
        [pictureOriginal processImage];
        resultImage = [selectiveColor imageFromCurrentlyProcessedOutput];
    }
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:-10 Green:12 Blue:94 Constant:0];

        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:mixerFilter];
        [pictureOriginal processImage];
        resultImage = [mixerFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:115.0f/255.0f green:115.0f/255.0f blue:115.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:1.0f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:10 Magenta:2 Yellow:2 Black:0];
        [selectiveColor setYellowsCyan:25 Magenta:-5 Yellow:-9 Black:0];
        [selectiveColor setWhitesCyan:0 Magenta:0 Yellow:-3 Black:0];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:selectiveColor];
        [pictureOriginal processImage];
        resultImage = [selectiveColor imageFromCurrentlyProcessedOutput];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Vintage11"];
        
        GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:resultImage];
        [picture addTarget:curveFilter];
        [picture processImage];
        resultImage = [curveFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:94.0f Green:76.0f Blue:62.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:179.0f Green:169.0f Blue:139.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:1.0f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Vintage12"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.60f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:25 Magenta:0 Yellow:5 Black:0];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:selectiveColor];
        [pictureOriginal processImage];
        resultImage = [selectiveColor imageFromCurrentlyProcessedOutput];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:191.0f/255.0f green:124.0f/255.0f blue:19.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.46f blendingMode:MergeBlendingModeHue];
    }
    
    // Hue / Saturation
    @autoreleasepool {
        GPUImageHueSaturationFilter* hueSaturation = [[GPUImageHueSaturationFilter alloc] init];
        hueSaturation.hue = 34.0f;
        hueSaturation.saturation = 27.0f;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:hueSaturation opacity:0.20f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:44];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:78.0f Green:70.0f Blue:16.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.48f blendingMode:MergeBlendingModeSoftLight];
    }
    

    return resultImage;
}

@end
