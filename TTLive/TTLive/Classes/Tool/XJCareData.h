//
//  XJCareData.h
//  TTLive
//
//  Created by Dear on 16/9/27.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "XJUserModel.h"

@interface XJCareData : NSObject
SingleH(CareData)

@property (nonatomic, strong, readonly) NSMutableArray *allModels;

/** 保存数据 */
- (void)saveData:(XJUserModel *)userModel;

/** 删除数据 */
- (void)unsaveData:(XJUserModel *)userModel;
@end
