//
//  TTHomeTableViewBoard.m
//  GCGreenShop
//
//  Created by 付清照 on 2019/11/11.
//  Copyright © 2019 FuQingZhao. All rights reserved.
//

#import "TTHomeTableViewBoard.h"
#import <SDCycleScrollView/SDCycleScrollView.h> //banner


#import "TTHomeBannerModel.h"

#import "TTHomeClassCell.h"

@interface TTHomeTableViewBoard ()
@property (nonatomic, strong) NSMutableArray *netImages;
@property (nonatomic, strong) NSMutableArray *homeBannerAry;
@end

#define TableCell_Height 157.f

@implementation TTHomeTableViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*test*/
    
    self.homeBannerAry = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0 ; i < 5; i ++) {
        TTHomeBannerModel *model = [[TTHomeBannerModel alloc] init];
        [self.homeBannerAry addObject:model];
    }
    
    self.netImages = [NSMutableArray arrayWithCapacity:3];
    [self.netImages addObjectsFromArray:[self netImageArray]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"index_scroll"];
    self.tableView.rowHeight = TableCell_Height;
    
    UIView *headBackView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, TableCell_Height)];
    self.tableView.tableHeaderView = headBackView;
    
    SDCycleScrollView *cycleScrollView = [TTBannerUtil ScrollNetWorkImages:_netImages];
    [headBackView addSubview:cycleScrollView];
    
    
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:TTGreenColor];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
}

- (NSArray *)netImageArray{
    NSArray *imageArray = @[
                            @"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f507b2e99aa64034f78f01930.jpg",
                            @"http://b.hiphotos.baidu.com/zhidao/pic/item/4b90f603738da9770889666fb151f8198718e3d4.jpg",
                            @"http://g.hiphotos.baidu.com/zhidao/pic/item/f2deb48f8c5494ee4e84ef5d2cf5e0fe98257ed4.jpg",
                            @"http://d.hiphotos.baidu.com/zhidao/pic/item/9922720e0cf3d7ca104edf32f31fbe096b63a93e.jpg"
                            ];
    return imageArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *index_class = @"index_class";
    static NSString *index_libao = @"index_libao";
    static NSString *index_recommend = @"index_recommend";
    
    if ( indexPath.section == 0 ) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index_class];
        if ( !cell ) {
            cell = [[TTHomeClassCell alloc] initWithReuseIdentifier:index_class];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index_class];
        if ( !cell ) {
            cell = [[TTHomeClassCell alloc] initWithReuseIdentifier:index_class];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    
}

- (void)dealloc
{
    NSLog(@"首页：%@",[self class]);
}

@end
