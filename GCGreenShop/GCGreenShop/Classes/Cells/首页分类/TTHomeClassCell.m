//
//  TTHomeClassCell.m
//  GCGreenShop
//
//  Created by 付清照 on 2019/11/11.
//  Copyright © 2019 FuQingZhao. All rights reserved.
//

#import "TTHomeClassCell.h"

@implementation TTHomeClassCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithReuseIdentifier:reuseIdentifier] ) {
        //
    }
    return self;
}

- (void)fillHomeClassModel:(NSArray *)classAry
{
    [self.contentView removeAllSubviews];
    
    MJWeakSelf;
    for (int i = 0; i < classAry.count; i ++) {
        int x = i/5;
        int y = i%5;
        UIControl *classBtn = [UIControl new];
        classBtn.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:classBtn];
        
        [classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset(15.0 + 72.0*x);
            make.top.equalTo(weakSelf.contentView).offset(7.0 + 69.0*y);
            make.size.mas_equalTo(CGSizeMake(39.0 , 39.0));
        }];
        
        UIImageView *classImg = [[UIImageView alloc] init];
        
        classImg.backgroundColor = [UIColor clearColor];
        [classBtn addSubview:classImg];
        
        [classImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(classBtn);
            make.right.equalTo(classBtn);
            make.size.mas_equalTo(CGSizeMake(39.0, 39.0));
        }];
    }
}

@end
