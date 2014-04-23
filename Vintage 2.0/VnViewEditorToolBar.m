//
//  VnVIewEditorToolBar.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorToolBar.h"

@implementation VnViewEditorToolBar

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen width], [VnCurrentSettings barHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        _right = 0.0f;
        _view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _view.showsVerticalScrollIndicator = NO;
        _view.showsHorizontalScrollIndicator = NO;
        _view.bounces = NO;
        [self addSubview:_view];
        self.backgroundColor = [UIColor colorWithRed:s255(37.0f) green:s255(35.0f) blue:s255(35.0f) alpha:1.0];
    }
    return self;
}

- (void)appendButton:(VnViewEditorToolBarButton *)button
{
    if (!button) {
        return;
    }
    [button setX:_right];
    [self.view addSubview:button];
    _right = [button right];
    if (_right > self.view.contentSize.width) {
        _view.contentSize = CGSizeMake(_right, self.view.contentSize.height);
    }
}

@end
