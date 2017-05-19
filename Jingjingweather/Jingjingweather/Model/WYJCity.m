//
//  WYJCity.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/19.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJCity.h"

@implementation WYJCity
- (instancetype)initWithCityDic:(NSDictionary *)cityDic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:cityDic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}
@end
