//
//  CultureMapViewController.m
//  YinChuan
//
//  Created by jiangjunli on 14-6-24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "CultureMapViewController.h"
#import "CultureCell.h"
#import "DetailViewController.h"
@interface CultureMapViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *contentTabelView;

@end

@implementation CultureMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"文化地图";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.contentTabelView.dataSource = self;
    self.contentTabelView.delegate = self;
    [self.contentTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.contentTabelView.backgroundColor = [UIColor clearColor] ;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 10;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CultureCell";
    //自定义cell类
    CultureCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CultureCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    row = row;  //去除警告用的
    cell.backgroundColor = [UIColor clearColor];
//    UIColor * color =[[UIColor alloc]initWithRed:234.0 green:184.0 blue:85.0 alpha:1.0];
   
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:234.0/255.0  green:184.0/255.0  blue:85.0/255.0  alpha:1.0];
    return cell;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * dvc = [[DetailViewController alloc]init];
     [self.navigationController pushViewController: dvc animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
