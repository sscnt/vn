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
        _rotationView = [[UIFocusRotationControlView alloc] init];
        _rotationView.delegate = self;
        _rotationView.center = CGPointMake(self.frame.size.width / 2.0f + 40.0f, self.frame.size.height / 2.0f - 40.0f);
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
    LOG(@"Rotation: %fx%f", x, y);
}

- (void)rotation:(UIFocusRotationControlView *)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _previousAngle = _angle;
}

- (void)rotation:(UIFocusRotationControlView *)view touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
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

- (void)movement:(UIFocusMovementControlView *)view touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _previousCenter = self.center;
}

- (void)movement:(UIFocusMovementControlView *)view touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
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
