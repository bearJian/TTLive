//
//  XJLiveModel.h
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJLiveModel : NSObject
/** 直播图 */
@property (nonatomic, copy) NSString *bigpic;
/** 主播头像 */
@property (nonatomic, copy) NSString *smallpic;
/** 直播流地址 */
@property (nonatomic, copy) NSString *flv;
/** 所在城市 */
@property (nonatomic, copy) NSString *gps;
/** 主播名 */
@property (nonatomic, copy) NSString *myname;
/** 个性签名 */
@property (nonatomic, copy) NSString *signatures;
/** 星级 */
@property (nonatomic, assign) NSUInteger starlevel;
/** 观看人数 */
@property (nonatomic, assign) NSUInteger allnum;
/** 这玩意未知 */
@property (nonatomic, assign) NSUInteger lrCurrent;
/** 直播房间号码 */
@property (nonatomic, assign) NSUInteger roomid;
/** 所处服务器 */
@property (nonatomic, assign) NSUInteger serverid;
/** 用户ID */
@property (nonatomic, assign) NSString *useridx;
/** 排名 */
@property (nonatomic, assign) NSUInteger pos;
/** starImage */
@property (nonatomic, strong) UIImage *starImage;

@end
