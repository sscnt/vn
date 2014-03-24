//
//  UIFocusRotationControlView.h
//  Vintage
//
//  Created by SSC on 2014/03/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIFocusRotationControlView;

@protocol UIFocusRotationControlViewDelegate
- (void)rotation:(UIFocusRotationControlView*)view didAngleChange:(CGFloat)angle;
@end

@interface UIFocusRotationControlView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<UIFocusRotationControlViewDelegate> delegate;

@end
