//
//  EffectsViewController.h
//  Vintage
//
//  Created by SSC on 2014/02/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISelectionPreviewImageView.h"
#import "GPUImageEffectsImport.h"
#import "EditorViewController.h"
#import "UINavigationBarView.h"
#import "UICloseButton.h"

@interface SelectionViewController : UIViewController
{
    BOOL _paused;
    BOOL _viewDidOnceAppear;
    int _currentProcessingIndex;
    int _numberOfEffects;
    UIImage* _imageResized;
    NSMutableArray* _arrayPreviews;
    NSMutableArray* _arrayEffects;
    UIScrollView* _scrollView;
}

@property (nonatomic, strong) UIImage* imageOriginal;

- (id)initWithImage:(UIImage*)image;
- (void)applyEffectAtIndex:(int)index;
- (void)resizeOriginalImageWidth:(CGFloat)width Height:(CGFloat)height;

- (void)didSelectPreview:(UISelectionPreviewImageView*)preview;
- (void)didPressCloseButton;

@end
