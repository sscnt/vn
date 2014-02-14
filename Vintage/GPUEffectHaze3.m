//
//  GPUHaze3Effect.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectHaze3.h"

@implementation GPUEffectHaze3

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;
    
    // Blur
    @autoreleasepool {
        GPUImagePicture* pictureBlur = [[GPUImagePicture alloc] initWithImage:resultImage];
        GPUImageGaussianBlurFilter* blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.4f;
        blurFilter.blurRadiusInPixels = 40.0f;
        [blurFilter addTarget:opacityFilter];
        GPUImageOverlayBlendFilter* overlayFilter = [[GPUImageOverlayBlendFilter alloc] init];
        [opacityFilter addTarget:overlayFilter atTextureLocation:1];
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:overlayFilter];
        [pictureBlur addTarget:blurFilter];
        [pictureOriginal processImage];
        [pictureBlur processImage];
        resultImage = [overlayFilter imageFromCurrentlyProcessedOutput];
    }

    // Fill
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidGen = [[GPUImageSolidColorGenerator alloc] init];
        [solidGen setColorRed:5.0f/255.0f green:23.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
        GPUImageExclusionBlendFilter* exclusionFilter = [[GPUImageExclusionBlendFilter alloc] init];
        [solidGen addTarget:exclusionFilter];
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:solidGen];
        [pictureOriginal addTarget:exclusionFilter];
        [pictureOriginal processImage];
        resultImage = [exclusionFilter imageFromCurrentlyProcessedOutput];
    }

    return resultImage;
}

@end
