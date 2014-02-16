//
//  UIEditorSliderView.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorSliderView.h"

@implementation UIEditorSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.70f;

        //// Slider
        CGFloat sliderWidth = frame.size.width - 68.0f;
        _slider = [[UISliderView alloc] initWithFrame:CGRectMake(46.0f, 0.0f, sliderWidth, 22.0f)];
        _slider.delegate = self;
        [self addSubview:_slider];
    }
    return self;
}

- (CGFloat)value
{
    return _slider.value;
}

- (void)setValue:(CGFloat)value
{
    _slider.value = value;
}

#pragma mark delegate

- (void)slider:(UISliderView*)slider DidValueChange:(CGFloat)value
{
    [self.delegate slider:self DidValueChange:value];
}

- (void)touchesBeganWithSlider:(UISliderView *)slider
{
    self.alpha = 1.0f;
    [self.delegate touchesBeganWithSlider:self];
}

- (void)touchesEndedWithSlider:(UISliderView *)slider
{
    self.alpha = 0.70f;
    [self.delegate touchesEndedWithSlider:self];
}

- (void)touchesMovedWithSlider:(UISliderView *)slider
{
    self.alpha = 1.0f;
}

@end
