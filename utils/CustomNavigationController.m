//
//  CustomNavigationController.m
//  PudongTravel
//
//  Created by duwei on 14-4-23.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "CustomNavigationController.h"
#import "AppDelegate.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationItemInit:(UIViewController*)viewController
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,40,175,44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:16];  //设置文本字体与大小
    titleLabel.textColor       = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    viewController.navigationItem.titleView = titleLabel;
}

- (UIBarButtonItem *)navBarItemWithTarget:(id)target
                                   action:(SEL)action
                                imageName:(NSString*)imgName
{
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(10, 4, 42, 40);
    [leftbutton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [leftbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    return letfBarItem;
}

- (void)backBtnPressed:(id)sender
{
    [super popViewControllerAnimated:YES];
}

- (void)dismissLeftBtnPress:(id)sender
{
    [super dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBtnPressed:(id)sender
{
    
}
#pragma mark - presentViewController && pushViewController method
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
                   completion:(void (^)(void))completion
{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    // 添加返回
    UINavigationController *nav = (UINavigationController*)viewControllerToPresent;
    if ([self.viewControllers count] > 1){
        if (nav.topViewController.navigationItem.leftBarButtonItem == nil){
            nav.topViewController.navigationItem.leftBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(dismissLeftBtnPress:)
                             imageName:@"icon_return.png"];
        }
        if (nav.topViewController.navigationItem.rightBarButtonItem == nil)
        {
            nav.topViewController.navigationItem.rightBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(rightBtnPressed:)
                             imageName:@"icon_personal.png"];
        }
        [self navigationItemInit:nav.topViewController];
        [self navigationItemInit:nav.topViewController];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // 添加返回
    if ([self.viewControllers count] > 1){
        if (viewController.navigationItem.leftBarButtonItem == nil){
            viewController.navigationItem.leftBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(backBtnPressed:)
                             imageName:@"fh.jpg"];
        }
        if (viewController.navigationItem.rightBarButtonItem == nil)
        {
            viewController.navigationItem.rightBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(rightBtnPressed:)
                             imageName:@"icon_personal.png"];
        }

        [self navigationItemInit:viewController];
    }
}

@end
