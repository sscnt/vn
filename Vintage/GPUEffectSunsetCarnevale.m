//
//  GPUEffectSunsetCarnevale.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectSunsetCarnevale.h"

@implementation GPUEffectSunsetCarnevale

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.faceOpacity = 0.50f;
    }
    return self;
}

- (UIImage*)process
{
    self.effectId = EffectIdSunsetCarnevale;
    
    UIImage* resultImage = self.imageToProcess;
    UIImage* solidImage = self.imageToProcess;
    
    // Contrast
    @autoreleasepool {
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.20f;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:contrastFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"sc1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Gradient Map
    @autoreleasepool {
        GPUImageGradientMapFilter* gradientMap = [[GPUImageGradientMapFilter alloc] init];
        [gradientMap addColorRed:9.0f Green:0.0f Blue:178.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:255.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:2048 Midpoint:50];
        [gradientMap addColorRed:255.0f Green:252.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientMap opacity:0.50f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:6.0f/255.0f green:32.0f/255.0f blue:63.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:1.0f blendingMode:MergeBlendingModeExclusion];
    }
    
    resultImage = [self mergeBaseImage:resultImage overlayImage:solidImage opacity:1.0f blendingMode:MergeBlendingModeSoftLight];
    
    return resultImage;
}

@end
