//
//  WYJAqiLabel.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/4.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJAqiLabel.h"

@implementation WYJAqiLabel

- (void)setColorAndTextWithAQI:(NSString *)aqi quality:(NSString *)quality {
    
    self.text = [NSString stringWithFormat:@"%@ %@", aqi, quality];
    int aqiValue = [aqi intValue];
    if (aqiValue > 0 && aqiValue <= 50 ) {
        self.backgroundColor = [UIColor colorWithRed:0.27 green:0.75 blue:0.44 alpha:1.0];
    } else if (aqiValue > 50 && aqiValue <= 100) {
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.76 blue:0.19 alpha:1.00];
    } else if (aqiValue > 100 && aqiValue <= 150) {
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.60 blue:0.15 alpha:1.0];
    } else if (aqiValue > 150 && aqiValue <= 200) {
        self.backgroundColor = [UIColor colorWithRed:0.87 green:0.42 blue:0.35 alpha:1.0];
    } else if (aqiValue > 200 && aqiValue <= 300 ) {
        self.backgroundColor = [UIColor colorWithRed:0.48 green:0.42 blue:0.80 alpha:1.00];
    } else if (aqiValue > 300) {
        self.backgroundColor = [UIColor colorWithRed:0.61 green:0.31 blue:0.48 alpha:1.00];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
