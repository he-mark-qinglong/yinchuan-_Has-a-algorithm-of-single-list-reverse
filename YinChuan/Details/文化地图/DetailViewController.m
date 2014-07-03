//
//  DetailViewController.m
//  YinChuan
//
//  Created by jiangjunli on 14-6-24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"
@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation DetailViewController

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0  green:238.0/255.0  blue:212.0/255.0  alpha:1.0];

}
- (IBAction)positionBtnClick:(id)sender {

    MapViewController *mvc = [[MapViewController alloc]initWithLat:@"39.93" Log:@"116.41" Info:@"北京"];
    [self.navigationController pushViewController:mvc animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
