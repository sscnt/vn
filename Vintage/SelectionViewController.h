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

@interface SelectionViewController : UIViewController
{
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

@end
