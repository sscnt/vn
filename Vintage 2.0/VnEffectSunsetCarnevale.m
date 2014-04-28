//
//  GPUEffectSunsetCarnevale.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectSunsetCarnevale.h"

@implementation VnEffectSunsetCarnevale

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.faceOpacity = 0.50f;
        self.effectId = VnEffectIdSunsetCarnevale;
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
        
        [self mergeAndSaveTmpImageWithOverlayFilter:contrastFilter opacity:1.0f blendingMode:VnBlendingModeMultiply];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"sc1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Gradient Map
    @autoreleasepool {
        VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
        [gradientMap addColorRed:9.0f Green:0.0f Blue:178.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:255.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:2048 Midpoint:50];
        [gradientMap addColorRed:255.0f Green:252.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientMap opacity:0.50f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:6.0f/255.0f green:32.0f/255.0f blue:63.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:1.0f blendingMode:VnBlendingModeExclusion];
    }
    
    [self mergeAndSaveTmpImageWithOverlayImage:[VnCurrentImage tmpImage] opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    
    return [VnCurrentImage tmpImage];
}

@end
