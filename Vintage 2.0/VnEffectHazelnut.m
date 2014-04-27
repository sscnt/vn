//
//  GPUEffectHazelnut.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/22.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectHazelnut.h"

@implementation VnEffectHazelnut

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdHazelnut;
    }
    return self;
}


- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];

    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Hzl1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.50f blendingMode:VnBlendingModeNormal];
    }
    
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:8.0f/255.0f blue:28.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.80f blendingMode:VnBlendingModeExclusion];
    }
    
    // Gradient
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleLinear];
        [gradientColor setAngleDegree:-125];
        [gradientColor setScalePercent:100];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:159.0f Green:132.0f Blue:75.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:128.0f Green:123.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    }
    
    
    // Gradient
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:55];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:2.0f Y:-4.0f];
        [gradientColor addColorRed:255.0f Green:229.0f Blue:183.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:128.0f Green:123.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.38f blendingMode:VnBlendingModeOverlay];
    }

    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f;
        shadows.two = 0.0f;
        shadows.three = 0.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 5.0f/255.0f;
        midtones.two = -2.0f/255.0f;
        midtones.three = -2.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 2.0f/255.0f;
        highlights.two = -2.0f/255.0f;
        highlights.three = -10.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:50.0f/255.0f blue:175.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.05f blendingMode:VnBlendingModeColor];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:177.0f/255.0f green:176.0f/255.0f blue:3.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.1f blendingMode:VnBlendingModeHue];
    }
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Hzl2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    /*
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.15f blendingMode:MergeBlendingModeHue];
    }
    */
    
    return [VnCurrentImage tmpImage];
}

@end
