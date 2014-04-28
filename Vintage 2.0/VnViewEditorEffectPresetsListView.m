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
        _view.bounces = YES;
        [self addSubview:_view];
        
        _itemViews = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor clearColor];
        
        _right = [VnEditorViewManager presetImageViewPaddingLeft] * 2.0f;
        _top = 0.0f;
    }
    return self;
}

- (void)addItemByEffectObject:(VnObjectEffect *)effect
{
    VnViewEditorEffectPresetItemView* item = [self itemViewByEffectId:effect.effectId];
    if (item == nil) {
        item = [[VnViewEditorEffectPresetItemView alloc] initWithEffect:effect];
        [item setX:_right - [VnEditorViewManager presetImageViewPaddingLeft]];
        [item setY:_top];
        [self.view addSubview:item];
        CGFloat __r;
        
        if ([VnCurrentSettings workspaceOrientation] == VnCurrentSettingsWorkspaceOrientationPortrait) {
            _right = [item right] + [VnEditorViewManager presetImageViewPaddingLeft];
            __r = _right;
        } else {
            if (_top == 0.0f) {
                _top = [VnEditorViewManager presetImageViewBounds].size.height;
                CGFloat __r = [item right] + [VnEditorViewManager presetImageViewPaddingLeft];
            } else {
                _top = 0.0f;
                _right = [item right] + [VnEditorViewManager presetImageViewPaddingLeft];
                __r = _right;
            }
        }
        if (__r > self.view.contentSize.width) {
            self.view.contentSize = CGSizeMake(__r, self.view.contentSize.height);
        }
        [_itemViews setObject:item forKey:[NSString stringWithFormat:@"%d", (int)effect.effectId]];
    }
}

- (VnViewEditorEffectPresetItemView *)itemViewByEffectId:(VnEffectId)effectId
{
    return [_itemViews objectForKey:[NSString stringWithFormat:@"%d", (int)effectId]];
}

@end
