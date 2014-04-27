//
//  GPUEffectFaerieVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectFaerieVintage.h"

@implementation VnEffectFaerieVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFaerieVintage;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:114.0f/255.0f green:87.0f/255.0f blue:71.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.35f blendingMode:VnBlendingModeColor];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:202.0f/255.0f green:179.0f/255.0f blue:154.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.10f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"fv1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.40f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:1 Magenta:0 Yellow:44 Black:0];
        [selectiveColor setYellowsCyan:11 Magenta:8 Yellow:100 Black:0];
        [selectiveColor setCyansCyan:0 Magenta:0 Yellow:-1 Black:0];
        [selectiveColor setMagentasCyan:0 Magenta:0 Yellow:100 Black:0];
        [selectiveColor setWhitesCyan:0 Magenta:0 Yellow:-100 Black:0];
        [selectiveColor setNeutralsCyan:0 Magenta:0 Yellow:-30 Black:0];
        
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
    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = -4.0f/255.0f;
        shadows.two = 0.0f/255.0f;
        shadows.three = 10.0f/255.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = -6.0f/255.0f;
        midtones.two = -5.0f/255.0f;
        midtones.three = -26.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f/255.0f;
        highlights.two = -9.0f/255.0f;
        highlights.three = -15.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:0.80f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"fv2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:114.0f Green:12.0f Blue:-28.0f Constant:2];
        [mixerFilter setGreenChannelRed:4.0f Green:92.0f Blue:2.0f Constant:0];
        [mixerFilter setBlueChannelRed:-2.0f Green:-8.0f Blue:104.0f Constant:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:mixerFilter opacity:0.80f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:255.0f/255.0f green:247.0f/255.0f blue:182.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.30f blendingMode:VnBlendingModeDarken];
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
