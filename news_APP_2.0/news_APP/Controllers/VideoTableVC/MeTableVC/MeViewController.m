//
//  MeViewController.m
//  news_APP
//
//  Created by qingyun on 16/6/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()
@property (nonatomic ) BOOL isON;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lampBtnAction:(UIButton *)sender {

    if (_isON) {
        self.tabBarController.view.alpha =  1;
    }else{
        self.tabBarController.view.alpha =  0.5;
    }
    _isON = !_isON;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
