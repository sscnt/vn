//
//  UIFocusTypeSelectButton.h
//  Vintage
//
//  Created by SSC on 2014/03/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFocusControlView.h"

@interface UIFocusTypeSelectButton : UIButton
{
    BOOL _selected;
}

- (id)initWithType:(FocusType)type;

@property (nonatomic, assign) FocusType type;
@property (nonatomic, assign) BOOL selected;

@end
