//
//  WYJCity.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/19.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYJCity : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cityZh;
@property (nonatomic, copy) NSString *cityEn;
@property (nonatomic, copy) NSString *leaderZh;
@property (nonatomic, copy) NSString *leaderEn;
@property (nonatomic, copy) NSString *provinceZh;
@property (nonatomic, copy) NSString *provinceEn;

- (instancetype)initWithCityDic:(NSDictionary *)cityDic;
@end
