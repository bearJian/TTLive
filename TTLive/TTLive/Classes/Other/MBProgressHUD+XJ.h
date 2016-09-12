//
//  MBProgressHUD+XJ.h
//  
//
//  Created by Dear on 16/9/6.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XJ)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+(void)showText:(NSString *)text;

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;
@end
