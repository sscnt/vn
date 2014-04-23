//
//  VnViewEditorEffectsPresets.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorEffectPresetsListView.h"

@implementation VnViewEditorEffectPresetsListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _view.showsHorizontalScrollIndicator = NO;
        _view.showsVerticalScrollIndicator = NO;
        _view.bounces = NO;
        [self addSubview:_view];
        
        _itemViews = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor clearColor];
        
        _right = 0.0f;
    }
    return self;
}

- (void)addItemByEffectObject:(VnObjectEffect *)effect
{
    VnViewEditorEffectPresetItemView* item = [self itemViewByEffectId:effect.effectId];
    if (item == nil) {
        item = [[VnViewEditorEffectPresetItemView alloc] initWithEffect:effect];
        [item setX:_right];
        [self.view addSubview:item];
        _right = [item right];
        if (_right > self.view.contentSize.width) {
            self.view.contentSize = CGSizeMake(_right, self.view.contentSize.height);
        }
    }
}

- (VnViewEditorEffectPresetItemView *)itemViewByEffectId:(VnEffectId)effectId
{
    return [_itemViews objectForKey:[NSString stringWithFormat:@"%d", (int)effectId]];
}

@end
