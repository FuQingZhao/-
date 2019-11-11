//
//  UMSAvatar.h
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/12.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMSAvatar : NSObject

/**
 根据传入的头像地址生成一个小头像
 
 @param  url  头像地址
 @param  placeholder  默认头像图片
 @param  block  回调
 */
+ (void)minAvatarWithURL:(NSURL *)url placeholder:(UIImage *)placeholder block:(void(^) (UIImage *image, NSError *error))block;

/**
 根据传入的头像地址生成一个中头像
 
 @param  url  头像地址
 @param  placeholder  默认头像图片
 @param  block  回调
 */
+ (void)middleAvatarWithURL:(NSURL *)url placeholder:(UIImage *)placeholder block:(void(^) (UIImage *image, NSError *error))block;

/**
 根据传入的头像地址生成一个大头像
 
 @param  url  头像地址
 @param  placeholder  默认头像图片
 @param  block  回调
 */
+ (void)maxAvatarWithURL:(NSURL *)url placeholder:(UIImage *)placeholder block:(void(^) (UIImage *image, NSError *error))block;

/**
 根据传入的头像地址生成一个大头像
 
 @param  URLString  头像地址
 @param  width      头像大小
 @param  placeholder  默认头像图片
 @param  completion  回调
 */
+ (void)avatarWithURLString:(NSString *)URLString
         constrainedToWidth:(CGFloat)width
                placeholder:(UIImage *)placeholder
                 completion:(void (^)(UIImage *image, NSError *error))completion;

@end
