//
//  UIFocusTypeSelectButton.m
//  Vintage
//
//  Created by SSC on 2014/03/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIFocusTypeSelectButton.h"

@implementation UIFocusTypeSelectButton

- (id)initWithType:(FocusType)type
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        self.selected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(selected){
        self.alpha = 0.85f;
    }else{
        self.alpha = 0.40f;
    }
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    
    UIColor* fillColor = [UIColor colorWithWhite:26.0f/255.0f alpha:0.60f];
    UIColor* sepColor = [UIColor colorWithWhite:26.0f/255.0f alpha:1.0f];
    CGFloat radius = 12.0f;
    if(_selected){
        radius = 16.0f;
    }
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
    [fillColor setFill];
    [ovalPath fill];
    ovalPath.lineWidth = 2;
    [ovalPath stroke];
    
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
    
    //// Oval Drawing
    radius = 11.0f;
    ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
    [sepColor setStroke];
    ovalPath.lineWidth = 3;
    [ovalPath stroke];
    
    radius = 12.0f;
    ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
    [[UIColor whiteColor] setStroke];
    ovalPath.lineWidth = 2;
    [ovalPath stroke];
    
    
    if(_selected){
        //// Oval Drawing
        radius = 16.0f;
        ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
        [[UIColor whiteColor] setStroke];
        ovalPath.lineWidth = 2;
        [ovalPath stroke];
    }
}

- (void)drawRectTopAndBottom:(CGRect)rect
{
    CGFloat radius = 11.0f;
    CGFloat centerX = rect.size.width / 2.0f;
    CGFloat centerY = rect.size.height / 2.0f;
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.9];
    
    
    //// Bezier Drawing
    radius = 7.0f;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(centerX - radius, centerY + 7.0f)];
    [bezierPath addLineToPoint: CGPointMake(centerX + radius, centerY + 7.0f)];
    [color setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(centerX - radius, centerY - 7.0f)];
    [bezierPath addLineToPoint: CGPointMake(centerX + radius, centerY - 7.0f)];
    [color setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    //////// Bezier Drawing
    radius = 11.0f;
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(centerX - radius, centerY + 2.5f)];
    [bezierPath addLineToPoint: CGPointMake(centerX + radius, centerY + 2.5f)];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(centerX - radius, centerY - 2.5f)];
    [bezierPath addLineToPoint: CGPointMake(centerX + radius, centerY - 2.5f)];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
}


- (void)drawRectTopOnly:(CGRect)rect
{
    CGFloat radius = 11.0f;
    CGFloat centerX = rect.size.width / 2.0f;
    CGFloat centerY = rect.size.height / 2.0f;
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.9];
    
    
    //// Bezier Drawing
    radius = 7.0f;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(centerX - radius, centerY + 7.0f)];
    [bezierPath addLineToPoint: CGPointMake(centerX + radius, centerY + 7.0f)];
    [color setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    //////// Bezier Drawing
    radius = 11.0f;
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(centerX - radius, centerY + 2.0f)];
    [bezierPath addLineToPoint: CGPointMake(centerX + radius, centerY + 2.0f)];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
}

- (void)drawRectCircle:(CGRect)rect
{
    CGFloat radius = 11.0f;
    CGFloat centerX = rect.size.width / 2.0f;
    CGFloat centerY = rect.size.height / 2.0f;
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.9];
    
    
    //// Bezier Drawing
    radius = 7.0f;
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(centerX - radius, centerY - radius, radius * 2.0f, radius * 2.0f)];
    [color setStroke];
    [ovalPath stroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    //// Bezier Drawing
    radius = 3.0f;
    ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(centerX - radius, centerY - radius, radius * 2.0f, radius * 2.0f)];
    [color setFill];
    [ovalPath fill];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
}

@end
