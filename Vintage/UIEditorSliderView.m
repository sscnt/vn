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
        self.userInteractionEnabled = YES;

        //// Slider
        CGFloat sliderWidth = frame.size.width - 78.0f;
        _slider = [[UISliderView alloc] initWithFrame:CGRectMake(46.0f, 0.0f, sliderWidth, 22.0f)];
        _slider.center = CGPointMake(_slider.center.x, self.bounds.size.height / 2.0f);
        _slider.delegate = self;
        [self addSubview:_slider];
        
        self.alpha = 0.70f;
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

- (void)setTitle:(NSString *)title
{
    _title = title;
    _slider.title = title;
}

- (void)setIconType:(EditorSliderIconType)iconType
{
    switch (iconType) {
        case EditorSliderIconTypeOpacity:
            _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"opacity-60.png"]];
            break;
    }
    _iconImageView.center = _slider.center;
    _iconImageView.center = CGPointMake(23.0f, self.bounds.size.height / 2.0f);
    _iconImageView.alpha = _alpha;
    [self addSubview:_iconImageView];
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

}

- (void)setTitlePosition:(SliderViewTitlePosition)titlePosition
{
    _slider.titlePosition = titlePosition;
}

- (void)setAlpha:(CGFloat)alpha
{
    _alpha = alpha;
    if(_slider){
        _slider.alpha = alpha;
    }
    if (_iconImageView) {
        _iconImageView.alpha = alpha;
    }
}

@end
