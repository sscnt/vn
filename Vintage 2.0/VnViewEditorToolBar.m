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
        _stage = 1;
        _right = 0.0f;
        _view = [[VnViewHitThroughScroll alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_view];
    }
    return self;
}

- (void)setStage:(int)stage
{
    _stage = stage;
    [self setHeight:(float)stage * [VnCurrentSettings barHeight]];
    [_view setHeight:(float)stage * [VnCurrentSettings barHeight]];
    [self setNeedsDisplay];
    if (_currentOpeningButton) {
        [self openButton:_currentOpeningButton];
    }
}

- (void)openButton:(VnViewEditorToolBarButton *)button
{
    for(VnViewEditorToolBarButton* button in [_view subviews]){
        button.stage = 1;
        [button setY:(float)(_stage - 1) * [VnCurrentSettings barHeight]];
    }
    button.stage = _stage;
    [button setY:0.0f];
    _currentOpeningButton = button;
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

- (void)drawRect:(CGRect)rect
{
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, rect.size.height - [VnCurrentSettings barHeight], rect.size.width, [VnCurrentSettings barHeight])];
    [[VnCurrentSettings barBgColor] setFill];
    [rectanglePath fill];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
