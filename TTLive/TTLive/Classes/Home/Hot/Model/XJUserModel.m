//
//  XJUserModel.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJUserModel.h"

@implementation XJUserModel

// 归档
MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"newStar":@"new"};
}


@end
