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
        _distance = 0.50f;
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
        
        _type = FocusTypeTopAndBottom;
        self.angle = 0.0f;
        self.active = NO;
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

- (void)setDistance:(CGFloat)distance
{
    _distance = distance;
    [self setNeedsDisplay];
}

- (void)setActive:(BOOL)active
{
    _active = active;
    [self setNeedsDisplay];
}

- (void)setType:(FocusType)type
{
    _type = type;
    [self setNeedsDisplay];
}

- (void)rotation:(UIFocusRotationControlView *)view didDragX:(CGFloat)x y:(CGFloat)y
{
    if(![self.delegate focusShouldChange]){
        return;
    }
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
    
    if(a * b == 0.0f){
        return;
    }
    
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
    if(![self.delegate focusShouldChange]){
        return;
    }
    LOG(@"rotationTouchesBegan");
    _previousRotationCenter = _rotationView.center;
    _previousAngle = _angle;
    self.active = YES;
    [self.delegate focusTouchesBegan:self];
}

- (void)rotationTouchesEnded:(UIFocusRotationControlView *)view
{
    LOG(@"rotationTouchesEnded");
    [self.delegate focus:self didAngleChange:_angle];
    self.active = NO;
}

- (void)movement:(UIFocusMovementControlView *)view didDragX:(CGFloat)x y:(CGFloat)y
{
    if(![self.delegate focusShouldChange]){
        return;
    }
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
    if(![self.delegate focusShouldChange]){
        return;
    }
    LOG(@"movementTouchesBegan");
    _previousMovementCenter = _position;
    self.active = YES;
    [self.delegate focusTouchesBegan:self];
}

- (void)movementTouchesEnded:(UIFocusMovementControlView *)view
{
    LOG(@"movementTouchesEnded");
    _position = _movementView.center;
    CGPoint convertedPosition = CGPointMake(_movementView.center.x / self.bounds.size.width, _movementView.center.y / self.bounds.size.height);
    self.active = NO;
    [self.delegate focus:self didPositionChange:convertedPosition];
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
            [self drawRectCircle:rect];
            break;
        case FocusTypeTopAndBottom:
            [self drawRectTopAndBottom:rect];
            break;
        case FocusTypeTopOnly:
            [self drawRectTopOnly:rect];
            break;
        default:
            break;
    }
}

- (void)drawLineAtDistance:(CGFloat)distance Angle:(CGFloat)angle Rect:(CGRect)rect LineWidth:(CGFloat)lineWidth
{
    
    if (angle >= M_PI * 2.0f) {
        angle -= M_PI * 2.0f;
    }
    //// Color Declarations
    CGFloat alpha = 1.0f;
    if (!_active) {
        alpha = 0.40f;
    }
    UIColor* color = [UIColor colorWithRed: 0.992 green: 0.616 blue: 0 alpha: alpha];
    
    CGFloat width = (_movementView.center.x > _defaultPosition.x) ? _movementView.center.x : self.bounds.size.width - _movementView.center.x;
    CGFloat height = (_movementView.center.y > _defaultPosition.y) ? _movementView.center.y : self.bounds.size.height - _movementView.center.y;
    int area = (int)floorf(angle / (M_PI / 2.0f));
    CGFloat __angle;
    switch (area) {
        case 4:
        case 0:
            __angle = angle;
            break;
        case 1:
            __angle = M_PI - angle;
            break;
        case 2:
            __angle = angle - M_PI;
            break;
        case 3:
            __angle = M_PI - (angle - M_PI);
            break;
    }
    CGFloat taikakuLength;
    CGFloat x, y;
    CGFloat limitAngle = atanf(width / height);
    if (__angle < limitAngle) {
        taikakuLength = sqrt(width * width + height * height) * cosf(limitAngle - __angle);
    }else{
        taikakuLength = sqrt(width * width + height * height) * cosf(__angle - limitAngle);
    }
    CGFloat degree = __angle * 180.0f / M_PI;
    taikakuLength *= distance;
    if (__angle < limitAngle) {
        x = taikakuLength * sinf(__angle);
        y = -taikakuLength * cosf(__angle);
    }else{
        __angle = M_PI / 2.0f - __angle;
        x = taikakuLength * cosf(__angle);
        y = -taikakuLength * sinf(__angle);
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
    
    CGFloat lineLength = sqrt(4.0 * self.bounds.size.width * self.bounds.size.width + 4.0 * self.bounds.size.height * self.bounds.size.height);
    
    //// Movement local
    CGFloat startX = -lineLength / 2.0f;
    CGFloat startY = 0.0f;
    CGFloat endX = lineLength / 2.0f;
    CGFloat endY = 0.0f;
    
    CGFloat _startX = startX * cosf(angle) - startY * sinf(angle);
    CGFloat _startY = startX * sinf(angle) + startY * cosf(angle);
    CGFloat _endX = endX * cosf(angle) - endY * sinf(angle);
    CGFloat _endY = endX * sinf(angle) + endY * cosf(angle);
    
    //// Convert to View local
    _startX += x;
    _endX += x;
    _startY += y;
    _endY += y;
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(_startX, _startY)];
    [bezierPath addLineToPoint: CGPointMake(_endX, _endY)];
    [color setStroke];
    bezierPath.lineWidth = lineWidth;
    [bezierPath stroke];

}

