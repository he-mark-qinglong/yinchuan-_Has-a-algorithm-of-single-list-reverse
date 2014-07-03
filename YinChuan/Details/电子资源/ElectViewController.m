//
//  ElectViewController.m
//  YinChuan
//
//  Created by mark on 14-6-12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "ElectViewController.h"
#import "ElectTableViewCell.h"

@interface ElectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ElectViewController

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
    self.table.dataSource = self;
    self.table.delegate   = self;
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.table.backgroundColor = [UIColor clearColor] ;
  
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"电子资源";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 10;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ElectTableViewCell";
    //自定义cell类
    ElectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ElectTableViewCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
     row = row;  //去除警告用的
    cell.backgroundColor = [UIColor clearColor];
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
    
}
@end
