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
- (void)touchesBeganWithSlider:(UISliderView*)slider;
- (void)touchesMovedWithSlider:(UISliderView*)slider;
- (void)touchesEndedWithSlider:(UISliderView*)slider;
@end

@interface UISliderView : UIView <UIGestureRecognizerDelegate>
{
    UILabel* _titleLabel;
    UISliderThumbVIew* _thumbView;
    CGFloat _thumbStartX;
    CGFloat _thumbEndX;
    CGFloat _alpha;
}

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<UISliderViewDelegate> delegate;

- (void)didDragThumb:(UIPanGestureRecognizer*)sender;
- (CGFloat)calcValueByThumbPosition:(CGFloat)x;
- (CGFloat)calcPoxitionByValue:(CGFloat)value;

@end
