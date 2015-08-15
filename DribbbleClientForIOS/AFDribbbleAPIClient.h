//
//  AFDribbbleAPIClient.h
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/15.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHttpSessionManager.h"

@interface AFDribbbleAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
