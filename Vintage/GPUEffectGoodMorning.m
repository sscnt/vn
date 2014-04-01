//
//  GPUEffectGoodMorning.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/26.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectGoodMorning.h"

@implementation GPUEffectGoodMorning

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 1.0f;
    }
    return self;
}


- (UIImage*)process
{
    
    self.effectId = EffectIdGoodMorning;
    
    UIImage* resultImage = self.imageToProcess;
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"mo1"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
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
        midtones.one = -25.0f/255.0f;
        midtones.two = 0.0f;
        midtones.three = 24.0f/255.0f;
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = 0.0f;
        highlights.two = 0.0f;
        highlights.three = 0.0f;
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:colorBalance opacity:0.90f blendingMode:MergeBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"mo2"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Duplicate
    @autoreleasepool {
        UIImage* solidImage = resultImage;
        
        GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
        [solidColor setColorRed:255.0f/255.0f green:204.0f/255.0f blue:153.0f/255.0 alpha:1.0f];
        
        solidImage = [self mergeBaseImage:solidImage overlayFilter:solidColor opacity:0.31f blendingMode:MergeBlendingModeMultiply];
        
        GPUImagePicture* basePicture = [[GPUImagePicture alloc] initWithImage:resultImage];
        GPUImagePicture* overlayPicture = [[GPUImagePicture alloc] initWithImage:solidImage];
        
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.69f;
        
        GPUImageNormalBlendFilter* normalBlend = [[GPUImageNormalBlendFilter alloc] init];
        [opacityFilter addTarget:normalBlend atTextureLocation:1];
        [basePicture addTarget:normalBlend];
        [overlayPicture addTarget:opacityFilter];
        [basePicture processImage];
        [overlayPicture processImage];
        resultImage = [normalBlend imageFromCurrentlyProcessedOutput];
    }
    
    // Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"mo3"];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:curveFilter opacity:1.0f blendingMode:MergeBlendingModeNormal];
    }
    
    // Gradient Map
    @autoreleasepool {
        GPUImageGradientMapFilter* gradientMap = [[GPUImageGradientMapFilter alloc] init];
        [gradientMap addColorRed:58.0f Green:62.0f Blue:124.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientMap addColorRed:251.0f Green:215.0f Blue:107.0f Opacity:100.0f Location:4096 Midpoint:60];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientMap opacity:0.48 blendingMode:MergeBlendingModeSoftLight];
    }
    
    
    // Fill Layer
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientColor = [[GPUImageGradientColorGenerator alloc] init];
        [gradientColor forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:90];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:207.0f Green:147.0f Blue:155.0f Opacity:1.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        resultImage = [self mergeBaseImage:resultImage overlayFilter:gradientColor opacity:1.0f blendingMode:MergeBlendingModeSoftLight];
    }
    return resultImage;
}
    
@end
