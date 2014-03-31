//
//  GPUEffectVintageFilm.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/17.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectVintageFilm.h"

@implementation GPUEffectVintageFilm


- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 0.80f;
    }
    return self;
}

- (UIImage*)process
{
    self.effectId = EffectIdVintageFilm;
    
    UIImage* resultImage = self.imageToProcess;
    
    GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:resultImage];
    
    //// Saturation
    GPUImageSaturationFilter* saturationFilter = [[GPUImageSaturationFilter alloc] init];
    saturationFilter.saturation = 1.25f;
    
    //// Contrast
    GPUImageContrastFilter* contrastFilter = [[GPUImageContrastFilter alloc] init];
    contrastFilter.contrast = 1.05;
    
    //// Curve
    GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"vf"];
    
    //// Hue/Saturation
    GPUImageHueSaturationFilter* hueSaturation = [[GPUImageHueSaturationFilter alloc] init];
    hueSaturation.hue = 35.0f;
    hueSaturation.saturation = 25.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = YES;
    
    //// Opacity
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = 0.50f;
    
    //// Create Base Image
    [saturationFilter addTarget:contrastFilter];
    [contrastFilter addTarget:curveFilter];
    
    //// Create Overly Image
    [hueSaturation addTarget:opacityFilter];
    
    //// Blend
    GPUImageNormalBlendFilter* normalBlend = [[GPUImageNormalBlendFilter alloc] init];
    [opacityFilter addTarget:normalBlend atTextureLocation:1];
    [curveFilter addTarget:hueSaturation];
    [curveFilter addTarget:normalBlend];
    
    //// Solid Color
    GPUImageSolidColorGenerator* solidColor = [[GPUImageSolidColorGenerator alloc] init];
    [solidColor setColorRed:236.0f/255.0f green:0.0f blue:139.0f/255.0f alpha:1.0f];
    
    //// Opacity
    GPUImageOpacityFilter* opacityFilter2 = [[GPUImageOpacityFilter alloc] init];
    opacityFilter2.opacity = 0.10f;
    
    //// Create Overlay Image
    [solidColor addTarget:opacityFilter2];
    
    //// Blend
    GPUImageScreenBlendFilter* screenBlend = [[GPUImageScreenBlendFilter alloc] init];
    [opacityFilter2 addTarget:screenBlend atTextureLocation:1];
    [normalBlend addTarget:solidColor];
    [normalBlend addTarget:screenBlend];
    
    [picture addTarget:saturationFilter];
    [picture processImage];
    resultImage = [screenBlend imageFromCurrentlyProcessedOutput];
    
    
    return resultImage;
}

@end
