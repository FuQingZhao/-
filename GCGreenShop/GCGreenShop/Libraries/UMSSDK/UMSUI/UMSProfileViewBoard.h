//
//  UMSProfileViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"

@interface UMSProfileViewBoard : UMSBaseViewBoard <UITableViewDelegate, UITableViewDataSource>

AS_NOTIFICATION(AVATAR_UPDATED)

@property (nonatomic, strong, readonly) UITableView *tableView;

@end
