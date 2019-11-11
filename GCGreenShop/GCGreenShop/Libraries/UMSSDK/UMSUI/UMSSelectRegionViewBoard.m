//
//  UMSSelectRegionViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSSelectRegionViewBoard.h"
#import "INTULocationManager.h"
#import "UMSRegionConstant.h"

@interface UMSSelectRegionViewBoard () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionsArray;
@property (nonatomic, strong) NSMutableArray *keywords;
@property (nonatomic, strong) UMSRegionConstant *currentRegion;
@end

@implementation UMSSelectRegionViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initTableView];
    [self _loadDatas];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performBlock:^{
        [self _locate];
    } afterDelay:0.5];
}


#pragma mark - UI Helpers

- (void)_initTableView {
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
}

- (void)_locate {
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:10 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            [self reverseGeocodeLocation:currentLocation completion:^(BOOL success, UMSRegionConstant *region) {
                self.currentRegion = region;
                if (self.tableView.numberOfSections > 0 && [self.tableView numberOfRowsInSection:0] > 0) {
                    [self.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
        else {
            self.currentRegion = [self _matchRegion:@"金坛" state:@"江苏"];
            if (self.tableView.numberOfSections > 0 && [self.tableView numberOfRowsInSection:0] > 0) {
                [self.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    }];
}

- (void)_loadDatas {
    [self performBlock:^{
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"UMSSDK" ofType:@"bundle"];
        NSString *path = [bundle stringByAppendingPathComponent:@"region.plist"];
        NSArray *regionArray = [NSArray arrayWithContentsOfFile:path];
        [self _reloadAllCitiesInOrder:regionArray];
    } afterDelay:0.2];
}

- (void)_reloadAllCitiesInOrder:(NSArray *)regionArray {
    
    NSMutableArray *sortedArr = [NSMutableArray arrayWithCapacity:0];
    
    // 1、先添加所有城市
    for (NSDictionary *regionInfo in regionArray) {
        for (NSDictionary *cityInfo in regionInfo[@"citys"]) {
            UMSRegionConstant *region = [UMSRegionConstant new];
            region.provinceId = [cityInfo[@"id"] intValue];
            region.provinceName = cityInfo[@"name"];
            region.cityId = [cityInfo[@"id"] intValue];
            region.cityName = cityInfo[@"name"];
            region.pinyin = cityInfo[@"pinyin"];
            region.upperFirstLetter = [[cityInfo[@"pinyin"] substringToIndex:1] uppercaseString];
            [sortedArr addObject:region];
        }
    }
    
    // 2、对所有城市进行排序
    [sortedArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UMSRegionConstant *region1 = (UMSRegionConstant *)obj1;
        UMSRegionConstant *region2 = (UMSRegionConstant *)obj2;
        return [region1.pinyin localizedCompare:region2.pinyin];
    }];
    
    // 3、分组
    UMSRegionGroup *firsRegionGroup = [UMSRegionGroup new];
    firsRegionGroup.firstLetter = [(UMSRegionConstant *)sortedArr[0] upperFirstLetter];
    [firsRegionGroup.nodes addObject:(UMSRegionConstant *)sortedArr[0]];
    
    NSMutableArray *groupsArr = [NSMutableArray arrayWithObject:firsRegionGroup];
    if (sortedArr.count > 1) {
        
        for (int i = 1; i < [sortedArr count]; i++) {
            
            // 取出前一个城市的首字母
            UMSRegionGroup *preRegionGroup = groupsArr[groupsArr.count - 1];
            NSString *preLetter = [preRegionGroup.nodes[0] upperFirstLetter];
            
            // 取出当前城市的首字母
            UMSRegionConstant *currentRegion = sortedArr[i];
            NSString *curLetter = [currentRegion upperFirstLetter];
            
            if ([curLetter is:preLetter]) {
                [preRegionGroup.nodes addObject:currentRegion];
            }
            else {
                UMSRegionGroup *curRegionGroup = [UMSRegionGroup new];
                curRegionGroup.firstLetter = currentRegion.upperFirstLetter;
                [curRegionGroup.nodes addObject:currentRegion];
                [groupsArr addObject:curRegionGroup];
            }
        }
    }
    
    self.sectionsArray = groupsArr;
    
    // 取出所有大写字母
    self.keywords = [NSMutableArray arrayWithCapacity:0];
    for (UMSRegionGroup *group in self.sectionsArray) {
        [self.keywords addObject:group.firstLetter];
    }
    
    [self.tableView reloadData];
}

- (UMSRegionConstant *)_matchRegion:(NSString *)locality state:(NSString *)state {
    
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"UMSSDK" ofType:@"bundle"];
    NSString *path = [bundle stringByAppendingPathComponent:@"region.plist"];
    NSArray *provs = [NSArray arrayWithContentsOfFile:path];
    
    UMSRegionConstant *region = [[UMSRegionConstant alloc] init];
    for (NSDictionary *provInfo in provs) {
        NSString *provName = provInfo[@"name"];
        if ([provName is:state]) {
            NSArray *cities = provInfo[@"citys"];
            for (NSDictionary *cityInfo in cities) {
                NSString *cityName = cityInfo[@"name"];
                if ([cityName is:locality]) {
                    region.provinceId = [provInfo[@"id"] integerValue];
                    region.provinceName = provName;
                    region.cityId = [cityInfo[@"id"] integerValue];
                    region.cityName = cityName;
                    break;
                }
            }
        }
    }
    return region;
}

- (void)reverseGeocodeLocation:(CLLocation *)location completion:(void(^)(BOOL success, UMSRegionConstant *region))completion {
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if ([placemarks count] > 0) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            
            NSString *state = placemark.administrativeArea;
            NSString *locality = placemark.locality;  // 市
            
            if ([state length] > 0 && [locality length] > 0) {
                
                if ([state containsString:@"省"]) {
                    state = [state stringByReplacingOccurrencesOfString:@"省" withString:@""];
                } else if ([state containsString:@"自治区"]) {
                    state = [state stringByReplacingOccurrencesOfString:@"自治区" withString:@""];
                } else if ([state containsString:@"特别行政区"]) {
                    state = [state stringByReplacingOccurrencesOfString:@"特别行政区" withString:@""];
                }
                
                if ([locality containsString:@"市"]) {
                    locality = [locality stringByReplacingOccurrencesOfString:@"市" withString:@""];
                }
                
                UMSRegionConstant *region = [self _matchRegion:locality state:state];
                if (region.cityName.length > 0) {
                    if (completion) { completion(true, region); }
                } else {
                    if (completion) { completion(false, [self _matchRegion:@"金坛" state:@"江苏"]); }
                }
            } else {
                if (completion) { completion(false, [self _matchRegion:@"金坛" state:@"江苏"]); }
            }
        }
        else if (error == nil && [placemarks count] == 0) {  // 没有获取到位置
            if (completion) { completion(false, [self _matchRegion:@"金坛" state:@"江苏"]); }
        }
        else if (error != nil) {  // 反地理编码错误
            if (completion) { completion(false, [self _matchRegion:@"金坛" state:@"江苏"]); }
        }
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionsArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section > 0) {
        UMSRegionGroup *group = self.sectionsArray[section - 1];
        return [group.nodes count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kRegionTableCellID = @"UMSRegionTableCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRegionTableCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithReuseIdentifier:kRegionTableCellID];
        if (indexPath.section == 0) {
            cell.textLabel.text = @"正在定位...";
        }
    }
    
    cell.textLabel.font = BTKFONT_SIZED(15.0);
    
    if (indexPath.section > 0) {
        UMSRegionGroup *group = self.sectionsArray[indexPath.section - 1];
        UMSRegionConstant *region = group.nodes[indexPath.row];
        cell.textLabel.text = region.cityName;
    }
    else {
        cell.textLabel.text = self.currentRegion == nil ? [UMSRegionConstant sharedInstance].cityName : self.currentRegion.cityName;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keywords;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}


#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    header.backgroundColor = TT_LIGHT_GRAY_COLOR;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = BTKFONT_SIZED(13);
    label.textColor = [UIColor darkGrayColor];
    label.text = section == 0 ? @"您当前的位置可能是" : [(UMSRegionGroup *)self.sectionsArray[section - 1] firstLetter];
    [header addSubview:label];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section > 0) {
        
        // 把用户选择的省市保存到沙盒中
        UMSRegionGroup *group = self.sectionsArray[indexPath.section - 1];
        UMSRegionConstant *region = group.nodes[indexPath.row];
        
        [UMSRegionConstant sharedInstance].cityId = region.cityId;
        [UMSRegionConstant sharedInstance].cityName = region.cityName;
        
        if (self.selectRegionHandler) {
            self.selectRegionHandler(region);
        }
    }
    else {
        
        if (self.currentRegion == nil) {
            [self showError:@"尚未定位成功!"];
            return;
        } else {
            if (self.selectRegionHandler) {
                self.selectRegionHandler(self.currentRegion);
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
