//
//  UIResolutionSelectButton.m
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIResolutionSelectButton.h"

@implementation UIResolutionSelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selected = NO;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.40f] forState:UIControlStateNormal];
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            self.titleLabel.font = [UIFont fontWithName:@"mplus-1c-bold" size:18.0f];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 40.0f, 0, 0)];
        } else {
            self.titleLabel.font = [UIFont fontWithName:@"Aller-Bold" size:20.0f];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(2.0f, 40.0f, 0, 0)];
        }

    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(selected){
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.85f] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.50f]];
    }else{
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.40f] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithWhite:1.0f alpha:0.40f];
    if(_selected){
        color = [UIColor colorWithWhite:1.0f alpha:0.85f];
    }
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(13.0f, rect.size.height / 2.0f - 8.0f, 16.0f, 16.0f)];
    [color setStroke];
    ovalPath.lineWidth = 2;
    [ovalPath stroke];
    
    if(_selected){
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(16.0f, rect.size.height / 2.0f - 5.0f, 10.0f, 10.0f)];
        [color setFill];
        [ovalPath fill];
        
    }
}


@end
