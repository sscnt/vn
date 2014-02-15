//
//  GPUImageEffects.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUImageEffects.h"

@implementation GPUImageEffects

- (UIImage*)process
{
    return nil;
}

- (UIImage*)mergeBaseImage:(UIImage *)baseImage overlayImage:(UIImage *)overlayImage opacity:(CGFloat)opacity blendingMode:(MergeBlendingMode)blendingMode
{
    GPUImagePicture* overlayPicture = [[GPUImagePicture alloc] initWithImage:overlayImage];
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = opacity;
    [overlayPicture addTarget:opacityFilter];
    
    GPUImagePicture* basePicture = [[GPUImagePicture alloc] initWithImage:baseImage];
    
    id blending;
    
    if(blendingMode == MergeBlendingModeNormal){
        blending = [[GPUImageNormalBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeDarken){
        blending = [[GPUImageDarkenBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeMultiply){
        blending = [[GPUImageMultiplyBlendFilter alloc] init];
    }
    
    if(blendingMode == MergeBlendingModeSoftLight){
        blending = [[GPUImageSoftLightBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeHardLight){
        blending = [[GPUImageHardLightBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeVividLight){
        blending = [[GPUImageVividLightBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeOverlay){
        blending = [[GPUImageOverlayBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeColorDodge){
        blending = [[GPUImageColorDodgeBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeExclusion){
        blending = [[GPUImageExclusionBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeColor){
        blending = [[GPUImageColorBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeHue){
        blending = [[GPUImageHueBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeColorBurn){
        blending = [[GPUImageColorBurnBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeSaturation){
        blending = [[GPUImageSaturationBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeDifference){
        blending = [[GPUImageDifferenceBlendFilter alloc] init];
    }
    
    [opacityFilter addTarget:blending atTextureLocation:1];
    
    [basePicture addTarget:blending];
    [basePicture processImage];
    [overlayPicture processImage];
    return [blending imageFromCurrentlyProcessedOutput];

}

- (UIImage*)mergeBaseImage:(UIImage *)baseImage overlayFilter:(GPUImageFilter *)overlayFilter opacity:(CGFloat)opacity blendingMode:(MergeBlendingMode)blendingMode
{
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = opacity;
    [overlayFilter addTarget:opacityFilter];
    
    GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:baseImage];
    [picture addTarget:overlayFilter];
    
    id blending;
    
    if(blendingMode == MergeBlendingModeNormal){
        blending = [[GPUImageNormalBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeDarken){
        blending = [[GPUImageDarkenBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeMultiply){
        blending = [[GPUImageMultiplyBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeScreen){
        blending = [[GPUImageScreenBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeSoftLight){
        blending = [[GPUImageSoftLightBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeLighten){
        blending = [[GPUImageLightenBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeHardLight){
        blending = [[GPUImageHardLightBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeVividLight){
        blending = [[GPUImageVividLightBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeOverlay){
        blending = [[GPUImageOverlayBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeColorDodge){
        blending = [[GPUImageColorDodgeBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeLinearDodge){
        blending = [[GPUImageLinearDodgeBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeExclusion){
        blending = [[GPUImageExclusionBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeColor){
        blending = [[GPUImageColorBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeHue){
        blending = [[GPUImageHueBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeColorBurn){
        blending = [[GPUImageColorBurnBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeSaturation){
        blending = [[GPUImageSaturationBlendFilter alloc] init];
    }
    if(blendingMode == MergeBlendingModeDifference){
        blending = [[GPUImageDifferenceBlendFilter alloc] init];
    }
    
    [opacityFilter addTarget:blending atTextureLocation:1];
    
    [picture addTarget:blending];
    [picture processImage];
    return [blending imageFromCurrentlyProcessedOutput];

}

@end
