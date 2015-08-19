//
//  ShotsListTableViewController.m
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/15.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import "ShotsListTableViewController.h"
#import "AFDribbbleAPIClient.h"
#import "Mantle.h"
#import "Shot.h"
#import "ShotTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShotsListTableViewController ()

@property (nonatomic) CGFloat rowHeight;

@end

static NSString *const CELL_IDENTITY =@"ShotIdentity";
static NSString *const NIB_NAME = @"ShotTableViewCell";

@implementation ShotsListTableViewController

NSMutableArray* shots;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowHeight = [self heightForRow];
    shots = [[NSMutableArray alloc] init];
    [self loadShotsFromNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shots.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY forIndexPath:indexPath];
    
    Shot *shot = shots[indexPath.row];
    [cell.title setText:shot.title];
    [cell.image sd_setImageWithURL:shot.images.teaser];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (CGFloat)heightForRow {
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width;
    CGFloat imageHeight = (width - 16) * 3 / 4;
    return imageHeight + 8 * 3 + 28;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"ShotsListToDetail" sender:self];
}

#pragma mark - Restful operation

- (void)loadShotsFromNetwork {
    [[AFDribbbleAPIClient sharedClient] GET:@"shots" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *jsonArray = (NSArray *) responseObject;
        NSError *error = nil;
        NSArray *shotsArray = [MTLJSONAdapter modelsOfClass:Shot.class fromJSONArray:jsonArray error:&error];
        if (error == nil) {
            [shots addObjectsFromArray:shotsArray];
            [self.tableView reloadData];
        } else {
            NSLog(@"ERROR %@", error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ERROR %@", error);
    }];
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
