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
    [cell.image sd_setImageWithURL:shot.images.normal];
    
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
    [self performSegueWithIdentifier:@"ShotsListToDetail" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController respondsToSelector:NSSelectorFromString(@"setShot:")]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Shot *shot = shots[indexPath.row];
        [segue.destinationViewController setValue:shot forKey:@"shot"];
    }
}

@end
