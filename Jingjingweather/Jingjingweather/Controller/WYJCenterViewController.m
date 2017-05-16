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

@interface WYJCenterViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;
//@property (nonatomic, strong) NSMutableArray *viewControllers;


@end

@implementation WYJCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // pageViewController
    self.view.backgroundColor = [UIColor blueColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self addPageViewController];
    [self setupLeftMenuItem];
}

- (void)addPageViewController {
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
     _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.view.frame = self.view.bounds;
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    WYJCityViewController *controller1 = [self viewControllerAtIndex:0];
    
    [_pageViewController setViewControllers:@[controller1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    __block UIScrollView *scrollView = nil;
    [_pageViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView*)obj;
        }
    }];
//    if (scrollView) {
//        UIPanGestureRecognizer *fakePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fake)];
//        [scrollView addGestureRecognizer:fakePan];
//        [scrollView.panGestureRecognizer requireGestureRecognizerToFail:fakePan];
//    }
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
}

- (void)setupLeftMenuItem {
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftMenuItemPress:)];
//    UIColor *ItemColor = [UIColor colorWithRed:0.49 green:0.29 blue:0.04 alpha:1.0];
    UIColor *itemColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem.tintColor = itemColor;
}


- (void)leftMenuItemPress:(id)sender {
    NSLog(@"showLeft");
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (NSArray *)pageContent {
    if (!_pageContent) {
        _pageContent = @[@"海淀",@"昌平",@"朝阳"];
    }
    return _pageContent;
}

- (WYJCityViewController *)viewControllerAtIndex:(NSUInteger)index {
    WYJCityViewController *contentViewController = [[WYJCityViewController alloc] initWithPageNumber:index cityName:self.pageContent[index]];
    return contentViewController;
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger page = ((WYJCityViewController *)viewController).page;
    if (page == 0 || page == NSNotFound) {
        return nil;
    }
    page--;
    return [self viewControllerAtIndex:page];
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger page = ((WYJCityViewController *)viewController).page;
    if (page == self.pageContent.count-1 || page == NSNotFound) {
        return nil;
    }
    page++;
    return [self viewControllerAtIndex:page];
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return self.pageContent.count;
//}
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 0;
//}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
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
