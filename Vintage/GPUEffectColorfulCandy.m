//
//  GPUColorfulCandyEffect.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "GPUEffectColorfulCandy.h"

@implementation GPUEffectColorfulCandy

- (UIImage*)process
{
    UIImage* resultImage = self.imageToProcess;
    UIImage* solidImage;

    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:92 Green:26 Blue:-20 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:-8 Green:4 Blue:108 Constant:0];
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:mixerFilter];
        [pictureOriginal processImage];
        resultImage = [mixerFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Gradient Fill
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientGenerator = [[GPUImageGradientColorGenerator alloc] init];
        [gradientGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientGenerator setAngleDegree:-90.0f];
        [gradientGenerator setScalePercent:150.0f];
        [gradientGenerator setOffsetX:0.0f Y:15.0f];
        [gradientGenerator addColorRed:231.996f Green:114.008f Blue:42.763f Opacity:100.0f Location:0 Midpoint:50];
        [gradientGenerator addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        //// Opacity
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.30f;
        [gradientGenerator addTarget:opacityFilter];
        
        //// Hardlight Blending
        GPUImageHardLightBlendFilter* hardlightFilter = [[GPUImageHardLightBlendFilter alloc] init];
        [opacityFilter addTarget:hardlightFilter atTextureLocation:1];
        
        // Flatten
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:hardlightFilter];
        [pictureOriginal addTarget:gradientGenerator];
        [pictureOriginal processImage];
        resultImage = [hardlightFilter imageFromCurrentlyProcessedOutput];
    }
    
    
    // Fill layer
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidGenerator = [[GPUImageSolidColorGenerator alloc] init];
        [solidGenerator setColorRed:122.0f/255.0f green:18.0f/255.0f blue:18.0f/255.0f alpha:1.0f];
        [solidGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        
        // Hue Blending
        GPUImageHueBlendFilter* hueFilter = [[GPUImageHueBlendFilter alloc] init];
        
        // Opacity
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.30f;
        [solidGenerator addTarget:opacityFilter];
        [opacityFilter addTarget:hueFilter atTextureLocation:1];
        
        // Flatten
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:hueFilter];
        [pictureOriginal addTarget:solidGenerator];
        [pictureOriginal processImage];
        resultImage = [hueFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Selective Color
    @autoreleasepool {
        GPUImageSelectiveColorFilter* selectiveColor = [[GPUImageSelectiveColorFilter alloc] init];
        [selectiveColor setRedsCyan:-5 Magenta:5 Yellow:6 Black:0];
        [selectiveColor setYellowsCyan:-2 Magenta:0 Yellow:0 Black:0];
        [selectiveColor setWhitesCyan:11 Magenta:-48 Yellow:0 Black:0];
        
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.40f;
        [selectiveColor addTarget:opacityFilter];
        
        GPUImageNormalBlendFilter* normalFilter = [[GPUImageNormalBlendFilter alloc] init];
        [opacityFilter addTarget:normalFilter atTextureLocation:1];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:selectiveColor];
        [pictureOriginal addTarget:normalFilter];
        [pictureOriginal processImage];
        resultImage = [normalFilter imageFromCurrentlyProcessedOutput];
        
    }

    // Fill Gradient
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientGenerator = [[GPUImageGradientColorGenerator alloc] init];
        [gradientGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientGenerator setAngleDegree:40.0f];
        [gradientGenerator setScalePercent:170.0f];
        [gradientGenerator setOffsetX:22.6f Y:-29.1f];
        [gradientGenerator addColorRed:89.479f Green:35.253f Blue:145.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientGenerator addColorRed:254.0f Green:177.0f Blue:244.0f Opacity:100.0f Location:1229 Midpoint:50];
        [gradientGenerator addColorRed:97.0f Green:108.0f Blue:22.0f Opacity:100.0f Location:3400 Midpoint:50];
        [gradientGenerator addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
   
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.34f;
        [gradientGenerator addTarget:opacityFilter];
        
        GPUImageHardLightBlendFilter* hardlightFilter = [[GPUImageHardLightBlendFilter alloc] init];
        [opacityFilter addTarget:hardlightFilter atTextureLocation:1];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:hardlightFilter];
        [pictureOriginal addTarget:gradientGenerator];
        [pictureOriginal processImage];
        resultImage = [hardlightFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Tone Curve
    @autoreleasepool {
        GPUImageToneCurveFilter* curveFilter = [[GPUImageToneCurveFilter alloc] initWithACV:@"Candy"];
        
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.10f;
        [curveFilter addTarget:opacityFilter];
        
        GPUImageNormalBlendFilter* normalFilter = [[GPUImageNormalBlendFilter alloc] init];
        [opacityFilter addTarget:normalFilter atTextureLocation:1];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:curveFilter];
        [pictureOriginal addTarget:normalFilter];
        [pictureOriginal processImage];
        resultImage = [normalFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Fill Gradient
    @autoreleasepool {
        GPUImageGradientColorGenerator* gradientGenerator = [[GPUImageGradientColorGenerator alloc] init];
        [gradientGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        [gradientGenerator setAngleDegree:-130.0f];
        [gradientGenerator setScalePercent:150.0f];
        [gradientGenerator setOffsetX:48.6f Y:-45.3f];
        [gradientGenerator addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientGenerator addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:4096 Midpoint:50];
    
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.34f;
        [gradientGenerator addTarget:opacityFilter];
        
        GPUImageHardLightBlendFilter* hardlightFilter = [[GPUImageHardLightBlendFilter alloc] init];
        [opacityFilter addTarget:hardlightFilter atTextureLocation:1];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:hardlightFilter];
        [pictureOriginal addTarget:gradientGenerator];
        [pictureOriginal processImage];
        resultImage = [hardlightFilter imageFromCurrentlyProcessedOutput];
    }
    

    // Fill
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidGenerator = [[GPUImageSolidColorGenerator alloc] init];
        [solidGenerator setColorRed:17.0f/255.0f green:21.0f/255.0f blue:103.0f/255.0f alpha:1.0f];
        [solidGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.10f;
        [solidGenerator addTarget:opacityFilter];
        
        GPUImageDifferenceBlendFilter* diffFilter = [[GPUImageDifferenceBlendFilter alloc] init];
        [opacityFilter addTarget:diffFilter atTextureLocation:1];
        
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:diffFilter];
        [pictureOriginal addTarget:solidGenerator];
        [pictureOriginal processImage];
        resultImage = [diffFilter imageFromCurrentlyProcessedOutput];
    }
    
    
    // Channel Mixer
    @autoreleasepool {
        GPUImageChannelMixerFilter* mixerFilter = [[GPUImageChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:-24 Blue:20 Constant:0];
        [mixerFilter setGreenChannelRed:-8 Green:98 Blue:12 Constant:0];
        [mixerFilter setBlueChannelRed:-20 Green:10 Blue:124 Constant:0];
        
        //// Blending
        GPUImageScreenBlendFilter* screenFilter = [[GPUImageScreenBlendFilter alloc] init];
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.2f;
        [mixerFilter addTarget:opacityFilter];
        [opacityFilter addTarget:screenFilter atTextureLocation:1];
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:screenFilter];
        [pictureOriginal addTarget:mixerFilter];
        [pictureOriginal processImage];
        resultImage = [screenFilter imageFromCurrentlyProcessedOutput];
    }
    
    // Fill
    @autoreleasepool {
        GPUImageSolidColorGenerator* solidGenerator = [[GPUImageSolidColorGenerator alloc] init];
        [solidGenerator setColorRed:209.0f/255.0f green:200.0f/255.0f blue:157.0f/255.0f alpha:1.0f];
        [solidGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        GPUImageDarkenBlendFilter* darkenFilter = [[GPUImageDarkenBlendFilter alloc] init];
        [solidGenerator addTarget:darkenFilter atTextureLocation:1];
        GPUImagePicture* pictureBlend = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureBlend addTarget:solidGenerator];
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:darkenFilter];
        [pictureOriginal processImage];
        [pictureBlend processImage];
        solidImage = [darkenFilter imageFromCurrentlyProcessedOutput];
    }
    @autoreleasepool {
        // Fill
        GPUImageSolidColorGenerator* solidGenerator = [[GPUImageSolidColorGenerator alloc] init];
        [solidGenerator setColorRed:209.0f/255.0f green:200.0f/255.0f blue:157.0f/255.0f alpha:1.0f];
        [solidGenerator forceProcessingAtSize:CGSizeMake(resultImage.size.width, resultImage.size.height)];
        GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
        opacityFilter.opacity = 0.30f;
        [solidGenerator addTarget:opacityFilter];
        
        // Blending
        GPUImageDarkenBlendFilter* darkenFilter = [[GPUImageDarkenBlendFilter alloc] init];
        [opacityFilter addTarget:darkenFilter atTextureLocation:1];
        GPUImagePicture* pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
        [pictureOriginal addTarget:darkenFilter];
        [pictureOriginal addTarget:solidGenerator];
        [pictureOriginal processImage];
        resultImage = [darkenFilter imageFromCurrentlyProcessedOutput];
    }
    
    
    
    /*
    GPUImageNormalBlendFilter* blendNormal = [[GPUImageNormalBlendFilter alloc] init];
    [gradientFilter addTarget:blendNormal atTextureLocation:1];
    pictureOriginal = [[GPUImagePicture alloc] initWithImage:resultImage];
    [pictureOriginal addTarget:gradientFilter];
    [pictureOriginal addTarget:blendNormal];
    [pictureOriginal processImage];
    return [blendNormal imageFromCurrentlyProcessedOutput];
     */
    
    /*
    pictureOriginal = [[GPUImagePicture alloc] initWithImage:solidImage];
    [pictureOriginal addTarget:gradientFilter];
    [pictureOriginal processImage];
    return [gradientFilter imageFromCurrentlyProcessedOutput];
     */
    
    

    return resultImage;
}


@end
