//
//  TTHomeClassCell.h
//  GCGreenShop
//
//  Created by 付清照 on 2019/11/11.
//  Copyright © 2019 FuQingZhao. All rights reserved.
//

#import "BTKTableViewCell.h"

#import "TTHomeClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTHomeClassCell : BTKTableViewCell

- (void)fillHomeClassModel:(NSArray *)classAry;

@end

NS_ASSUME_NONNULL_END
