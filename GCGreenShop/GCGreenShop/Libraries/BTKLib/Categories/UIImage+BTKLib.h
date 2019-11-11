//
//  UIImage+BTKLib.h
//  TTReader
//
//  Created by LinMin on 2018/1/1.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTKIMAGE(bundleResourceName)       [UIImage imageNamed:(bundleResourceName)]
#define BTKIMAGE_EX(bundleResourceName)    [UIImage imageWithContentsOfFile:(bundleResourceName)]

@interface UIImage (BTKLib)

/**
 *  @brief  根据指定的坐标与大小裁剪图片
 *
 *  @param  rect    指定的坐标与大小
 */
- (UIImage *)croppedImage:(CGRect)rect;

/**
 *  @brief  根据指定大小裁剪一张正方形图片
 *
 *  @param  thumbnailSize    指定大小
 *  @param  borderSize       边框的大小
 *  @param  cornerRadius     圆角的大小
 *  @param  quality          图片质量
 */
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

/**
 *  @brief  根据指定大小裁剪图片
 *
 *  @param  newSize    指定大小
 *  @param  quality    图片质量
 */
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

/**
 *  @brief  根据指定大小裁剪图片
 *
 *  @param  contentMode      图片模式
 *  @param  bounds           指定大小
 *  @param  quality          图片质量
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

/**
 *  @brief  根据指定大小裁剪图片
 *
 *  @param  newSize      指定大小
 *  @param  transform    旋转
 *  @param  transpose    是否颠倒
 *  @param  quality      图片质量
 */
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

/**
 *  @brief  先按比例压缩图片
 */
- (UIImage *)resizedImageByWidth:(NSUInteger)width;
- (UIImage *)resizedImageByHeight:(NSUInteger)height;
- (UIImage *)resizedImageWithMaximumSize:(CGSize)size;
- (UIImage *)resizedImageWithMinimumSize:(CGSize)size;

/**
 *  @brief  计算图片旋转角度
 */
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

/**
 圆角处理
 */
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;

/**
 Alpha通道
 */
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

@end
