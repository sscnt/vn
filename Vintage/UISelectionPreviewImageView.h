//
//  UISelectionPreviewImageView.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImageEffects.h"

@interface UISelectionPreviewImageView : UIButton
{
    UIImageView* _imageViewLoading;
}

@property (nonatomic, assign) EffectId effectId;
@property (nonatomic, assign) CGFloat opacity;
@property (nonatomic, assign) BOOL isPreviewReady;
@property (nonatomic, strong) UIImageView* previewImageView;

- (void)removeLoadingIndicator;
- (void)setPreviewImage:(UIImage*)image;
- (void)setPreviewImage:(UIImage*)image WithDuration:(CGFloat)duration;
- (void)reset;

@end
