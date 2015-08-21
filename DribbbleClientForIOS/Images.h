//
//  Images.h
//  DribbbleClientForIOS
//
//  Created by 赵 元杰 on 15/8/17.
//  Copyright (c) 2015年 赵 元杰. All rights reserved.
//

#import "Mantle.h"

@interface Images : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *hidpi;
@property (nonatomic, copy) NSString *normal;
@property (nonatomic, copy) NSString *teaser;

@end
