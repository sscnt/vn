//
//  GPUEffectGirder.m
//  Gravy_1.0
//
//  Created by SSC on 2014/01/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGirder.h"

@implementation VnEffectGirder

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.90f;
        self.faceOpacity = 0.70f;
        self.effectId = VnEffectIdGirder;
    }
    return self;
}

- (UIImage*)process
{
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Paind Daubs
    @autoreleasepool {
        GPUImageSharpenFilter* unsharp = [[GPUImageSharpenFilter alloc] init];
        unsharp.sharpness = 0.5f * [VnCurrentImage tmpImageAndOriginalImageRatio];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:unsharp opacity:1.0f blendingMode:VnBlendingModeNormal];
    }

    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gi1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Hue / Saturation
    @autoreleasepool {
        VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
        hueSaturation.hue = 0.0f;
        hueSaturation.saturation = -15.0f;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize =  NO;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:hueSaturation opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gi2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Photo Filter
    @autoreleasepool {
        VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
        [photoFilter setColorRed:s255(255.0f) Green:s255(213.0f) Blue:s255(0.0f)];
        photoFilter.density = 0.10f;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:photoFilter opacity:0.25 blendingMode:VnBlendingModeNormal];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:1.0f blendingMode:VnBlendingModeLighten];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gi3"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
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
        midtones.one = -10.0f/255.0f;
        midtones.two = 0.0f/255.0f;
        midtones.three = 30.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f/255.0f;
        highlights.two = 0.0f/255.0f;
        highlights.three = 0.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
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
        midtones.one = 45.0f/255.0f;
        midtones.two = 0.0f/255.0f;
        midtones.three = -60.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f/255.0f;
        highlights.two = 0.0f/255.0f;
        highlights.three = 0.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gi4"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:5.0f/255.0f gamma:1.05f max:255.0f/255.0f minOut:5.0/255.0f maxOut:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:levelsFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Gradient Map
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientMap = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientMap addColorRed:28.0f Green:64.0f Blue:100.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:14.0f Green:37.0f Blue:68.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientMap opacity:0.25f blendingMode:VnBlendingModeExclusion];
    }
    
    return [VnCurrentImage tmpImage];
    
}




@end