- (void)drawRectTopAndBottom:(CGRect)rect
{
    CGFloat medium = 0.55f + 0.2f * _distance;
    CGFloat small = 0.25 + 0.4f * _distance;
    [self drawLineAtDistance:0.85f Angle:_angle Rect:rect LineWidth:5.0f];
    [self drawLineAtDistance:0.85f Angle:_angle + M_PI Rect:rect LineWidth:5.0f];
    [self drawLineAtDistance:medium Angle:_angle Rect:rect LineWidth:2.0f];
    [self drawLineAtDistance:medium Angle:_angle + M_PI Rect:rect LineWidth:2.0f];
    [self drawLineAtDistance:small Angle:_angle Rect:rect LineWidth:1.0f];
    [self drawLineAtDistance:small Angle:_angle + M_PI Rect:rect LineWidth:1.0f];
}

- (void)drawRectTopOnly:(CGRect)rect
{
    CGFloat medium = 0.55f + 0.2f * _distance;
    CGFloat small = 0.25 + 0.4f * _distance;
    [self drawLineAtDistance:0.85f Angle:_angle + M_PI Rect:rect LineWidth:5.0f];
    [self drawLineAtDistance:medium Angle:_angle + M_PI Rect:rect LineWidth:2.0f];
    [self drawLineAtDistance:small Angle:_angle + M_PI Rect:rect LineWidth:1.0f];
}

- (void)drawCircleAtDistance:(CGFloat)distance Rect:(CGRect)rect LineWidth:(CGFloat)lineWidth
{
    CGFloat centerX = _movementView.center.x;
    CGFloat centerY = _movementView.center.y;
    CGFloat width = (centerX > _defaultPosition.x) ? centerX : self.bounds.size.width - centerX;
    CGFloat height = (centerY > _defaultPosition.y) ? centerY : self.bounds.size.height - centerY;
    CGFloat maxRadius = sqrt(width * width + height * height);
    
    CGFloat alpha = 1.0f;
    if (!_active) {
        alpha = 0.40f;
    }
    UIColor* color = [UIColor colorWithRed: 0.992 green: 0.616 blue: 0 alpha: alpha];
    
    
    //// Oval Drawing
    CGFloat radius = maxRadius * distance;
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(centerX - radius, centerY - radius, radius * 2.0f, radius * 2.0f)];
    [color setStroke];
    ovalPath.lineWidth = lineWidth;
    [ovalPath stroke];
    

}

- (void)drawRectCircle:(CGRect)rect
{
    CGFloat medium = 0.55f + 0.2f * _distance;
    CGFloat small = 0.25 + 0.4f * _distance;
    [self drawCircleAtDistance:0.85f Rect:rect LineWidth:5.0f];
    [self drawCircleAtDistance:medium Rect:rect LineWidth:2.0f];
    [self drawCircleAtDistance:small Rect:rect LineWidth:1.0f];
    
}

@end
