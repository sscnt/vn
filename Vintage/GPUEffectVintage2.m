//
//  GPUEffectVIntage2.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/23.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectVintage2.h"

@implementation GPUEffectVintage2

- (UIImage*)process
{
    self.effectId = EffectIdVintage2;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Vintage21"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.70f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleLinear];
        [gradientColor setAngleDegree:-137];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:151.0f Green:70.0f Blue:26.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:251.0f Green:216.0f Blue:197.0f Opacity:100.0f Location:1229 Midpoint:50];
        [gradientColor addColorRed:108.0f Green:46.0f Blue:22.0f Opacity:100.0f Location:3400 Midpoint:50];
        [gradientColor addColorRed:239.0f Green:219.0f Blue:205.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.49f blendingMode:MergeBlendingModeSoftLight];
    }
    
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:mixerFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Vintage22"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:113.0f/255.0f green:202.0f/255.0f blue:96.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.49 blendingMode:MergeBlendingModeOverlay];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:148.0f/255.0f green:111.0f/255.0f blue:102.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.50f blendingMode:MergeBlendingModeHue];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:2.0f/255.0f green:12.0f/255.0f blue:39.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.54f blendingMode:MergeBlendingModeExclusion];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:63];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:230.0f Green:193.0f Blue:76.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:197.0f Green:158.0f Blue:111.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.48 blendingMode:MergeBlendingModeMultiply];
    }
    
    return resultImage;
}

@end
