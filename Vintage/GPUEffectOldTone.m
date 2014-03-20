//
//  GPUEffectOldTone.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectOldTone.h"

@implementation GPUEffectOldTone

- (UIImage*)process_
{
    self.effectId = EffectIdOldTone;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Selective Color
    // Channel Mixer
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
        
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
        
        [selectiveColor addTarget:mixerFilter];
        
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:resultImage];
        [base addTarget:selectiveColor];
        [base processImage];
        
        resultImage = [mixerFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:118.0f/255.0f green:44.0f/255.0f blue:27.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.39 blendingMode:MergeBlendingModeColor];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:87.0f/255.0f green:56.0f/255.0f blue:18.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.14 blendingMode:MergeBlendingModeColorDodge];
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
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:0.20f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:65 Magenta:11 Yellow:23 Black:0];
        [selectiveColor setGreensCyan:10 Magenta:0 Yellow:3 Black:0];
        [selectiveColor setCyansCyan:16 Magenta:54 Yellow:-28 Black:-9];
        [selectiveColor setBluesCyan:4 Magenta:0 Yellow:4 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:0.40f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:5 Magenta:3 Yellow:17 Black:0];
        [selectiveColor setYellowsCyan:-14 Magenta:4 Yellow:6 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:0.40f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:97.0f/255.0f green:86.0f/255.0f blue:59.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.17 blendingMode:MergeBlendingModeSaturation];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:61.0f/255.0f green:25.0f/255.0f blue:3.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.05 blendingMode:MergeBlendingModeDifference];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:-161];
        [gradientColor setScalePercent:130];
        [gradientColor setOffsetX:-1.6f Y:5.4f];
        [gradientColor addColorRed:155.0f Green:249.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:155.0f Green:249.0f Blue:255.0f Opacity:100.0f Location:1119 Midpoint:50];
        [gradientColor addColorRed:35.0f Green:19.0f Blue:12.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.15f blendingMode:MergeBlendingModeDarken];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:31.0f/255.0f green:33.0f/255.0f blue:99.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.10f blendingMode:MergeBlendingModeDifference];
    }
    
    // Channel Mixer
    // Color Balance
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:84 Green:18 Blue:8 Constant:0];
        [mixerFilter setGreenChannelRed:-2 Green:104 Blue:8 Constant:0];
        [mixerFilter setBlueChannelRed:0 Green:0 Blue:100 Constant:0];
        
        GPUImageColorBalanceFilter* colorBalance = [[GPUImageColorBalanceFilter alloc] init];
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
        
        [mixerFilter addTarget:colorBalance];
        
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:resultImage];
        [base addTarget:mixerFilter];
        [base processImage];
        
        resultImage = [colorBalance imageFromCurrentlyProcessedOutput];
    }
    
    return resultImage;
}

- (UIImage*)process
{
    self.effectId = EffectIdOldTone;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:mixerFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:118.0f/255.0f green:44.0f/255.0f blue:27.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.39 blendingMode:MergeBlendingModeColor];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:87.0f/255.0f green:56.0f/255.0f blue:18.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.14 blendingMode:MergeBlendingModeColorDodge];
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
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:0.20f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:65 Magenta:11 Yellow:23 Black:0];
        [selectiveColor setGreensCyan:10 Magenta:0 Yellow:3 Black:0];
        [selectiveColor setCyansCyan:16 Magenta:54 Yellow:-28 Black:-9];
        [selectiveColor setBluesCyan:4 Magenta:0 Yellow:4 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:0.40f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:5 Magenta:3 Yellow:17 Black:0];
        [selectiveColor setYellowsCyan:-14 Magenta:4 Yellow:6 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:0.40f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:97.0f/255.0f green:86.0f/255.0f blue:59.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.17 blendingMode:MergeBlendingModeSaturation];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:61.0f/255.0f green:25.0f/255.0f blue:3.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.05 blendingMode:MergeBlendingModeDifference];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:-161];
        [gradientColor setScalePercent:130];
        [gradientColor setOffsetX:-1.6f Y:5.4f];
        [gradientColor addColorRed:155.0f Green:249.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:155.0f Green:249.0f Blue:255.0f Opacity:100.0f Location:1119 Midpoint:50];
        [gradientColor addColorRed:35.0f Green:19.0f Blue:12.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.15f blendingMode:MergeBlendingModeDarken];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:31.0f/255.0f green:33.0f/255.0f blue:99.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.10f blendingMode:MergeBlendingModeDifference];
    }
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:84 Green:18 Blue:8 Constant:0];
        [mixerFilter setGreenChannelRed:-2 Green:104 Blue:8 Constant:0];
        [mixerFilter setBlueChannelRed:0 Green:0 Blue:100 Constant:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:mixerFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
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
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }

    return resultImage;
}

@end
