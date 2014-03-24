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
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragThumb:)];
        recognizer.maximumNumberOfTouches = 1;
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];

    }
    return self;
}


- (void)didDragThumb:(UIPanGestureRecognizer *)sender
{
    if(_locked){
        return;
    }
    UISliderThumbVIew* thumbView = _thumbView;
    CGPoint transitionPoint = [sender translationInView:thumbView];
    
    CGFloat x = thumbView.center.x + transitionPoint.x;
    if (x > _thumbEndX) {
        x = _thumbEndX;
    }else if (x < _thumbStartX){
        x = _thumbStartX;
    }
    
    CGPoint movedPoint = CGPointMake(x, thumbView.center.y);
    thumbView.center = movedPoint;
    
    _value = [self calcValueByThumbPosition:x];
    [self.delegate slider:self DidValueChange:_value];
    
    [sender setTranslation:CGPointZero inView:thumbView];
    
    switch (sender.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            [self.delegate touchesBeganWithSlider:self];
            break;
        case UIGestureRecognizerStateChanged:
            [self.delegate touchesMovedWithSlider:self];
            break;
        case UIGestureRecognizerStateEnded:
            [self.delegate touchesEndedWithSlider:self];
            break;
        case UIGestureRecognizerStateCancelled:
            [self.delegate touchesEndedWithSlider:self];
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
}

- (void)drawRect:(CGRect)rect
{
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.992 green: 0.616 blue: 0 alpha: 1];
    
    //// Oval Drawing
    CGFloat ovalRadius = 6.0f;
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - ovalRadius, rect.size.height / 2.0f - ovalRadius, ovalRadius * 2.0f, ovalRadius * 2.0f)];
    [color setStroke];
    ovalPath.lineWidth = 3;
    [ovalPath stroke];

}


@end
