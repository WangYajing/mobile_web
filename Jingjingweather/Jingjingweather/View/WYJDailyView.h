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
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (nonatomic, strong) WYJForecast *forecast;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmp_maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmp_minLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cond_d;
@property (weak, nonatomic) IBOutlet UIImageView *cond_n;
+ (instancetype)dailyView;

@end
