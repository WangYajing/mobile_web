//
//  WYJSearchViewController.m
//  Jingjingweather
//
//  Created by 王亚静 on 2017/5/18.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "WYJSearchViewController.h"
#import "WYJCity.h"
#import "WYJCityStore.h"

@interface WYJSearchViewController ()<UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, copy) NSArray *cityList;
@property (nonatomic, copy) NSArray *filterdCityList;
@end

@implementation WYJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self readCityList];
    [self initSearchController];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)initSearchController {
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"输入城市名称";
    [_searchController.searchBar setShowsCancelButton:YES animated:YES];
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 64.0);
    self.tableView.tableHeaderView = _searchController.searchBar;
}

- (void)readCityList {
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"china-city-list" ofType:@"json"];
    NSData *date = [NSData dataWithContentsOfFile:fileName];
    if (date) {
        NSError *serializationError = nil;
        _cityList = [NSJSONSerialization JSONObjectWithData:date options:0 error:&serializationError];
    }
}

#pragma mark - UIViewController life cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromSelector(_cmd));
    self.searchController.active = YES;
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self.searchController.searchBar becomeFirstResponder];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cityDict = self.filterdCityList[indexPath.row];
    WYJCity *city = [[WYJCity alloc] initWithCityDic:cityDict];
    [[WYJCityStore sharedStore] addCity:city];
    self.searchController.active = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    if (searchString.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@",searchString];
        NSArray *filterdArray = [self.cityList filteredArrayUsingPredicate:predicate];
        if (filterdArray.count > 0) {
            self.filterdCityList = [filterdArray copy];
        } else {
            self.filterdCityList = @[@"未能找到结果"];
        }
        
    } else {
        self.filterdCityList = nil;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterdCityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (self.filterdCityList.count > 0) {
        
        if ([self.filterdCityList[0] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *cityDic = self.filterdCityList[indexPath.row];
            WYJCity *city = [[WYJCity alloc] initWithCityDic:cityDic];
            cell.textLabel.text = [NSString stringWithFormat:@"%@,%@,%@",city.cityZh,city.leaderZh,city.provinceZh];
        } else {
            cell.textLabel.text = self.filterdCityList[0];
        }
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
