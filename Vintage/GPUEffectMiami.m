//
//  GPUEffectMiami.m
//  Gravy_1.0
//
//  Created by SSC on 2014/01/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUEffectMiami.h"

@implementation GPUEffectMiami

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;
    
    
    
    // Hue / Saturation
    @autoreleasepool {
        GPUImageHueSaturationFilter* hueSaturation = [[GPUImageHueSaturationFilter alloc] init];
        hueSaturation.hue = 0.0f;
        hueSaturation.saturation = 10.0f;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize =  NO;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:hueSaturation opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }

    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:5.0f/255.0f gamma:1.05f max:250.0f/255.0f minOut:0.0f maxOut:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:levelsFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.50f blendingMode:MergeBlendingModeOverlay];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:130];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.50f blendingMode:MergeBlendingModeOverlay];
    }
    // Contrast
    @autoreleasepool {
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.03f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:contrastFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Miami1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Miami2"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }

    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:0.0f/255.0f gamma:0.95f max:255.0f/255.0f minOut:0.0f maxOut:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:levelsFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:0.0f/255.0f gamma:1.0f max:255.0f/255.0f minOut:0.0f maxOut:1.0f];
        [levelsFilter setBlueMin:0.0f/255.0f gamma:0.95f max:255.0f/255.0f minOut:0.0f maxOut:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:levelsFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Miami3"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.90f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:30.0f/255.0f green:30.0f/255.0f blue:30.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:1.0f blendingMode:MergeBlendingModeLighten];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:189.0f/255.0f green:189.0f/255.0f blue:0.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.15f blendingMode:MergeBlendingModeMultiply];
    }
    
    // Contrast
    @autoreleasepool {
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 0.97;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:contrastFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    return resultImage;
    
}



@end
