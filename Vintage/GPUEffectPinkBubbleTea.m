//
//  GPUEffectPinkBubbleTea.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectPinkBubbleTea.h"

@implementation GPUEffectPinkBubbleTea

- (UIImage*)process
{
    self.effectId = EffectIdPinkBubbleTea;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:177.0f/255.0f green:81.0f/255.0f blue:161.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.25f blendingMode:MergeBlendingModeLighten];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"pbt"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:251.0f/255.0f green:223.0f/255.0f blue:109.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.32f blendingMode:MergeBlendingModeMultiply];
    }
    
    return resultImage;
}

@end
