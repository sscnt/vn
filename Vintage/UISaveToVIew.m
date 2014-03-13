//
//  UISaveToVIew.m
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISaveToView.h"

@implementation UISaveToView

- (id)init
{
    CGFloat buttonHeight = 50.0f;
    CGRect frame = CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, buttonHeight * 1.0f);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.70f];
        
        //// Camera roll
        _buttonCameraRoll = [[UISaveToButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, buttonHeight)];
        _buttonCameraRoll.tag = SaveToCameraRoll;
        [_buttonCameraRoll addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonCameraRoll setTitle:NSLocalizedString(@"CAMERA ROLL", Nil) forState:UIControlStateNormal];
        [self addSubview:_buttonCameraRoll];        
    }
    return self;
}

- (void)didPressButton:(UISaveToButton *)button
{
    [self.delegate saveToView:self DidSelectSaveTo:button.tag];
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
