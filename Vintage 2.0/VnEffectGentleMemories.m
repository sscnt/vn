//
//  GPUEffectGentleMemories.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectGentleMemories.h"

@implementation VnEffectGentleMemories

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGentleMemories;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:[super process]];
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:20.0f/255.0f green:32.0f/255.0f blue:60.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.70f blendingMode:VnBlendingModeExclusion];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:4.0f/255.0f green:25.0f/255.0f blue:23.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.70f blendingMode:VnBlendingModeExclusion];
    }
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setRedMin:33.0f/255.0f gamma:1.47f max:249.0f/255.0f minOut:0.0f maxOut:1.0f];
        [levelsFilter setGreenMin:34.0f/255.0f gamma:1.18f max:253.0f/255.0f minOut:0.0f maxOut:1.0f];
        [levelsFilter setBlueMin:29.0f/255.0f gamma:1.28f max:249.0f/255.0f minOut:41.0f/255.0f maxOut:228.0f/255.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:levelsFilter opacity:0.70f blendingMode:VnBlendingModeNormal];
    }
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:52.0f/255.0f gamma:1.20f max:234.0f/255.0f minOut:26.0f/255.0f maxOut:251.0f/255.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:levelsFilter opacity:0.70f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:-15 Magenta:5 Yellow:-10 Black:0];
        [selectiveColor setYellowsCyan:-14 Magenta:10 Yellow:16 Black:0];
        [selectiveColor setGreensCyan:-5 Magenta:0 Yellow:0 Black:0];
        [selectiveColor setCyansCyan:-29 Magenta:3 Yellow:-1 Black:0];
        [selectiveColor setBluesCyan:-27 Magenta:0 Yellow:22 Black:0];
        [selectiveColor setMagentasCyan:-1 Magenta:0 Yellow:0 Black:0];
        [selectiveColor setNeutralsCyan:4 Magenta:-5 Yellow:8 Black:1];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:0.70f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:236.0f/255.0f green:110.0f/255.0f blue:222.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.05f blendingMode:VnBlendingModeScreen];
    
    }
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:236.0f/255.0f green:110.0f/255.0f blue:222.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.02f blendingMode:VnBlendingModeSoftLight];
    }
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gm1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.70f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:255.0f/255.0f green:244.0f/255.0f blue:200.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.10f blendingMode:VnBlendingModeScreen];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleLinear];
        [gradientColor setAngleDegree:-63.0f];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.20f blendingMode:VnBlendingModeScreen];
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.15f blendingMode:VnBlendingModeScreen];
    }
    
    // Brightness
    @autoreleasepool {
        GPUImageBrightnessFilter* brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        brightnessFilter.brightness = 0.02f;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:brightnessFilter opacity:0.70f blendingMode:VnBlendingModeNormal];
    }

    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = 3.0f/255.0f;
        shadows.two = 3.0f/255.0f;
        shadows.three = 3.0f/255.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 1.0f/255.0f;
        midtones.two = 7.0f/255.0f;
        midtones.three = 5.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = -2.0f/255.0f;
        highlights.two = 0.0f;
        highlights.three = 8.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:0.10f blendingMode:VnBlendingModeScreen];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:0.70f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Brightness
    @autoreleasepool {
        GPUImageBrightnessFilter* brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        brightnessFilter.brightness = -0.03;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:brightnessFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gm2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = 10.0f/255.0f;
        shadows.two = 0.0f;
        shadows.three = 0.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 25.0f/255.0f;
        midtones.two = 0.0f/255.0f;
        midtones.three = -15.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 1.0f/255.0f;
        highlights.two = 0.0f/255.0f;
        highlights.three = 1.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Hue / Saturation
    @autoreleasepool {
        VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
        hueSaturation.hue = 0.0f;
        hueSaturation.saturation = 1.0f;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize = NO;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:hueSaturation opacity:1.0f blendingMode:VnBlendingModeNormal];
        
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gm3"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"gm4"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
