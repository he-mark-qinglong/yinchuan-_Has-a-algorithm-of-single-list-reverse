//
//  RootViewController.m
//  YinChuan
//
//  Created by mark on 14-6-11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "RootViewController.h"

#import "ElectViewController.h"
#import "MapViewController.h"
#import "GetInLibraryViewController.h"
#import "BookSearchVc.h"
#import "CultureMapViewController.h"

#import "UIView+FitVersions.h"
@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIButton *libraryBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookSearchBtn;
@property (weak, nonatomic) IBOutlet UIButton *electronicBtn;
@property (weak, nonatomic) IBOutlet UIButton *mapCultureBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property UIViewController *electVc;
@property UIViewController *mapVc;
@property UIViewController *bookSearchVc;
@property UIViewController *libraryVc;
@property UIViewController *cultureVc;
@end

@implementation RootViewController

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
    
    self.scrollView.scrollEnabled                  = YES;
    self.scrollView.userInteractionEnabled         = YES;  //设置是否显示水平滑动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;    //设置是否显示垂直滑动条
    
    if (!IS_IPHONE5) {
        self.scrollView.contentSize = CGSizeMake(0, 660);
    }
    
    self.electVc      = [[ElectViewController alloc] init];
    self.cultureVc    = [[CultureMapViewController alloc] init];
    self.bookSearchVc = [[BookSearchVc alloc] init];
    self.libraryVc    = [[GetInLibraryViewController alloc] init];
    
    NSDictionary *btn2NavVc = @{@"electronic":@[self.electronicBtn, self.electVc],
                                @"library":   @[self.libraryBtn, self.libraryVc],
                                @"bookSearch":@[self.bookSearchBtn, self.bookSearchVc],
                                @"mapCulture":@[self.mapCultureBtn, self.cultureVc]};
    @weakify(self);
    for(NSArray *a in btn2NavVc.allValues){
        UIButton *btn        = a[0];
        UIViewController *vc = a[1];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x){
             @strongify(self);
             [self.navigationController pushViewController:vc animated:NO];
         }];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
