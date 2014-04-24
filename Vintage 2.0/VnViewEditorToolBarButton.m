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
        self.alpha = 0.80f;
        [self addTarget:self action:@selector(didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
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
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [VnCurrentSettings buttonHighlightedBgColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    _view.selected = selected;
    [_view setNeedsDisplay];
}

- (void)setColored:(BOOL)colored
{
    _colored = colored;
    _view.colored = colored;
    [_view setNeedsDisplay];
}

#pragma mark children

- (int)childButtonsCount
{
    return (int)[_childButtons count];
}

- (void)addChildButton:(VnViewEditorToolBarButton *)button
{
    if (button) {
        [_childButtons addObject:button];
        
        // test
        [button setY:-[self height] / 2.0f];
        [self addSubview:button];
    }
}

#pragma mark flag



#pragma mark event

- (void)didTouchUpInside
{
    [self.delegate didToolBarButtonTouchUpInside:self];
}

@end
