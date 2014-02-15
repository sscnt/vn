//
//  EffectsViewController.m
//  Vintage
//
//  Created by SSC on 2014/02/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.imageOriginal = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];
    CGSize size = self.imageOriginal.size;
    
    //// Preview
    CGFloat width = ([UIScreen screenSize].width - 3.0f) / 2.0f;
    CGFloat height = roundf(self.imageOriginal.size.height * width / self.imageOriginal.size.width);
    CGFloat left = 1.0;
    CGFloat top = 1.0;
    CGRect rect;
    for (int i = 0; i < 24; i++) {
        left = (i % 2 == 0) ? 1.0 : left * 2.0 + width;
        rect = CGRectMake(left, top, width, height);
        UISelectionPreviewImageView* preview = [[UISelectionPreviewImageView alloc] initWithFrame:rect];
        [self.view addSubview:preview];
        top += (i % 2 == 0) ? 0.0 : 1.0 + height;
    }

    [super viewDidLoad];
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        
        dispatch_async(q_main, ^{

        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
