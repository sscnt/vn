//
//  GPUEffectGoodMorning.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/26.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectGoodMorning.h"

@implementation VnEffectGoodMorning

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 1.0f;
        self.effectId = VnEffectIdGoodMorning;
    }
    return self;
}


- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"mo1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f;
        shadows.two = 0.0f;
        shadows.three = 0.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = -25.0f/255.0f;
        midtones.two = 0.0f;
        midtones.three = 24.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f;
        highlights.two = 0.0f;
        highlights.three = 0.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:0.90f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"mo2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Duplicate
    @autoreleasepool {
        
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:255.0f/255.0f green:204.0f/255.0f blue:153.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.31f blendingMode:VnBlendingModeMultiply];
        
        UIImage* solidImage = [VnCurrentImage tmpImage];
        
        
        [self mergeAndSaveTmpImageWithOverlayImage:solidImage opacity:0.69f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"mo3"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Gradient Map
    @autoreleasepool {
        VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
        [gradientMap addColorRed:58.0f Green:62.0f Blue:124.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:251.0f Green:215.0f Blue:107.0f Opacity:100.0f Location:4096 Midpoint:60];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientMap opacity:0.48f blendingMode:VnBlendingModeSoftLight];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:207.0f Green:147.0f Blue:155.0f Opacity:1.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    }
    return [VnCurrentImage tmpImage];
}
    
@end
