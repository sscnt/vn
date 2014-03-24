//
//  UIFocusControlView.m
//  Vintage
//
//  Created by SSC on 2014/03/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIFocusControlView.h"

@implementation UIFocusControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //// 12時の方向を0
        _angle = 0.0f;
        _defaultPosition = self.center;
        _position = _defaultPosition;
        self.backgroundColor = [UIColor clearColor];
        
        //// Rotation
        _rotationDistance = 50.0f;
        _rotationView = [[UIFocusRotationControlView alloc] init];
        _rotationView.delegate = self;
        _rotationView.center = CGPointMake(self.frame.size.width / 2.0f + _rotationDistance * cosf(M_PI / 4.0f), self.frame.size.height / 2.0f - _rotationDistance * sinf(M_PI / 4.0f));
        [self addSubview:_rotationView];
        
        //// Movement
        _movementView = [[UIFocusMovementControlView alloc] init];
        _movementView.delegate = self;
        _movementView.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
        [self addSubview:_movementView];
        
    }
    return self;
}
- (void)setActive:(BOOL)active
{
    _active = active;
    if(active){
        self.alpha = 1.0f;
    }else{
        self.alpha = 0.40f;
    }
}

- (void)rotation:(UIFocusRotationControlView *)view didDragX:(CGFloat)x y:(CGFloat)y
{
    CGFloat degrees;
    CGFloat rv_angle = _angle + M_PI / 4.0f;
    CGPoint rcenter = CGPointMake(_rotationDistance * cosf(rv_angle) + _movementView.center.x, _movementView.center.y - _rotationDistance * sinf(rv_angle));
    //LOG(@"%fx%f; %fx%f", rcenter.x, rcenter.y, _rotationView.center.x, _rotationView.center.y);
    CGFloat _x = (x + ((rcenter.x - 10.0f) - _movementView.center.x));
    CGFloat _y = (y + ((rcenter.y + 10.0f) - _movementView.center.y));
    //LOG(@"%fx%f", _x, _y);
    CGFloat new_angle;
    if(_x == 0.0f){
        if(_y > 0.0f){
            new_angle = M_PI_2;
        }else{
            new_angle = M_PI * 3.0 / 4.0f;
        }
    }else{
        if(_x < 0.0f){
            if(_y < 0.0f){
                new_angle = atanf(-_y / -_x) + M_PI;
            
            }else{
                new_angle = M_PI - atanf(_y / -_x);
                
            }
        }else{
            if(_y < 0.0f){
                new_angle = M_PI * 2.0f - atanf(-_y / _x);
                
            }else{
                new_angle = atanf(_y / _x);
            }
        }
    }
    new_angle += M_PI / 4.0f;
    if(new_angle > M_PI * 2.0f){
        new_angle -= M_PI * 2.0f;
    }
    degrees = new_angle * (180 / M_PI);
    //self.transform = CGAffineTransformMakeRotation(_previousAngle + new_angle);
    LOG(@"%fx%f; %f",_x, _y, degrees);
}

- (void)rotationTouchesBegan:(UIFocusRotationControlView *)view
{
    LOG(@"rotationTouchesBegan");
    _previousAngle = _angle;
}

- (void)rotationTouchesEnded:(UIFocusRotationControlView *)view
{
    LOG(@"rotationTouchesEnded");
    _angle = atan2f(self.transform.b, self.transform.a);
    LOG(@"%f", _angle * (180 / M_PI));
}

- (void)movement:(UIFocusMovementControlView *)view didDragX:(CGFloat)x y:(CGFloat)y
{
    CGPoint new_center = CGPointMake(_previousCenter.x + x, _previousCenter.y + y);
    CGFloat max_y = _defaultPosition.y + self.frame.size.height / 2.0f - _movementView.frame.size.height / 2.0f;
    CGFloat min_y = _defaultPosition.y - self.frame.size.height / 2.0f + _movementView.frame.size.height / 2.0f;
    CGFloat max_x = _defaultPosition.x + self.frame.size.width / 2.0f - _movementView.frame.size.width / 2.0f;
    CGFloat min_x = _defaultPosition.x - self.frame.size.width / 2.0f + _movementView.frame.size.width / 2.0f;
    if(new_center.x > max_x){
        new_center = CGPointMake(max_x, new_center.y);
    }else if(new_center.x < min_x){
        new_center = CGPointMake(min_x, new_center.y);
    }
    if(new_center.y > max_y){
        new_center = CGPointMake(new_center.x, max_y);
    }else if(new_center.y < min_y){
        new_center = CGPointMake(new_center.x, min_y);
    }
    LOG(@"Movement: %fx%f", new_center.x, new_center.y);
    self.center = new_center;
}

- (void)movementTouchesBegan:(UIFocusMovementControlView *)view
{
    LOG(@"movementTouchesBegan");
    _previousCenter = self.center;
}

- (void)movementTouchesEnded:(UIFocusMovementControlView *)view
{
    LOG(@"movementTouchesEnded");
    _position = self.center;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 現在イベントが発生しているViewを取得
    UIView *nowHitView = [super hitTest:point withEvent:event];
    
    // 自分自身(UIView）だったら透過して(nilを返すとイベントを取得しなくなる)
    if ( self == nowHitView )
    {
        return nil;
    }
    return nowHitView;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}


@end
