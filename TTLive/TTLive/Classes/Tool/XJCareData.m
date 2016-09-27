//
//  XJCareData.m
//  TTLive
//
//  Created by Dear on 16/9/27.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJCareData.h"

#define XJData [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"allModel.pist"]

@interface XJCareData(){
    
    NSMutableArray *_allModels;
}
@end

@implementation XJCareData

SingleM(CareData)

- (NSMutableArray *)allModels
{
    if (_allModels == nil){
        // 读取
        _allModels = [NSKeyedUnarchiver unarchiveObjectWithFile:XJData];
        
        if (_allModels == nil){
            
            _allModels = [NSMutableArray array];
        }
        
    }
    return _allModels;
}

/** 保存数据 */
- (void)saveData:(XJUserModel *)userModel{
    
    [self.allModels removeObject:userModel];
    
    [self.allModels insertObject:userModel atIndex:0];
    // 写入
    [NSKeyedArchiver archiveRootObject:self.allModels toFile:XJData];
}

/** 删除数据 */
- (void)unsaveData:(XJUserModel *)userModel{
    // enumerateObjectsUsingBlock: 遍历字典,Value获取index,速度更快
    [[XJCareData shareCareData].allModels enumerateObjectsUsingBlock:^(XJUserModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([userModel.flv isEqualToString:obj.flv]){
            
            [self.allModels removeObject:obj];
        }
    }];
    // 写入
    [NSKeyedArchiver archiveRootObject:self.allModels toFile:XJData];
}
@end
