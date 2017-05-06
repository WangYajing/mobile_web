//
//  WYJForecastView.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/5.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJForecastView.h"
#import "WYJDailyView.h"

@implementation WYJForecastView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"=============");
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        _dailyViewArray = [NSMutableArray arrayWithCapacity:0];
        NSLog(@"%@",NSStringFromSelector(_cmd));
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat width = self.bounds.size.width/3;
    CGFloat height = self.bounds.size.height;
    for (int i = 0; i < 3; i++) {
        WYJDailyView *dailyView = [WYJDailyView dailyView];
        dailyView.frame = CGRectMake(i*width, 0, width, height);
//        [_dailyViewArray addObject:dailyView];
        [self addSubview:dailyView];
    }
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)setForecasts:(NSArray *)forecasts {
    if (_forecasts != forecasts) {
        _forecasts = [forecasts copy];
        [self refreshUI];
    }
}
- (void)refreshUI {
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof WYJDailyView * _Nonnull dailyView, NSUInteger idx, BOOL * _Nonnull stop) {
        dailyView.forecast = self.forecasts[idx];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
