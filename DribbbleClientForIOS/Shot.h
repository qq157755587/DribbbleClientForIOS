//
//  Shot.h
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/17.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import "Mantle.h"
#import "Images.h"

@interface Shot : MTLModel<MTLJSONSerializing>

@property (nonatomic) NSNumber *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSNumber *width;
@property (nonatomic) NSNumber *height;
@property (nonatomic, strong) Images *images;

@end
