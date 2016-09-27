//
//  Single.h
//  ARC-MRC环境下实现单例模式
//
//  Created by Dear on 16/4/5.
//  Copyright © 2016年 Dear. All rights reserved.
//

#define SingleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)
// ARC
#define SingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone{\
    \
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
+(instancetype)share##name\
{\
    return [[self alloc] init];\
}\
-(id)copyWithZone:(NSZone *)zone{\
    return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone{\
    \
    return _instance;\
}


#else
// MRC
#define SingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone{\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+(instancetype)share##name\
{\
return [[self alloc] init];\
}\
-(id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone{\
\
return _instance;\
}\
\
-(oneway void)release{\
    \
}\
\
-(instancetype)retain{\
    \
    return _instance;\
}\
\
- (NSUInteger)retainCount{\
    \
    return MAXFLOAT;\
}

#endif

