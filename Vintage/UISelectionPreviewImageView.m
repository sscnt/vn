//
//  UISelectionPreviewImageView.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISelectionPreviewImageView.h"

@implementation UISelectionPreviewImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:33.0f/255.0f alpha:1.0f]];
        
        self.imageViewLoading = [[UIImageView alloc] initWithImage:[UIImage animatedGIFNamed:@"loading-48"]];
        self.imageViewLoading.center = CGPointMake(roundf(frame.size.width / 2.0), roundf(frame.size.height / 2.0));
        [self addSubview:self.imageViewLoading];
    }
    return self;
}

- (void)removeLoadingIndicator
{
    [self.imageViewLoading removeFromSuperview];
    self.imageViewLoading = nil;
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
