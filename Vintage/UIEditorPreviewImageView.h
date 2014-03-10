//
//  UIEditorPreviewImageView.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISelectionPreviewImageView.h"

@class UIEditorPreviewImageView;

@protocol UIEditorPreviewDelegate
- (void)previewIsReady:(UIEditorPreviewImageView*)preview;
@end

@interface UIEditorPreviewImageView : UISelectionPreviewImageView
{
    UIImageView* _imageViewOriginal;
    UIImageView* _imageViewBlurred;
}

@property (nonatomic, weak) UIImage* imageOriginal;
@property (nonatomic, weak) UIImage* imageBlurred;
@property (nonatomic, assign) id<UIEditorPreviewDelegate> delegate;

- (void)toggleBlurredImage:(BOOL)show;
- (void)toggleBlurredImage:(BOOL)show WithDuration:(CGFloat)duration;
- (void)toggleOriginalImage:(BOOL)show;

@end
