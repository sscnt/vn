//
//  GPUEffectBeachVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectBeachVintage.h"

@implementation GPUEffectBeachVintage

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;
    UIImage* solidImage = self.imageToProcess;
    
    // Duplicate
    @autoreleasepool {
        resultImage = [self mergeBaseImage:resultImage overlayImage:resultImage opacity:0.40f blendingMode:MergeBlendingModeOverlay];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:219.0f/255.0f green:221.0f/255.0f blue:179.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.20f blendingMode:MergeBlendingModeHardLight];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:251.0f/255.0f green:255.0f/255.0f blue:221.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.69f blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:6.0f/255.0f green:0.0f/255.0f blue:255.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.30f blendingMode:MergeBlendingModeExclusion];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:255.0f/255.0f green:121.0f/255.0f blue:151.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.15f blendingMode:MergeBlendingModeLinearDodge];
    }
    
    // Duplicate
    @autoreleasepool {
        resultImage = [self mergeBaseImage:resultImage overlayImage:solidImage opacity:0.40f blendingMode:MergeBlendingModeOverlay];
    }
    
    return resultImage;
}

@end
