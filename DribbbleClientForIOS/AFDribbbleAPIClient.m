//
//  AFDribbbleAPIClient.m
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/15.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import "AFDribbbleAPIClient.h"

static NSString *const BASE_URL = @"https://api.dribbble.com/v1/";
static NSString *const TOKEN = @"Bearer 8aac5e2678da4b5dda86f5c558d6b7e368d138ba5df7fe8e3c351bb640e68721";

@implementation AFDribbbleAPIClient

+ (instancetype)sharedClient {
    static AFDribbbleAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPAdditionalHeaders = @{@"Authorization": TOKEN};
        _sharedClient = [[AFDribbbleAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL] sessionConfiguration:config];
    });
    return _sharedClient;
}

@end
