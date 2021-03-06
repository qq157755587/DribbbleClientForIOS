//
//  ShotDetailViewController.h
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/19.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shot.h"

@interface ShotDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (nonatomic, strong) Shot *shot;

@end
