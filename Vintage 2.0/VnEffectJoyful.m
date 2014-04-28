//
//  GPUEffectJoyful.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/30.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectJoyful.h"

@implementation VnEffectJoyful

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 0.80f;
        self.effectId = VnEffectIdJoyful;
    }
    return self;
}

- (UIImage*)process
{
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"jf1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.40f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleLinear];
        [gradientColor setAngleDegree:-135];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:239.0f Green:219.0f Blue:205.0f Opacity:100.0f Location:0 Midpoint:60];
        [gradientColor addColorRed:251.0f Green:216.0f Blue:197.0f Opacity:100.0f Location:1229 Midpoint:50];
        [gradientColor addColorRed:108.0f Green:46.0f Blue:22.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.50f blendingMode:VnBlendingModeSoftLight];
    }
    
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Channel Mixer
    @autoreleasepool {
        VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:mixerFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:66.0f/255.0f green:52.0f/255.0f blue:125.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.05f blendingMode:VnBlendingModeHardLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:148.0f/255.0f green:111.0f/255.0f blue:102.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.10f blendingMode:VnBlendingModeHue];
    }
    
    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f;
        shadows.two = 0.0f/255.0f;
        shadows.three = 0.0f/255.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 20.0f/255.0f;
        midtones.two = -5.0f/255.0f;
        midtones.three = -19.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = -10.0f/255.0f;
        highlights.two = -7.0f/255.0f;
        highlights.three = -3.0f/155.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"jf2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:114 Green:12 Blue:-28 Constant:0];
        [mixerFilter setGreenChannelRed:4 Green:92 Blue:2 Constant:0];
        [mixerFilter setBlueChannelRed:-2 Green:-8 Blue:104 Constant:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:mixerFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:255.0f/255.0f green:239.0f/255.0f blue:107.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.30f blendingMode:VnBlendingModeDarken];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:12.5f Y:-28.8f];
        [gradientColor addColorRed:255.0f Green:238.0f Blue:127.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:255.0f Green:238.0f Blue:127.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.30f blendingMode:VnBlendingModeOverlay];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:45];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:-4.0f Y:-7.0f];
        [gradientColor addColorRed:239.0f Green:229.0f Blue:64.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:239.0f Green:229.0f Blue:64.0f Opacity:0.0f Location:2415 Midpoint:50];
        [gradientColor addColorRed:239.0f Green:229.0f Blue:64.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.30f blendingMode:VnBlendingModeSoftLight];
    }

    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:12.0f/255.0f blue:71.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.27f blendingMode:VnBlendingModeExclusion];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
