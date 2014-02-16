//
//  UISliderVIew.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISliderThumbVIew.h"

@class UISliderView;

@protocol UISliderViewDelegate
- (void)slider:(UISliderView*)slider DidValueChange:(CGFloat)value;
@end

@interface UISliderView : UIView
{
    UILabel* _titleLabel;
    UISliderThumbVIew* _thumbView;
    CGFloat _thumbStartX;
    CGFloat _thumbEndX;
}

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<UISliderViewDelegate> delegate;

- (void)didDragThumb:(UIPanGestureRecognizer*)sender;

@end
