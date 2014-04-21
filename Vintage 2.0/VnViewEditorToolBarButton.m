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
    CGRect frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    self = [super initWithFrame:frame];
    if (self) {
        _childButtons = [NSMutableArray array];
        self.delegate = [VnEditorButtonManager instance];
        [self addTarget:self action:@selector(didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setIcon
{
    UIImage* iconImage;
    switch (_type) {
        case VnViewEditorToolBarButtonTypeEffect:
            
            break;            
        default:
            break;
    }
    UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    iconImageView.image = iconImage;
    [self addSubview:iconImageView];
}

#pragma mark event

- (void)didTouchUpInside
{
    [self.delegate didToolBarButtonTouchUpInside:self];
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
