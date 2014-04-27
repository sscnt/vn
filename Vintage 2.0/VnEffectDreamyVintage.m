//
//  GPUEffectDreamyVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectDreamyVintage.h"

@implementation VnEffectDreamyVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdDreamyVintage;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];

    
    // Gradient Map
    @autoreleasepool {
        VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
        [gradientMap addColorRed:111.0f Green:21.0f Blue:108.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:253.0f Green:124.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientMap opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Saturation
    @autoreleasepool {
        VnAdjustmentLayerHueSaturation* saturationFilter = [[VnAdjustmentLayerHueSaturation alloc] init];
        saturationFilter.saturation = 0.64f;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:saturationFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"dv1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
