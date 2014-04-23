//
//  VnViewEditorEffectsPresets.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VnViewEditorEffectPresetItemView.h"

@interface VnViewEditorEffectPresetsListView : UIView
{
    NSMutableDictionary* _itemViews;
    float _right;
}

@property (nonatomic, strong) UIScrollView* view;

- (void)addItemByEffectObject:(VnObjectEffect*)effect;
- (VnViewEditorEffectPresetItemView*)itemViewByEffectId:(VnEffectId)effectId;

@end