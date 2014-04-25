//
//  VnViewEditorToolBarButton.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorToolBarButton.h"

@implementation VnViewEditorToolBarButton

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [VnCurrentSettings barHeight], [VnCurrentSettings barHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[VnViewEditorToolBarButtonBgView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [self addSubview:_view];
        _childButtons = [NSMutableArray array];
        self.delegate = [VnEditorButtonManager instance];
        self.backgroundColor = [UIColor clearColor];
        [self addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        _childButtonsHidden = YES;
        _isChild = NO;
    }
    return self;
}

- (void)setToolId:(VnAdjustmentToolId)toolId
{
    _toolId = toolId;
    _view.toolId = toolId;
    [_view setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    _view.selected = selected;
    [_view setNeedsDisplay];
}

- (void)setColored:(BOOL)colored
{
    _colored = colored;
    _view.colored = colored;
    [_view setNeedsDisplay];
}


- (void)setStage:(int)stage
{
    _stage = stage;
    [self setHeight:(float)stage * [VnCurrentSettings barHeight]];
    [_view setY:(float)(stage - 1) * [VnCurrentSettings barHeight]];
    if (_childButtonsHidden) {
        
    }else{
        [self layoutChildButtons];
    }
}

#pragma mark children

- (int)childButtonsCount
{
    return (int)[_childButtons count];
}

- (void)addChildButton:(VnViewEditorToolBarButton *)button
{
    if (button) {
        button.isChild = YES;
        button.parentButton = self;
        [_childButtons addObject:button];
        
        [self addSubview:button];
        [self layoutChildButtons];
    }
}

- (void)layoutChildButtons
{
    int i = 0;
    for (VnViewEditorToolBarButton* button in _childButtons) {
        if (![button isDescendantOfView:self]) {
            [self addSubview:button];
        }
        button.hidden = _childButtonsHidden;
        [button setY:(float)i * [VnCurrentSettings barHeight]];
        i++;
    }
    [self bringSubviewToFront:_view];
}

- (void)setChildButtonsHidden:(BOOL)childButtonsHidden
{
    if ([self childButtonsCount] > 0) {
        for (VnViewEditorToolBarButton* button in _childButtons) {
            button.hidden = childButtonsHidden;
        }
    }
    _childButtonsHidden = childButtonsHidden;
}

#pragma mark flag



#pragma mark event

- (void)didTouchUpInside:(VnViewEditorToolBarButton *)sender
{
    [self.delegate didToolBarButtonTouchUpInside:self];
}

@end
