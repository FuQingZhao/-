//
//  UMSSettingViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSSettingViewBoard.h"

NSString* const kSETImageField = @"ImageName";      // 图片名
NSString* const kSETTitleField = @"Title";          // 标题
NSString* const kSETValueField = @"Value";          // 内容
NSString* const kSETRowHeightField = @"RowHeight";  // Cell高度

@interface UMSSettingViewBoard ()
@property (nonatomic, strong, readwrite) UITableView *tableView;
@end

@implementation UMSSettingViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initData];
    [self _initTableView];
}

- (void)_initData {
    self.rowInfoArray = [NSMutableArray array];
}

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
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

@end


@implementation UMSSettingTableCell

- (void)load:(NSDictionary *)data {
    
    UIImage *image = [UIImage imageNamed:[data objectForKey:kSETImageField]];
    NSString *title = [data objectForKey:kSETTitleField];
    
    self.textLabel.font = BTKFONT_SIZED(15.0);
    [self.textLabel setText:title];
    [self.imageView setImage:image];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.size = self.imageView.image.size;
    self.imageView.left = BTK_THAT_FITS(15.0);
    self.imageView.centerY = UMSDefSettingRowHeight / 2.0;
    
    CGFloat textW = [self.textLabel.text sizeWithFont:BTKFONT_SIZED(15.0) constrainedToWidth:(kScreenWidth / 2.0)].width;
    self.textLabel.size = CGSizeMake(textW, UMSDefSettingRowHeight);
    self.textLabel.top = 0.0;
    self.textLabel.left = self.imageView.right + BTK_THAT_FITS(22.0);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (rect.size.width > 0 && rect.size.height > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self _drawLineInContext:context];
        CGContextStrokePath(context);
    }
}

- (void)_drawLineInContext:(CGContextRef)context {
    CGFloat top = UMSDefSettingRowHeight - 0.6;
    CGFloat hex = 227.0 / 255.0;
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 0.6);
    CGContextSetRGBStrokeColor(context, hex, hex, hex, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 54.0, top);
    CGContextAddLineToPoint(context, kScreenWidth, top);
}

@end
