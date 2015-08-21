//
//  ShotDetailViewController.m
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/19.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import "ShotDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShotDetailViewController ()

@end

@implementation ShotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:self.shot.title];
    [self.content setText:self.shot.content];
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.shot.images.normal]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
