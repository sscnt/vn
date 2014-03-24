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
- (void)rotation:(UIFocusRotationControlView*)view didDragX:(CGFloat)x y:(CGFloat)y;
- (void)rotation:(UIFocusRotationControlView*)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)rotation:(UIFocusRotationControlView*)view touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIFocusRotationControlView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<UIFocusRotationControlViewDelegate> delegate;

@end
