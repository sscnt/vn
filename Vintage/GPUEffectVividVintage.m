//
//  GPUEffectVividVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectVividVintage.h"

@implementation GPUEffectVividVintage

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.faceOpacity = 0.60f;
    }
    return self;
}

- (UIImage*)process
{
    self.effectId = EffectIdVividVintage;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Contrast
    @autoreleasepool {
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.20f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:contrastFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Saturation
    @autoreleasepool {
        GPUImageSaturationFilter* saturationFilter = [[GPUImageSaturationFilter alloc] init];
        saturationFilter.saturation = 1.12f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:saturationFilter opacity:0.20f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vvv1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.50f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vvv2"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.75f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vvv3"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.50f blendingMode:MergeBlendingModeSoftLight];
    }
    
    return resultImage;
}

@end
