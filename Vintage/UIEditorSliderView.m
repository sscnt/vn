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

        //// Slider
        CGFloat sliderWidth = frame.size.width - 68.0f;
        _slider = [[UISliderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, sliderWidth, 24.0f)];
        [self addSubview:_slider];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
