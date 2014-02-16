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
@property (nonatomic, assign) BOOL isPreviewReady;
@property (nonatomic, strong) UIImageView* imageViewPreview;

- (void)removeLoadingIndicator;
- (BOOL)isPreviewReady;

@end
