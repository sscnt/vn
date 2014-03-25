//
//  UIFocusControlView.h
//  Vintage
//
//  Created by SSC on 2014/03/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFocusRotationControlView.h"
#import "UIFocusMovementControlView.h"

typedef NS_ENUM(NSInteger, FocusType){
    FocusTypeTopAndBottom = 1,
    FocusTypeTopOnly,
    FocusTypeCircle
};

@class UIFocusControlView;

@protocol UIFocusControlViewDelegate
- (void)focus:(UIFocusControlView*)view didAngleChange:(CGFloat)angle;
- (void)focus:(UIFocusControlView*)view didPositionChange:(CGPoint)position;
- (BOOL)focusShouldChange;
@end

@interface UIFocusControlView : UIView <UIFocusRotationControlViewDelegate, UIFocusMovementControlViewDelegate>
{
    CGPoint _previousMovementCenter;
    CGPoint _previousRotationCenter;
    CGFloat _previousAngle;
    CGFloat _rotationDistance;
    UIFocusMovementControlView* _movementView;
    UIFocusRotationControlView* _rotationView;
}

@property (nonatomic, assign) CGPoint defaultPosition;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) FocusType type;
@property (nonatomic, assign) id<UIFocusControlViewDelegate> delegate;

@end
