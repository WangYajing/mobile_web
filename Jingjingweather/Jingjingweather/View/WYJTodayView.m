//
//  WYJTodayView.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/9.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJTodayView.h"
#import "WYJAqiLabel.h"
#import "WYJDateManager.h"
#import "WYJRealTimeInfo.h"
@interface WYJTodayView()
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionImageView;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet WYJAqiLabel *aqiLabel;
@end

@implementation WYJTodayView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //        _dailyViewArray = [NSMutableArray arrayWithCapacity:0];
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInnit];
}

- (void)commonInnit {
    NSString *weekday = [WYJDateManager weekday];
    NSString *dateString = [WYJDateManager dateWithFormat:@"M.d"];
    self.dataLabel.text = [NSString stringWithFormat:@"%@·%@",dateString,weekday];
    self.dataLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    self.conditionLabel.font = [UIFont fontWithName:@"STXinwei" size:40];
    self.temperatureLabel.font = [UIFont fontWithName:@"Verdana" size:26];
    self.aqiLabel.layer.cornerRadius = 5;
    self.aqiLabel.clipsToBounds = YES;
    self.windLabel.font = [UIFont fontWithName:@"Verdana" size:16];

}

- (void)setRealtimeInfo:(WYJRealTimeInfo *)realtimeInfo {
    if (realtimeInfo != _realtimeInfo) {
        _realtimeInfo = realtimeInfo;
        [self refreshUI];
    }
}
- (void)refreshUI{
    NSString *condCode = _realtimeInfo.condCode;
    self.conditionImageView.image = [UIImage imageNamed:condCode];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@ ℃",_realtimeInfo.temperature];
    self.windLabel.text = [NSString stringWithFormat:@"%@ %@级",_realtimeInfo.windDirection, _realtimeInfo.windScale];
    self.conditionLabel.text = _realtimeInfo.condition;
    [self.aqiLabel setColorAndTextWithAQI:_realtimeInfo.aqi quality:_realtimeInfo.aqiQuality];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
