//
//  BookSearchVc.m
//  YinChuan
//
//  Created by mark on 14-6-12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BookSearchVc.h"

@interface BookSearchVc ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BookSearchVc

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
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://222.75.151.206:9000/InDigLib/frontNew/MyLib.action"]];
//    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"书目检索";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
