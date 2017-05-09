//
//  WYJCityViewController.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/4/27.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJCityViewController.h"
#import "WYJLocationManager.h"
#import "DownLoadData.h"
#import "WYJRealTimeInfo.h"
#import "WYJForecastView.h"
#import "WYJTodayView.h"
#import "WYJDateManager.h"

@interface WYJCityViewController ()
@property (weak, nonatomic) IBOutlet WYJTodayView *todayView;
@property (weak, nonatomic) IBOutlet WYJForecastView *forecastView;
@end

@implementation WYJCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
   
    WYJLocationManager *manager = [WYJLocationManager sharedLocationManager];
    manager.updateLocationHandler = ^(NSError *error, NSDictionary *address) {
        if (!error) {
            NSString *subLocality = address[@"SubLocality"];
            NSString *city = address[@"City"];
            self.navigationItem.title = subLocality;
            NSString *cityID = [subLocality substringToIndex:subLocality.length - 1];
            [DownLoadData getRealTimeDataWithBlock:^(NSArray *obj, NSError *error) {
                self.todayView.realtimeInfo = obj[0];
                self.forecastView.forecasts = obj[1];
            } andCityID:cityID];
        }
    };
    [manager startUpdateLocation];
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
