//
//  VnViewLabel.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewLabel.h"

@implementation VnViewLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor whiteColor];
        self.numberOfLines = 0;
        if([UIDevice isCurrentLanguageJapanese]) {
            self.font = [UIFont fontWithName:@"mplus-1c-bold" size:15.0f];
        } else {
            self.font = [UIFont fontWithName:@"Aller-Bold" size:16.0f];
        }
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
