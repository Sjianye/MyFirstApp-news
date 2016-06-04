//
//  MeTableViewController.m
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MeTableViewController.h"
#import "Masonry.h"
#import "TabBarHeader.h"
#import "CreateVC.h"

@interface MeTableViewController ()

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc] init];
    [headView setBackgroundColor:[UIColor grayColor]];
    headView.frame = CGRectMake(0, 0, 0, 170);
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal
     ];
    [login addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = @"点击登录";
    [headView addSubview:label];
    [headView addSubview:login];
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(login);
        make.top.equalTo(login.mas_bottom);
    }];

    self.tableView.tableHeaderView = headView;
}

//login点击事件
-(void)loginBtnClick:(UIButton *)sender{
    CreateVC * createVC = [[CreateVC alloc] init];
    [self showViewController:createVC sender: nil];
    
    
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}


@end
