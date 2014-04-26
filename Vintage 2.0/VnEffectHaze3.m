//
//  GPUHaze3Effect.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectHaze3.h"

@implementation VnEffectHaze3

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdHaze3;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];

    // Fill
    @autoreleasepool {
        GPUImageSolidColorGenerator* solid = [[GPUImageSolidColorGenerator alloc] init];
        [solid setColorRed:5.0f/255.0f green:23.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solid opacity:1.0 blendingMode:VnBlendingModeExclusion];
    }

    return [VnCurrentImage tmpImage];
}

@end
