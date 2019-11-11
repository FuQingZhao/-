//
//  UMSProfileViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSProfileViewBoard.h"
#import "UMSInputViewBoard.h"
#import "UMSSelectRegionViewBoard.h"
#import "UMSDatePickerView.h"
#import "UMSProfileTableCell.h"

@interface UMSProfileViewBoard () <UIAlertViewDelegate, UMSDatePickerDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *profileInfos;
@end

@implementation UMSProfileViewBoard

DEF_NOTIFICATION(AVATAR_UPDATED)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self _initTableView];
    [self _initData];
    [self _initLogoutButton];
}


#pragma mark - Default UI

- (void)_initTableView {
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
}

- (void)_initLogoutButton {
    
    CGFloat leftPadding = BTK_THAT_FITS(15.0);
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutButton.origin = CGPointMake(leftPadding, 55.0 * [self.profileInfos count] + BTK_THAT_FITS(50.0));
    logOutButton.size = CGSizeMake(self.view.frame.size.width - leftPadding * 2, BTK_THAT_FITS(46.0));
    [logOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.view addSubview:logOutButton];
    
    [logOutButton bk_addEventHandler:^(id sender) {
        [UIAlertView bk_showAlertViewWithTitle:nil message:@"确认退出登录?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex != alertView.cancelButtonIndex) {
                [UMSSDK logoutWithResult:^(NSError *error) {
                    if (error == nil) {
                        [self showWithStatus:@"已成功退出登录~"];
                        [self performBlock:^{
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } afterDelay:0.35];
                    }
                }];
            }
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_initData {
    
    UMSUser *currentUser = [UMSSDK currentUser];
    NSString *avatar = [currentUser.avatar length] > 0 ? currentUser.avatar : @"";
    NSString *nickname = [currentUser.nickname length] > 0 ? currentUser.nickname : @"";
    NSString *city = [currentUser.city length] > 0 ? currentUser.city : @"";
    NSString *birthday = [NSDate stringWithDate:currentUser.birthday format:@"yyyy/MM/dd"];
    if ([birthday length] == 0) { birthday = @""; }
    
    self.profileInfos = [NSMutableArray arrayWithCapacity:4];
    [self.profileInfos addObject:@{kPROTitleField: @"头像", kPROValueField: avatar, kPRORowHeightField:@(defProfileAvatarHeight), kPROLinePaddingField:@15.0, kPROTableCellType: @(UMSProfileCellStyleWithAvatar)}];
    [self.profileInfos addObject:@{kPROTitleField: @"昵称", kPROValueField: nickname, kPRORowHeightField:@(defProfileNormalHeight), kPROLinePaddingField:@15.0, kPROTableCellType: @(UMSProfileCellStyleNormal)}];
    [self.profileInfos addObject:@{kPROTitleField: @"所在地", kPROValueField: city, kPRORowHeightField:@(defProfileNormalHeight), kPROLinePaddingField:@15.0, kPROTableCellType: @(UMSProfileCellStyleNormal)}];
    [self.profileInfos addObject:@{kPROTitleField: @"出生日期", kPROValueField: birthday, kPRORowHeightField:@(defProfileNormalHeight), kPROLinePaddingField:@-1.0, kPROTableCellType: @(UMSProfileCellStyleNormal)}];
}


#pragma mark - Requests

- (void)_updateAvatar:(UIImage *)avatar {
    /*
    [JTPicUploadUtil uploadImage:avatar type:JTPicUploadTypeUserPhoto finish:^(NSString *picUrl) {
        if (picUrl.length) {
            NSDictionary *param = @{@"uid": [UMSSDK currentUser].uid, @"HeadPic": picUrl};
            [RWNetworkManager JSON:JT_UPLOAD_AVATA_URL parameters:param success:^(id responseObject) {
                [self showSuccess:[[responseObject objectForKey:@"Message"] asNSString]];
                if ([responseObject[@"ResultCode"] asInt] == 0) {
                    [UMSSDK currentUser].avatar = picUrl;
                    [self postNotification:self.AVATAR_UPDATED];
                }
            } failure:^(NSError *error) {
                [self showError:@"网络错误"];
            }];
        }
    }];
     */
}

- (void)_updateNickname:(NSString *)nickname {
    /*
    NSDictionary *params = @{@"uid": [UMSSDK currentUser].uid, @"username": nickname};
    [RWNetworkManager JSON:JT_USERINFO_EDIT_URL parameters:params success:^(id responseObject) {
        [self showSuccess:[[responseObject objectForKey:@"Message"] asNSString]];
        if ([responseObject[@"ResultCode"] asInt] == 200) {
            [UMSSDK currentUser].nickname = nickname;
        }
    } failure:^(NSError *error) {
        [self showError:@"修改失败"];
    }];
    */
}

- (void)_updateRegion:(NSString *)region {
    /*
    NSDictionary *params = @{@"uid": [UMSSDK currentUser].uid, @"address": region};
    [RWNetworkManager JSON:JT_USERINFO_EDIT_URL parameters:params success:^(id responseObject) {
        [self showSuccess:[[responseObject objectForKey:@"Message"] asNSString]];
        if ([responseObject[@"ResultCode"] asInt] == 200) {
            [UMSSDK currentUser].city = region;
        }
    } failure:^(NSError *error) {
        [self showError:@"修改失败"];
    }];
     */
}

- (void)_updateBirthday:(NSDate *)birthday {
    /*
    NSDictionary *params = @{@"uid": [UMSSDK currentUser].uid, @"birthday": [NSNumber numberWithDouble:[birthday timeIntervalSince1970]]};
    [RWNetworkManager JSON:JT_USERINFO_EDIT_URL parameters:params success:^(id responseObject) {
        [self showSuccess:[[responseObject objectForKey:@"Message"] asNSString]];
        if ([responseObject[@"ResultCode"] asInt] == 200) {
            [UMSSDK currentUser].birthday = birthday;
        }
    } failure:^(NSError *error) {
        [self showError:@"修改失败"];
    }];
     */
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.profileInfos count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *rowInfo = [self.profileInfos objectAtIndex:indexPath.row];
    return [[rowInfo objectForKey:kPRORowHeightField] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *kProfileTableCellID = @"UMSProfileTableCellId";
    UMSProfileTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfileTableCellID];
    if (!cell) {
        cell = [[UMSProfileTableCell alloc] initWithReuseIdentifier:kProfileTableCellID];
        cell.textLabel.font = BTKFONT_SIZED(15.0);
    }
    [cell configureDetailWithObject:[self.profileInfos objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = [indexPath row];
    
    /** 修改头像 */
    if (row == 0) {
        
    }
    /** 修改昵称 */
    else if (row == 1) {
        UMSInputViewBoard *inputViewBoard = [UMSInputViewBoard new];
        inputViewBoard.title = @"昵称";
        inputViewBoard.placeholderText = @"请输入昵称";
        inputViewBoard.defInputText = [UMSSDK currentUser].nickname;
        [self.navigationController pushViewController:inputViewBoard animated:YES];
        inputViewBoard.doneEditHandler = ^(NSString *text) {
            if (![text is:[UMSSDK currentUser].nickname]) {
                [self.profileInfos replaceObjectAtIndex:1 withObject:@{kPROTitleField: @"昵称", kPROValueField: text, kPRORowHeightField:@(defProfileNormalHeight), kPROLinePaddingField:@15.0, kPROTableCellType: @(UMSProfileCellStyleNormal)}];
                [self.tableView reloadRow:1 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
                [self _updateNickname:text];
            }
        };
    }
    /** 修改所在地 */
    else if (row == 2) {
        UMSSelectRegionViewBoard *selectRegionBoard = [UMSSelectRegionViewBoard new];
        selectRegionBoard.title = @"选择所在地";
        [self.navigationController pushViewController:selectRegionBoard animated:YES];
        selectRegionBoard.selectRegionHandler = ^(UMSRegionConstant *region) {
            [self.profileInfos replaceObjectAtIndex:2 withObject:@{kPROTitleField: @"所在地", kPROValueField: region.cityName, kPRORowHeightField:@(defProfileNormalHeight), kPROLinePaddingField:@15.0, kPROTableCellType: @(UMSProfileCellStyleNormal)}];
            [self.tableView reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
            [self _updateRegion:region.cityName];
        };
    }
    /** 修改出生日期 */
    else if (row == 3) {
        UMSDatePickerView *datePicker = [[UMSDatePickerView alloc] initWithTitle:@"选择生日" delegate:self];
        [datePicker showInView:self.tabBarController.view];
    }
}


#pragma mark - Other Delegates

- (void)ums_datePickerView:(UMSDatePickerView *)picker selectWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) { return; }
    
    NSString *birthday = picker.dateString;
    if ([birthday length] == 0) { birthday = @""; }
    [self.profileInfos replaceObjectAtIndex:3 withObject:@{kPROTitleField: @"出生日期", kPROValueField: birthday, kPRORowHeightField:@(defProfileNormalHeight), kPROLinePaddingField:@-1.0, kPROTableCellType: @(UMSProfileCellStyleNormal)}];
    [self.tableView reloadRow:3 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 发送请求修改生日信息
    [self _updateBirthday:[NSDate dateWithString:[picker dateString] format:@"yyyy/MM/dd"]];
}

/*
- (void)photoUtil:(JTPhotoUtil *)util didFinishPickingWithImage:(UIImage *)image {
    
    if (!image) { return; }
    
    CGFloat width = 80.0;
    UIImage *newImage = [image thumbnailImage:width transparentBorder:0.0 cornerRadius:(width / 2.0) interpolationQuality:kCGInterpolationHigh];
    [self.profileInfos replaceObjectAtIndex:0 withObject:@{kPROTitleField: @"头像", kPROValueField: newImage, kPRORowHeightField:@(defProfileAvatarHeight), kPROLinePaddingField:@15.0, kPROTableCellType: @(UMSProfileCellStyleWithAvatar)}];
    [self.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 修改头像请求
    [self _updateAvatar:newImage];
}
 */

@end
