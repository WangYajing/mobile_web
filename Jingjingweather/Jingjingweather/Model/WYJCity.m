//
//  WYJCity.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/19.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJCity.h"

@implementation WYJCity

#pragma mark - NSKeyValueCoding

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

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_cityEn forKey:@"cityEn"];
    [aCoder encodeObject:_cityZh forKey:@"cityZh"];
    [aCoder encodeObject:_leaderEn forKey:@"leaderEn"];
    [aCoder encodeObject:_leaderZh forKey:@"leaderZh"];
    [aCoder encodeObject:_provinceEn forKey:@"provinceEn"];
    [aCoder encodeObject:_provinceZh forKey:@"provinceZh"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _cityEn = [aDecoder decodeObjectForKey:@"cityEn"];
        _cityZh = [aDecoder decodeObjectForKey:@"cityZh"];
        _leaderEn = [aDecoder decodeObjectForKey:@"LeaderEn"];
        _leaderZh = [aDecoder decodeObjectForKey:@"LeaderZh"];
        _provinceEn = [aDecoder decodeObjectForKey:@"provinceEn"];
        _provinceZh = [aDecoder decodeObjectForKey:@"provinceZh"];
    }
    return self;
}

@end
