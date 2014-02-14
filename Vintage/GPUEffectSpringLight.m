//
//  GPUEffectSpringLight.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectSpringLight.h"

@implementation GPUEffectSpringLight

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"SpringLight1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:21 Magenta:8 Yellow:15 Black:0];
        [selectiveColor setYellowsCyan:-31 Magenta:24 Yellow:-73 Black:0];
        
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:12 Green:0 Blue:64 Constant:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:mixerFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:-10 Green:26 Blue:102 Constant:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:mixerFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"SpringLight2"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }

    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:121.0f/255.0f green:44.0f/255.0f blue:49.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.20 blendingMode:MergeBlendingModeHue];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:243.0f/255.0f green:211.0f/255.0f blue:57.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.10 blendingMode:MergeBlendingModeColor];
    }
    

    // Color Balance
    @autoreleasepool {
        GPUImageColorBalanceFilter* colorBalance = [[GPUImageColorBalanceFilter alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f/160.0f;
        shadows.two = 2.0f/160.0f;
        shadows.three = 5.0f/160.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 0.0f/160.0f;
        midtones.two = -1.0f/160.0f;
        midtones.three = 10.0f/160.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 11.0f/160.0f;
        highlights.two = 0.0f/160.0f;
        highlights.three = 10.0f/160.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:14 Magenta:15 Yellow:0 Black:0];
        [selectiveColor setYellowsCyan:-3 Magenta:4 Yellow:-22 Black:0];
        
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:51 Magenta:8 Yellow:9 Black:0];
        [selectiveColor setYellowsCyan:13 Magenta:-8 Yellow:-12 Black:0];
        
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    return resultImage;
}

@end
