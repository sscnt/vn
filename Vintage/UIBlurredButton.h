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

typedef NS_ENUM(NSInteger, BlurredButtonIconType){
    BlurredButtonIconTypeCamera = 1,
    BlurredButtonIconTypePhotos
};

@class UIBlurredButton;

@protocol UIBlurredButtonDelegate
- (void)buttonDidCreateBgImage:(UIBlurredButton*)button;
@end

@interface UIBlurredButton : UIButton

@property (nonatomic, weak) id<UIBlurredButtonDelegate> delegate;
@property (nonatomic, assign) BOOL isReady;

- (id)initWithFrame:(CGRect)frame Type:(BlurredButtonIconType)type;
- (void)generateBackgroundImageByCaputuredImage:(UIImage *)inputImage;
- (void)setIcon:(BlurredButtonIconType)type;

@end
