//
//  WYJDailyView.h
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/5.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYJForecast.h"
@interface WYJDailyView : UIView
@property (nonatomic, strong) WYJForecast *forecast;

+ (instancetype)dailyView;

@end
