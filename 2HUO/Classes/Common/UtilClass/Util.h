//
//  Created by iURCoder on 11/5/15.
//  Copyright © 2015 iUR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
///-------------------------------------------------------------
/// @brief 应用程序目录的路径，在该目录下有三个文件夹：Documents、Library、temp以及一个.app包！
/// @name 该目录下就是应用程序的沙盒，应用程序只能访问该目录下的文件夹！！！
///-------------------------------------------------------------
+ (NSString *)homePath;
///-------------------------------------------------------------
/// @brief 数据所存桌面的绝对路径
///-------------------------------------------------------------
+ (NSString *)desktopPath;
///-------------------------------------------------------------
/// @brief 文档目录，需要ITUNES同步备份的数据存这里
///-------------------------------------------------------------
+ (NSString *)documentPath;
///-------------------------------------------------------------
/// @brief 配置目录，配置文件存这里
///-------------------------------------------------------------
+ (NSString *)libPrePath;
///-------------------------------------------------------------
/// @brief 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
///-------------------------------------------------------------
+ (NSString *)libCachePath;
///-------------------------------------------------------------
/// @brief .app 程序相对目录，不能存任何东西
///-------------------------------------------------------------
+ (NSString *)appPath;
///-------------------------------------------------------------
/// @brief .app 缓存目录，APP退出后，系统可能会删除这里的内容
///-------------------------------------------------------------
+ (NSString *)tmpPath;
///-------------------------------------------------------------
/// @brief .app 程序绝对目录，不能存任何东西
///-------------------------------------------------------------
+ (NSString *)resourcePath;
///-------------------------------------------------------------
/// @brief 当前版本号
///-------------------------------------------------------------
+ (NSString *)currentVersion;
///-------------------------------------------------------------
/// @brief 创建文件夹
///-------------------------------------------------------------
+ (BOOL)touchPath:(NSString *)path;
///-------------------------------------------------------------
/// @brief 创建文件
///-------------------------------------------------------------
+ (BOOL)touchFile:(NSString *)file;
///-------------------------------------------------------------
/// @brief 同一个类内 交换两个实例方法
///-------------------------------------------------------------
+ (BOOL)swizzleMethod:(SEL)originalSelector
                 with:(SEL)anotherSelector
                   in:(Class)klass;
///-------------------------------------------------------------
/// @brief 两个不同类 交换两个实例方法
///-------------------------------------------------------------
+ (BOOL)swizzleMethod:(SEL)originalSelector
                   in:(Class)klass
                 with:(SEL)anotherSelector
                   in:(Class)anotherKlass;
///-------------------------------------------------------------
/// @brief 同一个类内 交换两个类方法
///-------------------------------------------------------------
+ (BOOL)swizzleClassMethod:(SEL)originalSelector
                      with:(SEL)anotherSelector
                        in:(Class)klass;
///-------------------------------------------------------------
/// @brief 两个不同类 交换两个类方法
///-------------------------------------------------------------
+ (BOOL)swizzleClassMethod:(SEL)originalSelector
                        in:(Class)klass
                      with:(SEL)anotherSelector
                        in:(Class)anotherKlass;
///-------------------------------------------------------------
/// @brief runloop 相关 （...）
///-------------------------------------------------------------
+ (void)waitUntil:(BOOL (^)(void))condition;
+ (void)waitUntil:(BOOL (^)(void))condition timeOut:(NSTimeInterval)timeOut;
+ (void)waitUntil:(BOOL (^)(void))condition
          timeOut:(NSTimeInterval)timeOut
         interval:(NSTimeInterval)interval;
@end

