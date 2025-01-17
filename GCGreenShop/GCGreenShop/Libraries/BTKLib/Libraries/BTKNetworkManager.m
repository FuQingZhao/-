//
//  BTKNetworkManager.m
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "NSFileManager+BTKLib.h"

#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format, ##__VA_ARGS__]

@implementation BTKNetworkManager

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark - 开始监听网络

+ (void)networkStatusWithBlock:(BTKNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(BTKNetworkStatusUnknown) : nil;
                    PPLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(BTKNetworkStatusNotReachable) : nil;
                    PPLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(BTKNetworkStatusReachableViaWWAN) : nil;
                    PPLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(BTKNetworkStatusReachableViaWiFi) : nil;
                    PPLog(@"WIFI");
                    break;
            }
        }];
    });
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}


#pragma mark - 请求无缓存

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(BTKHttpRequestSuccess)success
                  failure:(BTKHttpRequestFailed)failure {
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(BTKHttpRequestSuccess)success
                   failure:(BTKHttpRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}

+ (NSURLSessionTask *)JSON:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(BTKHttpRequestSuccess)success
                   failure:(BTKHttpRequestFailed)failure {
    return [self JSON:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - 请求自动缓存

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
            responseCache:(BTKHttpRequestCache)responseCache
                  success:(BTKHttpRequestSuccess)success
                  failure:(BTKHttpRequestFailed)failure {
    //读取缓存
    responseCache ? responseCache([BTKNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"%@", _isOpenLog ? NSStringFormat(@"responseObject = %@", [self jsonToString:responseObject]) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
        //对数据进行异步缓存
        responseCache ? [BTKNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        PPLog(@"%@", _isOpenLog ? NSStringFormat(@"error = %@",error) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(BTKHttpRequestCache)responseCache
                   success:(BTKHttpRequestSuccess)success
                   failure:(BTKHttpRequestFailed)failure {
    //读取缓存
    responseCache ? responseCache([BTKNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"%@", _isOpenLog ? NSStringFormat(@"responseObject = %@",[self jsonToString:responseObject]) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
        //对数据进行异步缓存
        responseCache ? [BTKNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        PPLog(@"%@", _isOpenLog ? NSStringFormat(@"error = %@",error) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

+ (NSURLSessionTask *)JSON:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(BTKHttpRequestCache)responseCache
                   success:(BTKHttpRequestSuccess)success
                   failure:(BTKHttpRequestFailed)failure {
    
    //读取缓存
    responseCache ? responseCache([BTKNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/JavaScript", @"text/html", @"text/plain", nil];
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"%@", _isOpenLog ? NSStringFormat(@"responseObject = %@",[self jsonToString:responseObject]) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
        //对数据进行异步缓存
        responseCache ? [BTKNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        PPLog(@"%@", _isOpenLog ? NSStringFormat(@"error = %@",error) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}


#pragma mark - 上传文件

+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(BTKHttpProgress)progress
                                success:(BTKHttpRequestSuccess)success
                                failure:(BTKHttpRequestFailed)failure {
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([filePath length] > 0) {
            NSError *error = nil;
            [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
            (failure && error) ? failure(error) : nil;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"%@",_isOpenLog ? NSStringFormat(@"responseObject = %@",[self jsonToString:responseObject]) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        PPLog(@"%@",_isOpenLog ? NSStringFormat(@"error = %@",error) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片

+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(NSDictionary *)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(BTKHttpProgress)progress
                                  success:(BTKHttpRequestSuccess)success
                                  failure:(BTKHttpRequestFailed)failure {
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@", str, (long)i, imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PPLog(@"%@",_isOpenLog ? NSStringFormat(@"responseObject = %@",[self jsonToString:responseObject]) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        PPLog(@"%@",_isOpenLog ? NSStringFormat(@"error = %@",error) : @"RWNetworkManager已关闭日志打印");
        printf("%s\n", [(_isOpenLog ? task.currentRequest.URL.absoluteString : @"") UTF8String]);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}


#pragma mark - 下载文件

+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(BTKHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(BTKHttpRequestFailed)failure {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSFileManager libCachePath] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self cancelRequestWithURL:URL];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
    }];
    
    //开始下载
    [downloadTask resume];
    
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;
    
    return downloadTask;
}

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(!data) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}


#pragma mark - 初始化AFHTTPSessionManager相关属性

/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setRequestSerializer:(BTKRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = (requestSerializer == BTKRequestSerializerHTTP) ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(BTKResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = (responseSerializer == BTKResponseSerializerHTTP) ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


#pragma mark - NSDictionary,NSArray的分类

/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    return strM;
}

@end

@implementation NSDictionary (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [strM appendString:@"}\n"];
    return strM;
}
@end
#endif
