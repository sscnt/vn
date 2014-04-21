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
    CGRect frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    self = [super initWithFrame:frame];
    if (self) {
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
    [self setIcon];
}

- (void)setIcon
{
    UIImage* iconImage;
    switch (self.toolId) {
        case VnAdjustmentToolIdEffects:
            iconImage = [UIImage imageNamed:@"a.png"];
            break;
        case VnAdjustmentToolIdTextures:
            iconImage = [UIImage imageNamed:@"b.png"];
            break;
        case VnAdjustmentToolIdTextureOpacity:
            iconImage = [UIImage imageNamed:@"e.png"];
            break;
        case VnAdjustmentToolIdEffectHistory:
            iconImage = [UIImage imageNamed:@"f.png"];
            break;
        default:
            break;
    }
    UIImageView* iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    iconImageView.center = self.center;
    iconImageView.image = iconImage;
    [self addSubview:iconImageView];
}

#pragma mark flag



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
