//
//  UISaveToButton.m
//  Vintage
//
//  Created by SSC on 2014/03/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISaveToButton.h"

@implementation UISaveToButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.50f] forState:UIControlStateNormal];
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            self.titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
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
    if(selected){
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.95f] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.50f]];
    }else{
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.50f] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
    }
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
