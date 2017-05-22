//
//  WYJLeftViewController.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/9.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "WYJCenterViewController.h"
#import "WYJSearchViewController.h"
#import "WYJCityStore.h"

@interface WYJLeftViewController ()
@property (nonatomic, copy) NSMutableArray *cityList;
@end

static NSString *kIndentifier = @"reuseIndetifier";
@implementation WYJLeftViewController

- (instancetype)init {
    if (self = [super init]) {
        _cityList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSArray *)cityList {
    NSArray *cityArray = [WYJCityStore sharedStore].allCities;
    return [cityArray copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kIndentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.editButtonItem.title = @"编辑";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity)];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        self.editButtonItem.title = @"完成";
    } else {
        self.editButtonItem.title = @"编辑";
    }
}

- (void)addCity {
    WYJSearchViewController *searchViewController = [[WYJSearchViewController alloc] init];
    [self presentViewController:searchViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WYJCenterViewController *)getCenterViewController {
    UINavigationController *nav = (UINavigationController *)self.mm_drawerController.centerViewController;
    return (WYJCenterViewController*)nav.viewControllers[0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIndentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    WYJCity *city = self.cityList[indexPath.row];
    cell.textLabel.text = city.cityZh;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
        WYJCenterViewController *centerController = [self getCenterViewController];
        [centerController gotoPage:indexPath.row];
    }];
}

#pragma mark - swipe to delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [NSString stringWithFormat:@"删除"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // 删除数据
        WYJCity *city = [WYJCityStore sharedStore].allCities[indexPath.row];
        [[WYJCityStore sharedStore] removeCity:city];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // 删除对应控制器
        WYJCenterViewController *centerController = [self getCenterViewController];
        NSInteger deletePage = indexPath.row;
        [centerController removeViewControllerAtIndex:deletePage];
        [centerController refreshScrollView];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[WYJCityStore sharedStore] moveCityAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
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
