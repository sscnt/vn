//
//  UIPortrateImageView.m
//  Vintage
//
//  Created by SSC on 2014/03/13.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIPortrateImageView.h"

@implementation UIPortrateImageView

- (void)setImage:(UIImage *)image
{
    /*
    UIImage * portraitImage;
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        portraitImage = [[UIImage alloc] initWithCGImage: image.CGImage scale: 1.0 orientation: UIImageOrientationUp];
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        portraitImage = [[UIImage alloc] initWithCGImage: image.CGImage scale: 1.0 orientation: UIImageOrientationUp];
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        portraitImage = [[UIImage alloc] initWithCGImage: image.CGImage scale: 1.0 orientation: UIImageOrientationUp];
    } else if (orientation == UIDeviceOrientationPortrait) {
        portraitImage = image;
    }
     */
    [super setImage:image];
}


@end