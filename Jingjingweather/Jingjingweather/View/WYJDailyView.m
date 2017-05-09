//
//  WYJDailyView.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/5.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJDailyView.h"
@interface WYJDailyView()
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmp_maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmp_minLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cond_d;
@property (weak, nonatomic) IBOutlet UIImageView *cond_n;
@end
@implementation WYJDailyView

+ (instancetype)dailyView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WYJDailyView" owner:nil options:nil] firstObject];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}
- (void)setForecast:(WYJForecast *)forecast {
    if (forecast != _forecast) {
        _forecast = forecast;
        [self refreshUI];
    }
}

- (void)refreshUI {
    
    self.weekdayLabel.text = self.forecast.weekday;
    self.dateLabel.text = self.forecast.date;
    self.cond_d.image = [UIImage imageNamed:self.forecast.code_d];
    self.cond_n.image = [UIImage imageNamed:self.forecast.code_n];
    self.tmp_minLabel.text = [NSString stringWithFormat:@"%@°",self.forecast.tmp_min];
    self.tmp_maxLabel.text = [NSString stringWithFormat:@"%@°",self.forecast.tmp_max];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
