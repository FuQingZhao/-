//
//  TT-Constants.h
//  TTReader
//
//  Created by LinMin on 2017/12/31.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#ifndef TT_Constants_h
#define TT_Constants_h

//-----------------
// 声音远程状态
//-----------------
typedef NS_ENUM(NSInteger, RemoteStatus) {
    RemoteStatusUnkown,
    RemoteStatusToggle,
    RemoteStatusPause,
    RemoteStatusPlay,
    RemoteStatusPrevious,
    RemoteStatusNext
};

//-----------------
// 颜色配置
//-----------------
#define TT_BLACK_COLOR        RGB(60, 67, 76)
#define TT_GRAY_WHITE_COLOR   RGB(228, 229, 230)
#define TT_NORMAL_GRAY_COLOR  RGB(164, 164, 164)
#define TT_LIGHT_GRAY_COLOR   RGB(207, 207, 207)
#define TT_LIGHT_WHITE_COLOR  RGB(242, 246, 247)
#define TT_RED_COLOR          RGB(241, 92, 82)
#define TT_GREEN_COLOR        RGB(0, 174, 103)
#define TT_ORANGE_COLOR       RGB(255, 137, 14)
#define TT_DARK_GREEN_COLOR   RGB(22, 132, 102)
#define TT_YELLOW_COLOR       RGB(252, 171, 42)
#define TT_PURPLE_COLOR       RGB(148, 83, 251)

#define TT_Black_COLOR        RGB(49, 49, 49)

/*tabble*/
#define TTGreenColor            [UIColor colorWithHexString:@"#32b18c"]
//#define TTTurquoiseColor      [UIColor colorWithHexString:@"#1ABC9C"]
//#define TTGreenSeaColor       [UIColor colorWithHexString:@"#16A085"]
//#define TTEmerlandColor       [UIColor colorWithHexString:@"#2ECC71"]
//#define TTNephritisColor      [UIColor colorWithHexString:@"#27AE60"]
//#define TTPeterRiverColor     [UIColor colorWithHexString:@"#3498DB"]
//#define TTAmethystColor       [UIColor colorWithHexString:@"#9B59B6"]
//#define TTWisteriaColor       [UIColor colorWithHexString:@"#8E44AD"]
//#define TTWetAsphaltColor     [UIColor colorWithHexString:@"#34495E"]
//#define TTMidnightBlueColor   [UIColor colorWithHexString:@"#2C3E50"]
//#define TTSunFlowerColor      [UIColor colorWithHexString:@"#F1C40F"]
//#define TTTangerineColor      [UIColor colorWithHexString:@"#F39C12"]
//#define TTCarrotColor         [UIColor colorWithHexString:@"#E67E22"]
//#define TTPumpkinColor        [UIColor colorWithHexString:@"#D35400"]
//#define TTAlizarinColor       [UIColor colorWithHexString:@"#E74C3C"]
//#define TTPomegranateColor    [UIColor colorWithHexString:@"#C0392B"]
#define TTCloudsColor         [UIColor colorWithHexString:@"#ECF0F1"]
//#define TTSilverColor         [UIColor colorWithHexString:@"#BDC3C7"]
//#define TTConcreteColor       [UIColor colorWithHexString:@"#95A5A6"]
//#define TTAsbestosColor       [UIColor colorWithHexString:@"#7F8C8D"]
//
//#define TTCellBackColor       [UIColor colorWithHexString:@"#eeeeee"]
//#define TTCellNameColor       [UIColor colorWithHexString:@"#494949"]
//#define TTCellContentColor    [UIColor colorWithHexString:@"#989898"]
//
//#define TT_BLACK_Label        [UIColor colorWithHexString:@"#333333"]
//#define TT_GRAY_Label         [UIColor colorWithHexString:@"#666666"]
//#define TT_GRAY_WHITE_Label   [UIColor colorWithHexString:@"#999999"]


//-----------------
// 布局参数配置
//-----------------
#define kLeftPadding          BTK_THAT_FITS(15.0)
#define kRightPadding         BTK_THAT_FITS(15.0)
#define kTopPadding           BTK_THAT_FITS(10.0)
#define kBottomPadding        BTK_THAT_FITS(10.0)
#define kBannerHeight         BTK_THAT_FITS(150.0)


//-----------------
// 其他配置
//-----------------
#define APP_DELEGATE         (TTAppDelegate *)[UIApplication sharedApplication].delegate
#define NAV_HEIGHT           64.0

#endif /* TT_Constants_h */
