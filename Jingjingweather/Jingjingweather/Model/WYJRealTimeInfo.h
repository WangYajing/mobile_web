//
//  WYJRealTimeInfo.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/4/28.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYJRealTimeInfo : NSObject
@property (nonatomic, copy) NSString *condition;
@property (nonatomic, copy) NSString *condCode;
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, copy) NSString *feeling;
@property (nonatomic, copy) NSString *pressure;
@property (nonatomic, copy) NSString *precipitation;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *visibility;
@property (nonatomic, copy) NSString *aqi;
@property (nonatomic, copy) NSString *aqiQuality;
@end
