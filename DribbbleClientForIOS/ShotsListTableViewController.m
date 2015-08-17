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
#import <Foundation/Foundation.h>

static NSString *const BASE_URL = @"https://api.dribbble.com/v1/";
static NSString *const TOKEN = @"Bearer 8aac5e2678da4b5dda86f5c558d6b7e368d138ba5df7fe8e3c351bb640e68721";

@interface ShotsListTableViewController ()

@end

@implementation ShotsListTableViewController

NSMutableArray* shots;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShotIdentity" forIndexPath:indexPath];
    
    Shot *shot = shots[indexPath.row];
    [cell.textLabel setText:shot.title];
    
    return cell;
}

#pragma mark - Restful operation

- (void) loadShotsFromNetwork {
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
