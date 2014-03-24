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
- (void)movement:(UIFocusMovementControlView *)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)movement:(UIFocusMovementControlView *)view touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIFocusMovementControlView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<UIFocusMovementControlViewDelegate> delegate;

@end
