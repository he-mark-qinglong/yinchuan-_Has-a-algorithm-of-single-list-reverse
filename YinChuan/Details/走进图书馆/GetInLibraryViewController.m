//
//  GetInLibraryViewController.m
//  YinChuan
//
//  Created by mark on 14-6-12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "GetInLibraryViewController.h"
#import "ListTest.h"

@interface GetInLibraryViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GetInLibraryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ListTest *list = [[ListTest alloc] init];
    [list run];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://222.75.151.206:9000/InDigLib/front/SearchIndex.action"]];
    //    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"走进图书馆";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
