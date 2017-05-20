//
//  WYJCityStore.h
//  MyCity
//
//  Created by 王亚静 on 2017/4/12.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYJCity.h"

@interface WYJCityStore : NSObject
@property (nonatomic, readonly) NSArray *allCities;
+ (instancetype)sharedStore;

- (void)addCity:(WYJCity *) city;
- (void)removeCity:(WYJCity *) city;
- (void)moveCityAtIndex:(NSInteger) fromIndex toIndex:(NSInteger) toIndex;
- (void)updateCityAtIndex:(NSInteger) index withCity:(WYJCity *)city;
- (void)saveHistoryCities;

@end
