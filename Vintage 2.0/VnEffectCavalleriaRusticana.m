//
//  GPUEffectCavalleriaRusticana.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectCavalleriaRusticana.h"

@implementation VnEffectCavalleriaRusticana

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.90f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdCavalleriaRusticana;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Blur
    @autoreleasepool {
        GPUImageGaussianBlurFilter* blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 10.0f;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:blurFilter opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"cr1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:7.0f/255.0f green:37.0f/255.0f blue:61.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:1.0f blendingMode:VnBlendingModeExclusion];
    }
    
    // Hue / Saturation
    @autoreleasepool {
        VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
        hueSaturation.hue = 216.0f;
        hueSaturation.saturation = 25.0f;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:hueSaturation opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
