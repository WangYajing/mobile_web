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
@interface WYJCenterViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewControllers;


@end

@implementation WYJCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setupScrollView];
    [self setupLeftMenuItem];
}

- (void)setupScrollView {
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < self.pageContent.count; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    _scrollView = [[PageScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*self.pageContent.count, self.view.bounds.size.height);
    [self.view addSubview:_scrollView];
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= self.pageContent.count)
        return;
    
    WYJCityViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[WYJCityViewController alloc] initWithPageNumber:page cityName:self.pageContent[page]];
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];

    }
}

- (WYJCityViewController *)viewControllerAtIndex:(NSUInteger)index {
    WYJCityViewController *contentViewController = [[WYJCityViewController alloc] initWithPageNumber:index cityName:self.pageContent[index]];
    return contentViewController;
}

- (void)gotoPage:(NSUInteger)page {
    
    self.navigationItem.title = self.pageContent[page];
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
    self.navigationItem.title = self.pageContent[0];
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // 设置导航栏标题
    self.navigationItem.title = self.pageContent[page];
    
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
