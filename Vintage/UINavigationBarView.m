//
//  UISelectionNavigationBar.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UINavigationBarView.h"

@implementation UINavigationBarView

- (id)initWithPosition:(NavigationBarViewPosition)position
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 44.0f);
    if (position == NavigationBarViewPositionBottom) {
        frame = CGRectMake(0.0f, [UIScreen screenSize].height - 44.0f, [UIScreen screenSize].width, 44.0f);
    }
    self = [super initWithFrame:frame];
    if (self) {
        _position = position;
        _buttonWidth = 44.0f;
        _rightButtonPositionLeft = [UIScreen screenSize].width;
        _leftButtonPositionLeft = 0.0f;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _titleLabel.alpha = 0.9f;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.90f];
        _titleLabel.numberOfLines = 0;
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            _titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        } else {
            _titleLabel.font = [UIFont fontWithName:@"Aller-Bold" size:18.0f];
        }
        [self addSubview:_titleLabel];
        [self setOpacity:0.80f];
    }
    return self;
}

- (void)setOpacity:(CGFloat)opacity
{
    [self setBackgroundColor:[UIColor colorWithWhite:35.0f/255.0f alpha:opacity]];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)appendButtonToLeft:(UIButton *)button
{
    button.center = CGPointMake(ceilf(_buttonWidth / 2.0) + _leftButtonPositionLeft, 22.0f);
    [self addSubview:button];
    _leftButtonPositionLeft += button.bounds.size.width;
}

- (void)appendButtonToRight:(UIButton *)button
{
    button.center = CGPointMake(_rightButtonPositionLeft - ceilf(_buttonWidth / 2.0), 22.0f);
    [self addSubview:button];
    _rightButtonPositionLeft -= button.bounds.size.width;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat y = rect.size.height;
    if (self.position == NavigationBarViewPositionBottom) {
        y = 0.0f;
    }
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.0f, y)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, y)];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];

}


@end
