//
//  WYJLocationManager.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/4/27.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYJLocationManager : NSObject
@property (nonatomic, copy) void (^updateLocationHandler)(NSError *error, NSDictionary* address);

+ (instancetype)sharedLocationManager;
- (void)startUpdateLocation;
@end
