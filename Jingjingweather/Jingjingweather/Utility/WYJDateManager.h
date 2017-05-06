//
//  WYJDateManager.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/6.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYJDateManager : NSObject

/**
 获取当前是周几

 @return 返回周几
 */
+ (NSString *)weekday;

/**
 获取年月日

 @param format 需要的日期格式
 @return 年月日
 */
+ (NSString *)dateWithFormat:(NSString *)format;

/**
 转换日期格式

 @param toFormat toFormat
 @param fromFormat fromFormat description
 @param dateString 日期字符串
 @return 转换格式后的日期
 */
+ (NSString *)transformDateToFomat:(NSString *)toFormat formFormat:(NSString *)fromFormat DateString:(NSString *)dateString;
@end
