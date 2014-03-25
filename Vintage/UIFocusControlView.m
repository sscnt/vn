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
        _defaultPosition = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
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
        
        self.angle = 0.0f;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    CGFloat rvangle = _angle + M_PI / 4.0f;
    CGFloat y = _rotationDistance * sinf(rvangle);
    CGFloat x = _rotationDistance * cosf(rvangle);
    //// Convert to Movement local
    CGFloat _x = x * 0.0f + y * 1.0;
    CGFloat _y = x * -1.0 + y * 0.0f;
    //// Convert to View local
    _x += _movementView.center.x;
    _y += _movementView.center.y;
    _rotationView.center = CGPointMake(_x, _y);
    [self setNeedsDisplay];
}

- (void)setPosition:(CGPoint)position
{
    CGFloat y = position.y - _movementView.center.y;
    CGFloat x = position.x - _movementView.center.x;
    _movementView.center = position;
    _rotationView.center = CGPointMake(_rotationView.center.x + x, _rotationView.center.y + y);
    [self setNeedsDisplay];
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
    //// Convert to Movement local
    CGFloat _rvx = _previousRotationCenter.x - _movementView.center.x;
    CGFloat _rvy = _previousRotationCenter.y - _movementView.center.y;
    CGFloat _tx = _rvx + x;
    CGFloat _ty = _rvy + y;
    
    //// Convert to 結ぶ線をy軸
    CGFloat __angle = -(_previousAngle + M_PI / 4.0f);
    CGFloat __x = _tx * cosf(__angle) - _ty * sinf(__angle);


    CGFloat _rvtx = _rvx - _tx;
    CGFloat _rvty = _rvy - _ty;
    
    CGFloat a = sqrt(_rvx * _rvx + _rvy * _rvy);
    CGFloat b = sqrt(_tx * _tx + _ty * _ty);
    CGFloat c = sqrt(_rvtx * _rvtx + _rvty * _rvty);
    
    CGFloat cos = (c * c - b * b - a * a) / (-2.0f * a * b);
    CGFloat radian = acosf(cos);
    if(__x < 0.0){
        radian = M_PI * 2.0f - radian;
    }
    
    //// Convert to Movement local
    radian += _previousAngle;
    if(radian > M_PI * 2.0f){
        radian -= M_PI * 2.0f;
    }
    
    CGFloat degree = radian * (180.0f / M_PI);
    LOG(@"%f", degree);
    
    self.angle = radian;

    
    //LOG(@"%fx%f, %fx%f", _rvx, _rvy, _tx, _ty);
    
}

- (void)rotationTouchesBegan:(UIFocusRotationControlView *)view
{
    LOG(@"rotationTouchesBegan");
    _previousRotationCenter = _rotationView.center;
    _previousAngle = _angle;
}

- (void)rotationTouchesEnded:(UIFocusRotationControlView *)view
{
    LOG(@"rotationTouchesEnded");
}

- (void)movement:(UIFocusMovementControlView *)view didDragX:(CGFloat)x y:(CGFloat)y
{
    //LOG(@"%fx%f", x, y);
    CGPoint new_center = CGPointMake(_previousMovementCenter.x + x, _previousMovementCenter.y + y);
    CGFloat max_y = self.frame.size.height - _movementView.frame.size.height / 2.0f;
    CGFloat min_y = _movementView.frame.size.height / 2.0f;
    CGFloat max_x = self.frame.size.width - _movementView.frame.size.width / 2.0f;
    CGFloat min_x = _movementView.frame.size.width / 2.0f;
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
    //LOG(@"Movement: %fx%f", new_center.x, new_center.y);
    self.position = new_center;
}

- (void)movementTouchesBegan:(UIFocusMovementControlView *)view
{
    LOG(@"movementTouchesBegan");
    _previousMovementCenter = _position;
}

- (void)movementTouchesEnded:(UIFocusMovementControlView *)view
{
    LOG(@"movementTouchesEnded");
    _position = _movementView.center;
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
    switch (_type) {
        case FocusTypeCircle:
        {
            
        }
            break;
        case FocusTypeTopAndBottom:
            [self drawRectTopAndBottom:rect];
            break;
        case FocusTypeTopOnly:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)drawRectTopAndBottom:(CGRect)rect
{
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.992 green: 0.616 blue: 0 alpha: 1];
    
    CGFloat width = (_movementView.center.x > _defaultPosition.x) ? _movementView.center.x : self.bounds.size.width - _movementView.center.x;
    CGFloat height = (_movementView.center.y > _defaultPosition.y) ? _movementView.center.y : self.bounds.size.height - _movementView.center.y;
    
    int area = (int)floorf(_angle / (M_PI / 2.0f));
    CGFloat angle;
    switch (area) {
        case 0:
            angle = _angle;
            break;
        case 1:
            angle = M_PI - _angle;
            break;
        case 2:
            angle = _angle - M_PI;
            break;
        case 3:
            angle = M_PI - (_angle - M_PI);
            break;
    }
    CGFloat taikakuLength;
    CGFloat x, y;
    CGFloat limitAngle = atanf(width / height);
    if (angle < limitAngle) {
        taikakuLength = height / cosf(angle);
    }else{
        taikakuLength = width / cosf(M_PI / 2.0f - angle);
    }
    CGFloat degree = angle * 180.0f / M_PI;
    taikakuLength *= 0.90f;
    if (angle < limitAngle) {
        x = taikakuLength * sinf(angle);
        y = -taikakuLength * cosf(angle);
    }else{
        angle = M_PI / 2.0f - angle;
        x = taikakuLength * cosf(angle);
        y = -taikakuLength * sinf(angle);
    }
    switch (area) {
        case 0:
            
            break;
        case 1:
            y = -y;
            break;
        case 2:
            x = -x;
            y = -y;
            break;
        case 3:
            x = -x;
            break;
    }
    x += _movementView.center.x;
    y += _movementView.center.y;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(x - 20.0f, y - 20.0f, 40, 40)];
    [color setFill];
    [ovalPath fill];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.0f, rect.size.height / 10.0f)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, rect.size.height / 4.0f)];
    [color setStroke];
    bezierPath.lineWidth = 3;
    [bezierPath stroke];
}

@end
