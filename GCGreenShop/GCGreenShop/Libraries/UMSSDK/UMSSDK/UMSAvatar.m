//
//  UMSAvatar.m
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/12.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import "UMSAvatar.h"

static CGFloat const kMinAvatarWidth = 60.0;
static CGFloat const kMiddleAvatarWidth = 120.0;
static CGFloat const kMaxAvatarWidth = 240.0;

@implementation UMSAvatar

+ (void)minAvatarWithURL:(NSURL *)url placeholder:(UIImage *)placeholder block:(void(^) (UIImage *image, NSError *error))block {
    [[self class] avatarWithURLString:url.absoluteString constrainedToWidth:kMinAvatarWidth placeholder:placeholder completion:block];
}

+ (void)middleAvatarWithURL:(NSURL *)url placeholder:(UIImage *)placeholder block:(void(^) (UIImage *image, NSError *error))block {
    [[self class] avatarWithURLString:url.absoluteString constrainedToWidth:kMiddleAvatarWidth placeholder:placeholder completion:block];
}

+ (void)maxAvatarWithURL:(NSURL *)url placeholder:(UIImage *)placeholder block:(void(^) (UIImage *image, NSError *error))block {
    [[self class] avatarWithURLString:url.absoluteString constrainedToWidth:kMaxAvatarWidth placeholder:placeholder completion:block];
}

+ (void)avatarWithURLString:(NSString *)URLString
         constrainedToWidth:(CGFloat)width
                placeholder:(UIImage *)placeholder
                 completion:(void (^)(UIImage *image, NSError *error))completion {
    
    if ([URLString length] == 0) {
        if (completion) { completion(placeholder, [NSError errorWhy:@"图片地址错误"]); }
        return;
    }
    
    NSString *cacheUrl = [URLString stringByAppendingFormat:@"_%.2f", width];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    UIImage *image = [SDImageCache.sharedImageCache imageFromCacheForKey:cacheUrl];
    if (image == nil) {
        [SDWebImageManager.sharedManager.imageDownloader downloadImageWithURL:URL options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            //
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                UIImage *newImage = [image thumbnailImage:width transparentBorder:0.0 cornerRadius:(width / 2.0) interpolationQuality:kCGInterpolationHigh];
                [SDImageCache.sharedImageCache storeImage:newImage forKey:cacheUrl completion:nil];
                if (completion) { completion(newImage, nil); }
            }
            else {
                if (completion) { completion(placeholder, error); }
            }
        }];
    }
    else {
        if (completion) { completion(image, nil); }
    }
}

@end
