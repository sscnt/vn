//
//  EditorViewController.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];
    //////// Bottom Bar
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionBottom];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:buttonClose];
    [self.view addSubview:bar];
    //////// Top Bar
    bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    [self.view addSubview:bar];
}

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
