//
//  GPUEffectVintageFilm.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/17.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectVintageFilm.h"

@implementation GPUEffectVintageFilm


- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 0.80f;
        self.effectId = EffectIdVintageFilm;
    }
    return self;
}

- (UIImage*)process
{
    
    UIImage* resultImage = self.imageToProcess;
    

    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vf"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }

    // Hue/Saturation
    @autoreleasepool {
        GPUImageHueSaturationFilter* hueSaturation = [[GPUImageHueSaturationFilter alloc] init];
        hueSaturation.hue = 35.0f;
        hueSaturation.saturation = 25.0f;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:hueSaturation opacity:0.50f blendingMode:MergeBlendingModeNormal];
    }    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:236.0f/255.0f green:0.0f blue:139.0f/255.0f alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.10f blendingMode:MergeBlendingModeScreen];
    }
    
    return resultImage;
}

@end
