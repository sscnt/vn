//
//  UIFadeNavigationController.m
//  Gravy_1.0
//
//  Created by SSC on 2013/10/17.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFadeNavigationController.h"

@interface UIFadeNavigationController ()

@end

@implementation UIFadeNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated) {
        [UIView transitionWithView:self.view duration:0.6f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [super pushViewController:viewController animated:NO];
        } completion:nil];
    } else {
        [super pushViewController:viewController animated:NO];
    }
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block NSArray *viewControllers = nil;
    
    if (animated) {
        [self popWithTransitionAnimations:^{
            viewControllers = [super popToViewController:viewController animated:NO];
        }];
    } else {
        viewControllers = [super popToViewController:viewController animated:NO];
    }
    
    return viewControllers;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    __block UIViewController *popedViewController = nil;
    
    if (animated) {
        [self popWithTransitionAnimations:^{
            popedViewController = [super popViewControllerAnimated:NO];
        }];
    } else {
        popedViewController = [super popViewControllerAnimated:NO];
    }
    
    return popedViewController;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    __block NSArray *viewControllers = nil;
    
    if (animated) {
        [self popWithTransitionAnimations:^{
            viewControllers = [super popToRootViewControllerAnimated:NO];
        }];
    } else {
        viewControllers = [super popToRootViewControllerAnimated:NO];
    }
    
    return viewControllers;
}

- (void)popWithTransitionAnimations:(void (^)(void))animations
{
    [UIView transitionWithView:self.view
                      duration:0.6f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animations
                    completion:nil];
}

@end
