//
//  WYJForecast.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/5.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYJForecast : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *weekday;
@property (nonatomic, copy) NSString *code_d;
@property (nonatomic, copy) NSString *code_n;
@property (nonatomic, copy) NSString *txt_d;
@property (nonatomic, copy) NSString *txt_n;

/**
 相对湿度
 */
@property (nonatomic, copy) NSString *humidity;

/**
 气压
 */
@property (nonatomic, copy) NSString *pressure;

/**
 降水量
 */
@property (nonatomic, copy) NSString *pcpn;

/**
 降水概率
 */
@property (nonatomic, copy) NSString *pop;

/**
 能见度
 */
@property (nonatomic, copy) NSString *visibility;

/**
 最高温度
 */
@property (nonatomic, copy) NSString *tmp_max;

/**
 最低温度
 */
@property (nonatomic, copy) NSString *tmp_min;

/**
 紫外线指数
 */
@property (nonatomic, copy) NSString *uv;
@end
