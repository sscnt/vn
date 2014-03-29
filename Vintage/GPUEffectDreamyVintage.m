//
//  GPUEffectDreamyVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectDreamyVintage.h"

@implementation GPUEffectDreamyVintage

- (UIImage*)process
{
    self.effectId = EffectIdDreamyVintage;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Brightness
    @autoreleasepool {
        GPUImageBrightnessFilter* brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        brightnessFilter.brightness = 0.06f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:brightnessFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Contrast
    @autoreleasepool {
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.08f;
        
        //resultImage = [self mergeBaseImage:resultImage overlayFilter:contrastFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Gradient Map
    @autoreleasepool {
        GPUImageGradientMapFilter* gradientMap = [[GPUImageGradientMapFilter alloc] init];
        [gradientMap addColorRed:111.0f Green:21.0f Blue:108.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:253.0f Green:124.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientMap opacity:1.0f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Saturation
    @autoreleasepool {
        GPUImageSaturationFilter* saturationFilter = [[GPUImageSaturationFilter alloc] init];
        saturationFilter.saturation = 0.64f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:saturationFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"dv1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    return resultImage;
}

@end
