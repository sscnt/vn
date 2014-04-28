//
//  GPUEffectVividVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectVividVintage.h"

@implementation VnEffectVividVintage

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdVividVintage;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Contrast
    @autoreleasepool {
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.20f;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:contrastFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Saturation
    @autoreleasepool {
        GPUImageSaturationFilter* saturationFilter = [[GPUImageSaturationFilter alloc] init];
        saturationFilter.saturation = 1.12f;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:saturationFilter opacity:0.20f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vvv1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.50f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vvv2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.75f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vvv3"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.50f blendingMode:VnBlendingModeSoftLight];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
