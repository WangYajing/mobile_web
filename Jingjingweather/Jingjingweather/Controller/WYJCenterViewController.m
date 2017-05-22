//
//  WYJCenterViewController.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/9.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJCenterViewController.h"
#import "WYJCityViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "PageScrollView.h"
#import "WYJCity.h"
#import "WYJCityStore.h"

@interface WYJCenterViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *privateviewControllers;

@end

@implementation WYJCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setupScrollView];
    [self setupLeftMenuItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshScrollView];
}

- (void)refreshScrollView {
    // 添加城市后 重新计算contentSize
    _scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*[WYJCityStore sharedStore].allCities.count, self.view.bounds.size.height);
    for (NSUInteger i = _privateviewControllers.count; i < [WYJCityStore sharedStore].allCities.count; i ++) {
        [_privateviewControllers addObject:[NSNull null]];
    }
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)setupScrollView {
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [WYJCityStore sharedStore].allCities.count; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    self.privateviewControllers = controllers;
    
    _scrollView = [[PageScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*[WYJCityStore sharedStore].allCities.count, self.view.bounds.size.height);
    [self.view addSubview:_scrollView];
    
}

- (void)loadScrollViewWithPage:(NSUInteger)page {
    
    if (page < [WYJCityStore sharedStore].allCities.count){
        
        WYJCityViewController *controller = [_privateviewControllers objectAtIndex:page];
        if ((NSNull *)controller == [NSNull null]) {
            WYJCity *city = [WYJCityStore sharedStore].allCities[page];
            NSString *cityName = city.cityZh;
            controller = [[WYJCityViewController alloc] initWithPageNumber:page cityName:cityName];
            [_privateviewControllers replaceObjectAtIndex:page withObject:controller];
        }
        
        // add the controller's view to the scroll view
       
        if (controller.view.superview == nil) {
            CGRect frame = self.scrollView.frame;
            frame.origin.x = CGRectGetWidth(frame) * page;
            frame.origin.y = 0;
            controller.view.frame = frame;
            
            [self addChildViewController:controller];
            [self.scrollView addSubview:controller.view];
            [controller didMoveToParentViewController:self];
            
        } else if (controller.view.frame.origin.x != self.scrollView.frame.size.width * page) {
            CGRect frame = self.scrollView.frame;
            frame.origin.x = CGRectGetWidth(frame) * page;
            frame.origin.y = 0;
            controller.view.frame = frame;
            if (page == 0) {
                self.navigationItem.title = ((WYJCityViewController *)controller).cityName;
            }
        }
    }
}

- (void)addViewController {
    [_privateviewControllers addObject:[NSNull null]];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index {
    WYJCityViewController *controller = [_privateviewControllers objectAtIndex:index];
    // 从父视图中移除
    [controller.view removeFromSuperview];
    // 从父控制器中移除
    [controller willMoveToParentViewController:self];
    [controller removeFromParentViewController];
    // 从数组中移除
    [_privateviewControllers removeObjectAtIndex:index];
}

- (WYJCityViewController *)viewControllerAtIndex:(NSUInteger)index {
    WYJCity *city = [WYJCityStore sharedStore].allCities[index];
    NSString *cityName = city.cityZh;
    WYJCityViewController *contentViewController = [[WYJCityViewController alloc] initWithPageNumber:index cityName:cityName];
    return contentViewController;
}

- (void)gotoPage:(NSUInteger)page {
    WYJCity *city = [WYJCityStore sharedStore].allCities[page];
    self.navigationItem.title = city.cityZh;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width*page, 0);
}

- (void)setupLeftMenuItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu1"] style:UIBarButtonItemStylePlain target:self action:@selector(leftMenuItemPress:)];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftMenuItemPress:)];
//    UIColor *ItemColor = [UIColor colorWithRed:0.49 green:0.29 blue:0.04 alpha:1.0];
    UIColor *itemColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem.tintColor = itemColor;
}


- (void)leftMenuItemPress:(id)sender {
    NSLog(@"showLeft");
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // 设置导航栏标题
    WYJCity *city = [WYJCityStore sharedStore].allCities[page];
    self.navigationItem.title = city.cityZh;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
}

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
