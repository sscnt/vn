//
//  GPUEffectCreamyNoon.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectCreamyNoon.h"

@implementation VnEffectCreamyNoon

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdCreamyNoon;
    }
    return self;
}

- (UIImage*)process
{
    
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"cn1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
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
        midtones.one = 0.0f/255.0f;
        midtones.two = -9.0f/255.0f;
        midtones.three = -4.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 4.0f/255.0f;
        highlights.two = 5.0f/255.0f;
        highlights.three = -10.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"cn2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:193.0f/255.0f green:145.0f/255.0f blue:0.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.22f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:0 Magenta:2 Yellow:42 Black:0];
        [selectiveColor setYellowsCyan:6 Magenta:5 Yellow:-5 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"cn3"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.51f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Gradient Map
    @autoreleasepool {
        VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
        [gradientMap addColorRed:40.0f Green:24.0f Blue:24.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:64.0f Green:78.0f Blue:94.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientMap opacity:0.50f blendingMode:VnBlendingModeExclusion];
    }
    
    // Solid COlor
    @autoreleasepool {
        
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:39.0f/255.0f green:9.0f/255.0f blue:9.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.50f blendingMode:VnBlendingModeColorDodge];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"cn4"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.50f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:12.0f/255.0f blue:44.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.41f blendingMode:VnBlendingModeExclusion];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:48 Magenta:0 Yellow:0 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setYellowsCyan:34 Magenta:-26 Yellow:0 Black:0];
        [selectiveColor setBlacksCyan:0 Magenta:0 Yellow:0 Black:4];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:0.40f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
