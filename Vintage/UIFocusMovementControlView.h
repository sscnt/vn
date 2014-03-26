//
//  UIFocusMovementControlView.h
//  Vintage
//
//  Created by SSC on 2014/03/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIFocusMovementControlView;

@protocol UIFocusMovementControlViewDelegate
- (void)movement:(UIFocusMovementControlView*)view didDragX:(CGFloat)x y:(CGFloat)y;
- (void)movementTouchesBegan:(UIFocusMovementControlView *)view;
- (void)movementTouchesEnded:(UIFocusMovementControlView *)view;
@end

@interface UIFocusMovementControlView : UIView <UIGestureRecognizerDelegate>
{
    BOOL _dragStarted;
}

@property (nonatomic, assign) id<UIFocusMovementControlViewDelegate> delegate;

@end
