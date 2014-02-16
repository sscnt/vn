//
//  UICloseButton.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UICloseButton.h"

@implementation UICloseButton

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close-60.png"]];
        view.center = CGPointMake(15.0f, 15.0f);
        [self addSubview:view];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
