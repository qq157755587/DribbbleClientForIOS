//
//  Shot.m
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/17.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import "Shot.h"

@implementation Shot

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"shotId": @"id",
        @"title": @"title",
        @"content": @"description",
        @"width": @"width",
        @"images": @"images"
    };
}

+ (NSValueTransformer *)imagesJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Images.class];
}

@end
