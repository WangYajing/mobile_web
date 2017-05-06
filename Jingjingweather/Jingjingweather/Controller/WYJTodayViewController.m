//
//  WYJTodayViewController.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/4/27.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJTodayViewController.h"
#import "WYJLocationManager.h"
#import "DownLoadData.h"
#import "WYJRealTimeInfo.h"
#import "WYJAqiLabel.h"
#import "WYJForecastView.h"
#import "WYJDateManager.h"

@interface WYJTodayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionImageView;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet WYJAqiLabel *aqiLabel;
@property (weak, nonatomic) IBOutlet WYJForecastView *forecastView;

@end

@implementation WYJTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    NSString *weekday = [WYJDateManager weekday];
    NSString *dateString = [WYJDateManager dateWithFormat:@"M.d"];
    self.dataLabel.text = [NSString stringWithFormat:@"%@·%@",dateString,weekday];
    self.dataLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    self.conditionLabel.font = [UIFont fontWithName:@"STXinwei" size:40];
    self.temperatureLabel.font = [UIFont fontWithName:@"Verdana" size:26];
    self.aqiLabel.layer.cornerRadius = 5;
    self.aqiLabel.clipsToBounds = YES;

    WYJLocationManager *manager = [WYJLocationManager sharedLocationManager];
    manager.updateLocationHandler = ^(NSError *error, NSDictionary *address) {
        if (!error) {
            NSString *cityName = address[@"SubLocality"];
            self.navigationItem.title = cityName;
            NSString *city = [cityName substringToIndex:cityName.length - 1];
            [DownLoadData getRealTimeDataWithBlock:^(NSArray *obj, NSError *error) {
                WYJRealTimeInfo *realTime = obj[0];
                self.forecastView.forecasts = obj[1];
                [self refreshUIWithRealTimeInfo:realTime];
            } andCityID:city];
        }
    };
    [manager startUpdateLocation];
}

- (void)refreshUIWithRealTimeInfo:(WYJRealTimeInfo *)realTime {
    
    NSString *condCode = realTime.condCode;
    self.conditionImageView.image = [UIImage imageNamed:condCode];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@ ℃",realTime.temperature];
    self.conditionLabel.text = realTime.condition;
    [self.aqiLabel setColorAndTextWithAQI:realTime.aqi quality:realTime.aqiQuality];
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
