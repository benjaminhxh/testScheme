//
//  SelectViewController.m
//  TestScheme
//
//  Created by xiaohuihu on 14-9-23.
//  Copyright (c) 2014年 hxh. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *imageV;

}
@end

@implementation SelectViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(20, 20, 60, 40);
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UITableView *_tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 400) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 30, 30)];
    imageV.image = [UIImage imageNamed:@"boy@2x"];
}

- (void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellIdent = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"customerCell" owner:self options:nil] lastObject];
        
//        imageV.tag = 100;
//        [cell addSubview:imageV];
    }
//    cell.textLabel.text = @"hello";
//    cell.detailTextLabel.text = @"公开分享";
//    [cell addSubview:imageV];

    if (indexPath.row == self.index) {
//        imageV.hidden = NO;
        self.imageView.hidden = NO;
    }else
    {
//        imageV.hidden = YES;
        self.imageView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = (UITableViewCell *)tableView.superview;
//    [cell addSubview:imageV];
//    [self dismissViewControllerAnimated:YES completion:nil];
    self.index = indexPath.row;
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
