//
//  SaveViewController.m
//  Vintage
//
//  Created by SSC on 2014/03/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "SaveViewController.h"

@implementation SaveViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:buttonClose];
    [bar setTitle:NSLocalizedString(@"SAVE", nil)];
    [self.view addSubview:bar];

}

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
