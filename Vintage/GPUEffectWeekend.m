//
//  GPUEffectWeekend.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/28.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectWeekend.h"

@implementation GPUEffectWeekend

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
    }
    return self;
}

- (UIImage*)process
{
    self.effectId = EffectIdWeekend;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Hue / Saturation
    @autoreleasepool {
        GPUImageHueSaturationFilter* hueSaturation = [[GPUImageHueSaturationFilter alloc] init];
        hueSaturation.hue = 0.0f;
        hueSaturation.saturation = 3.0f;
        hueSaturation.lightness = -4.0;
        hueSaturation.colorize = NO;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:hueSaturation opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:10.0f/255.0f gamma:1.10f max:250.0f/255.0f minOut:0.0f maxOut:255.0f/255.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:levelsFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:15.0f/255.0f green:35.0f/255.0f blue:65.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:1.0f blendingMode:MergeBlendingModeExclusion];
    }
    
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:1.0f];
        [levelsFilter setRedMin:20.0f/255.0f gamma:1.30f max:240.0f/255.0f minOut:0.0f maxOut:255.0f/255.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:levelsFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }

    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:20.0f/255.0f gamma:0.90f max:220.0f/255.0f minOut:0.0f maxOut:255.0f/255.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:levelsFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Color Balance
    @autoreleasepool {
        GPUImageColorBalanceFilter* colorBalance = [[GPUImageColorBalanceFilter alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f;
        shadows.two = 0.0f;
        shadows.three = 0.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 0.0f/255.0f;
        midtones.two = 30.0f/255.0f;
        midtones.three = 0.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f/255.0f;
        highlights.two = 0.0f/255.0f;
        highlights.three = 0.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:0.50f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Brightness
    @autoreleasepool {
        GPUImageBrightnessFilter* brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        brightnessFilter.brightness = 0.05f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:brightnessFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:10.0f/255.0f green:5.0f/255.0f blue:50.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.70f blendingMode:MergeBlendingModeExclusion];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.30f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.15f blendingMode:MergeBlendingModeColorBurn];
    }
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"wnd"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.35f blendingMode:MergeBlendingModeNormal];
    }
    return resultImage;
    
}

@end
