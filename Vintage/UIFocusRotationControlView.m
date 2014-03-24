//
//  UIFocusRotationControlView.m
//  Vintage
//
//  Created by SSC on 2014/03/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIFocusRotationControlView.h"

@implementation UIFocusRotationControlView

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDrag:)];
        recognizer.maximumNumberOfTouches = 1;
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)didDrag:(UIPanGestureRecognizer *)sender
{
    CGPoint transitionPoint = [sender translationInView:self];
    [self.delegate rotation:self didDragX:transitionPoint.x y:transitionPoint.y];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate rotation:self touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate rotation:self touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate rotation:self touchesEnded:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect
{
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.992 green: 0.616 blue: 0 alpha: 1];
    
    //// Oval Drawing
    CGFloat ovalRadius = 6.0f;
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - ovalRadius - 10.0f, rect.size.height / 2.0f - ovalRadius + 10.0f, ovalRadius * 2.0f, ovalRadius * 2.0f)];
    [color setStroke];
    ovalPath.lineWidth = 3;
    [ovalPath stroke];

}


@end
