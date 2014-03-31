//
//  GPUEffectAutumnVintage.m
//  Vintage
//
//  Created by SSC on 2014/03/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUEffectAutumnVintage.h"

@implementation GPUEffectAutumnVintage

- (UIImage*)process
{
    
    self.effectId = EffectIdAutumnVintage;
    
    UIImage* resultImage = self.imageToProcess;
    
    /*
    // Brightness
    // Contrast
    @autoreleasepool {
        GPUImageBrightnessFilter* brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        brightnessFilter.brightness = 0.06f;
        
        GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = 1.01f;
        
        [brightnessFilter addTarget:contrastFilter];
        
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:resultImage];
        [base addTarget:brightnessFilter];
        [base processImage];
        
        resultImage = [contrastFilter imageFromCurrentlyProcessedOutput];
    }
    */
    
    // Gradient
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:0];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:1.3 Y:-2.6f];
        [gradientColor addColorRed:241.0f Green:221.0f Blue:210.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:185.0f Green:64.0f Blue:17.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:0.75f blendingMode:MergeBlendingModeSoftLight];
    }
    
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:18 Magenta:0 Yellow:25 Black:0];
        [selectiveColor setYellowsCyan:40 Magenta:25 Yellow:5 Black:0];
        [selectiveColor setGreensCyan:1 Magenta:-1 Yellow:-1 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter1 = [[GPUImageToneCurveFilter alloc] initWithACV:@"av1"];
        GPUImageToneCurveFilter* curveFilter2 = [[GPUImageToneCurveFilter alloc] initWithACV:@"av2"];
        
        [curveFilter1 addTarget:curveFilter2];
        
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:resultImage];
        [base addTarget:curveFilter1];
        [base processImage];
        
        resultImage = [curveFilter2 imageFromCurrentlyProcessedOutput];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:7 Magenta:17 Yellow:11 Black:0];
        [selectiveColor setYellowsCyan:5 Magenta:19 Yellow:-9 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:0 Magenta:1 Yellow:7 Black:0];
        [selectiveColor setYellowsCyan:0 Magenta:8 Yellow:10 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"av3"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.80f blendingMode:MergeBlendingModeNormal];
    }
    
    // Gradient Map
    @autoreleasepool {
        GPUImageGradientMapFilter* gradientMap = [[GPUImageGradientMapFilter alloc] init];
        [gradientMap addColorRed:41.0f Green:10.0f Blue:89.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:255.0f Green:124.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientMap opacity:0.40f blendingMode:MergeBlendingModeHue];
    }
    
    
    // Color Balance
    @autoreleasepool {
        GPUImageColorBalanceFilter* colorBalance = [[GPUImageColorBalanceFilter alloc] init];
        GPUVector3 shadows;
        shadows.one = -4.0f/255.0f;
        shadows.two = 2.0f/255.0f;
        shadows.three = -4.0f/255.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 4.0f/255.0f;
        midtones.two = 3.0f/255.0f;
        midtones.three = -6.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f/255.0f;
        highlights.two = 0.0/255.0f;
        highlights.three = 0.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"av4"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Color Balance
    @autoreleasepool {
        GPUImageColorBalanceFilter* colorBalance = [[GPUImageColorBalanceFilter alloc] init];
        GPUVector3 shadows;
        shadows.one = 0.0f/255.0f;
        shadows.two = 0.0f/255.0f;
        shadows.three = 3.0f/255.0f;
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = 0.0f/255.0f;
        midtones.two = -5.0f/255.0f;
        midtones.three = -10.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f/255.0f;
        highlights.two = 0.0/255.0f;
        highlights.three = 0.0f/255.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:0.55f blendingMode:MergeBlendingModeOverlay];
    }
    return resultImage;
}

@end
