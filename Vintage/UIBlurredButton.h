//
//  UIBlurredButton.h
//  Vintage
//
//  Created by SSC on 2014/02/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "GPUImageSolidColorGenerator.h"
#import "GPUImageEffects.h"

@interface UIBlurredButton : UIButton

- (void)generateBackgroundImageByCaputuredImage:(UIImage *)inputImage;

@end
