//
//  WXBackTestViewController.m
//  TestScheme
//
//  Created by zhxf on 14-6-26.
//  Copyright (c) 2014年 hxh. All rights reserved.
//

#import "WXBackTestViewController.h"

@interface WXBackTestViewController ()

@end

@implementation WXBackTestViewController

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
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    backBtn.frame = CGRectMake(20, 80, 60, 30);
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

- (void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
