//
//  DownLoadData.h
//  jingjignWeather
//
//  Created by 王亚静 on 16/6/14.
//  Copyright © 2016年 王亚静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadData : NSObject
+ (instancetype)sharedInstance;
+ (NSURLSessionDataTask*)getRealTimeDataWithBlock:(void (^)(NSArray *obj, NSError *error))block andCityID:(NSString*)cityID;
@end
