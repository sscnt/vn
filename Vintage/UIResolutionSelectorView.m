//
//  UIResolutionSelectorView.m
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIResolutionSelectorView.h"

@implementation UIResolutionSelectorView

- (id)init
{
    CGFloat buttonHeight = 50.0f;
    CGFloat labelHeight = 40.0f;
    CGRect frame = CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, buttonHeight * 3.0f + labelHeight);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.70f];
        _maxImageHeight = 0.0f;
        _maxImageWidth = 0.0f;
        
        //// Label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 15.0f, frame.size.width, labelHeight)];
        label.text = NSLocalizedString(@"RESOLUTION", nil);
        label.textColor = [UIColor colorWithWhite:1.0f alpha:0.95f];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
            [label setY:3.0f];
        }else{
            label.font = [UIFont fontWithName:@"Aller-Bold" size:16.0f];
            [label setY:3.0f];
        }
        [self addSubview:label];
        
        //// Small
        _buttonSmall = [[UIResolutionSelectButton alloc] initWithFrame:CGRectMake(0.0f, label.frame.size.height, frame.size.width, buttonHeight)];
        _buttonSmall.tag = ImageResolutionSmall;
        [_buttonSmall addTarget:self action:@selector(didButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonSmall];
        //// Midium
        _buttonMidium = [[UIResolutionSelectButton alloc] initWithFrame:CGRectMake(0.0f, _buttonSmall.bottom, frame.size.width, buttonHeight)];
        _buttonMidium.tag = ImageResolutionMidium;
        [_buttonMidium addTarget:self action:@selector(didButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonMidium];
        //// Max
        _buttonMax = [[UIResolutionSelectButton alloc] initWithFrame:CGRectMake(0.0f, _buttonMidium.bottom, frame.size.width, buttonHeight)];
        _buttonMax.tag = ImageResolutionMax;
        [_buttonMax addTarget:self action:@selector(didButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonMax];
    }
    return self;
}

- (void)didButtonPress:(UIResolutionSelectButton *)button
{
    _buttonMax.selected = NO;
    _buttonMidium.selected = NO;
    _buttonSmall.selected = NO;
    button.selected = YES;
    [self.delegate selector:self DidSelectResolution:button.tag];
}

- (void)setResolution:(ImageResolution)resolution
{
    _buttonMax.selected = NO;
    _buttonMidium.selected = NO;
    _buttonSmall.selected = NO;
    if(resolution == ImageResolutionMax){
        _buttonMax.selected = YES;
        return;
    }
    if(resolution == ImageResolutionMidium){
        _buttonMidium.selected = YES;
        return;
    }
    if(resolution == ImageResolutionSmall){
        _buttonSmall.selected = YES;
        return;
    }
}

- (void)setMaxImageHeight:(CGFloat)maxImgaeHeight
{
    _maxImageHeight = maxImgaeHeight;
    [self updateButtonText];
}

- (void)setMaxImageWidth:(CGFloat)maxImgaeWidth
{
    _maxImageWidth = maxImgaeWidth;
    if(_maxImageWidth > 4096.0f){
        _maxImageWidth = 4096.0f;
    }
    [self updateButtonText];
}

- (void)updateButtonText
{
    [_buttonSmall setTitle:[NSString stringWithFormat:@"%@ %dx%d", NSLocalizedString(@"SMALL", nil), (int)_maxImageWidth / 4, (int)_maxImageHeight / 4] forState:UIControlStateNormal];
    [_buttonMidium setTitle:[NSString stringWithFormat:@"%@ %dx%d", NSLocalizedString(@"MEDIUM", nil), (int)_maxImageWidth / 2, (int)_maxImageHeight / 2] forState:UIControlStateNormal];
    [_buttonMax setTitle:[NSString stringWithFormat:@"%@ %dx%d", NSLocalizedString(@"MAX", nil), (int)_maxImageWidth, (int)_maxImageHeight] forState:UIControlStateNormal];
    
}

@end
