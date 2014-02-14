//
//  GPUEffectCreamyNoon.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectCreamyNoon.h"

@implementation GPUEffectCreamyNoon

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"CreamyNoon1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
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
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"CreamyNoon2"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:193.0f/255.0f green:145.0f/255.0f blue:0.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.22 blendingMode:MergeBlendingModeSoftLight];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:0 Magenta:2 Yellow:42 Black:0];
        [selectiveColor setYellowsCyan:6 Magenta:5 Yellow:-5 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"CreamyNoon3"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.51f blendingMode:MergeBlendingModeNormal];
    }
    
    
    // Gradient Map
    @autoreleasepool {
        GPUImageGradientMapFilter* gradientMap = [[GPUImageGradientMapFilter alloc] init];
        [gradientMap addColorRed:40.0f Green:24.0f Blue:24.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:64.0f Green:78.0f Blue:94.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientMap opacity:0.50f blendingMode:MergeBlendingModeExclusion];

        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:39.0f/255.0f green:9.0f/255.0f blue:9.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.50f blendingMode:MergeBlendingModeColorDodge];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"CreamyNoon4"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:0.50f blendingMode:MergeBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:12.0f/255.0f blue:44.0f/255.0 alpha:1.0f];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:solidColor opacity:0.41 blendingMode:MergeBlendingModeExclusion];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:48 Magenta:0 Yellow:0 Black:0];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setYellowsCyan:34 Magenta:-26 Yellow:0 Black:0];
        [selectiveColor setBlacksCyan:0 Magenta:0 Yellow:0 Black:4];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:selectiveColor opacity:0.40f blendingMode:MergeBlendingModeNormal];
    }
    
    return resultImage;
}

@end
