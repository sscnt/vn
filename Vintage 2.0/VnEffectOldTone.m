//
//  GPUEffectOldTone.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectOldTone.h"

@implementation VnEffectOldTone

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.65f;
        self.effectId = VnEffectIdOldTone;
    }
    return self;
}

- (UIImage*)process
{
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
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
        [solidColor setColorRed:118.0f/255.0f green:44.0f/255.0f blue:27.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.39f blendingMode:VnBlendingModeColor];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:87.0f/255.0f green:56.0f/255.0f blue:18.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.14f blendingMode:VnBlendingModeColorDodge];
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
        midtones.one = -15.0f/255.0f;
        midtones.two = 8.0f/255.0f;
        midtones.three = -12.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 5.0f/255.0f;
        highlights.two = 2.0f/255.0f;
        highlights.three = -15.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:0.20f blendingMode:VnBlendingModeNormal];
    }
    
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:65 Magenta:11 Yellow:23 Black:0];
        [selectiveColor setGreensCyan:10 Magenta:0 Yellow:3 Black:0];
        [selectiveColor setCyansCyan:16 Magenta:54 Yellow:-28 Black:-9];
        [selectiveColor setBluesCyan:4 Magenta:0 Yellow:4 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:0.40f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:5 Magenta:3 Yellow:17 Black:0];
        [selectiveColor setYellowsCyan:-14 Magenta:4 Yellow:6 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:0.40f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:97.0f/255.0f green:86.0f/255.0f blue:59.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.17f blendingMode:VnBlendingModeSaturation];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:61.0f/255.0f green:25.0f/255.0f blue:3.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.05f blendingMode:VnBlendingModeDifference];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:[VnCurrentImage tmpImageSize]];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:-161];
        [gradientColor setScalePercent:130];
        [gradientColor setOffsetX:-1.6f Y:5.4f];
        [gradientColor addColorRed:155.0f Green:249.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:155.0f Green:249.0f Blue:255.0f Opacity:100.0f Location:1119 Midpoint:50];
        [gradientColor addColorRed:35.0f Green:19.0f Blue:12.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.15f blendingMode:VnBlendingModeDarken];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:31.0f/255.0f green:33.0f/255.0f blue:99.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.10f blendingMode:VnBlendingModeDifference];
    }
    
    // Channel Mixer
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:84 Green:18 Blue:8 Constant:0];
        [mixerFilter setGreenChannelRed:-2 Green:104 Blue:8 Constant:0];
        [mixerFilter setBlueChannelRed:0 Green:0 Blue:100 Constant:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:mixerFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
        
    }
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f;
        shadows.two = 0.0f;
        shadows.three = 0.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 9.0f/255.0f;
        midtones.two = 9.0f/255.0f;
        midtones.three = -3.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 13.0f/255.0f;
        highlights.two = 1.0f/255.0f;
        highlights.three = -2.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
