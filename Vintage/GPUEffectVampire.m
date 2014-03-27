//
//  GPUEffectVampire.m
//  Vintage
//
//  Created by SSC on 2014/03/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUEffectVampire.h"

@implementation GPUEffectVampire

- (UIImage*)process
{
    self.effectId = EffectIdVampire;
    
    UIImage* resultImage = self.imageToProcess;
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:59.0f/255.0f green:48.0f/255.0f blue:45.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.40f blendingMode:MergeBlendingModeHue];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:46.0f/255.0f green:35.0f/255.0f blue:32.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.10f blendingMode:MergeBlendingModeLighten];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:39.0f/255.0f green:17.0f/255.0f blue:12.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.30f blendingMode:MergeBlendingModeDifference];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:177.0f/255.0f green:141.0f/255.0f blue:16.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.20f blendingMode:MergeBlendingModeHue];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:75.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.50f blendingMode:MergeBlendingModeDifference];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:40.0f/255.0f green:28.0f/255.0f blue:13.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.25f blendingMode:MergeBlendingModeColor];
    }
    
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:10 Magenta:0 Yellow:0 Black:0];
        [selectiveColor setYellowsCyan:-6 Magenta:5 Yellow:-10 Black:0];
        [selectiveColor setNeutralsCyan:5 Magenta:0 Yellow:-8 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:-19 Magenta:18 Yellow:61 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:108 Green:-8 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:-24 Green:34 Blue:86 Constant:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:mixerFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:-7 Magenta:52 Yellow:89 Black:0];
        [selectiveColor setYellowsCyan:0 Magenta:100 Yellow:100 Black:0];
        [selectiveColor setGreensCyan:4 Magenta:12 Yellow:38 Black:0];
        [selectiveColor setWhitesCyan:0 Magenta:0 Yellow:-41 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:155.0f/255.0f green:29.0f/255.0f blue:29.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.30f blendingMode:MergeBlendingModeHue];
    }
    
    
    
    // Color Balance
    @autoreleasepool {
        GPUImageColorBalanceFilter* colorBalance = [[GPUImageColorBalanceFilter alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f;
        shadows.two = 0.0f;
        shadows.three = 0.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 40.0f/255.0f;
        midtones.two = -8.0f/255.0f;
        midtones.three = -10.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = -2.0f/255.0f;
        highlights.two = 0.0/255.0f;
        highlights.three = 0.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vmp"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:30 Magenta:3 Yellow:4 Black:0];
        [selectiveColor setWhitesCyan:0 Magenta:0 Yellow:0 Black:-20];
        [selectiveColor setBlacksCyan:0 Magenta:0 Yellow:0 Black:3];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:72.0f/255.0f green:46.0f/255.0f blue:30.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.11f blendingMode:MergeBlendingModeColor];
    }
    
    return resultImage;
    
    
}

@end
