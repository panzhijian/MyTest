//
//  QiaoMacro.h
//
//
//  Created by 葬花桥 on 14-10-11.
//  Copyright (c) 2014年  SouHanaQiao. All rights reserved.
//

//-------------------文件包含-------------------------
//#import "BlockUI.h"

#ifdef            WPX_DEBUG
#define           WPXLogv(Log) NSLog(Log)
#define           WPXLog(Log, parm) NSLog(Log, parm)
#endif

#ifndef           WPX_DEBUG
#define           WPXLogv(Log)
#define           WPXLog(Log, parm)
#endif

//-------------------打印日志-------------------------
//重写NSLog,Debug模式下打印日志和当前行数
#define       WPX_DEBUG
//#if DEBUG
#ifdef        WPX_DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
//-------------------打印日志-------------------------

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//-------------------获取设备大小-------------------------

//-------------------G－C－D-------------------------
#define ASYNC_THREAD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN_THREAD(block) dispatch_async(dispatch_get_main_queue(),block)
//-------------------G－C－D-------------------------

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//-------------------内存管理-------------------------
#if __has_feature(objc_arc)
#define WPX_AUTORC 1
#else
#define WPX_AUTORC 0
#endif

#ifndef           PX_STRONG
#if               WPX_AUTORC
#define PX_STRONG strong
#else
#define PX_STRONG retain
#endif
#endif

#ifndef           PX_WEAK
#if               __has_feature(objc_arc_weak)
#define PX_WEAK   weak
#elif             __has_feature(objc_arc)
#define PX_WEAK   unsafe_unretained
#else
#define PX_WEAK   assign
#endif
#endif

#if WPX_AUTORC
#define PX_AUTORELEASE(expression) expression
#define PX_RELEASE(expression)
#define PX_RETAIN(expression)      expression
#define PX_RELEASESELF(expression) expression = nil
#else
#define PX_AUTORELEASE(expression) [expression autorelease]
#define PX_RELEASE(expression)     [expression release]
#define PX_RETAIN(expression)      [expression retain]
#define PX_RELEASESELF(expression) [expression release]
#endif
//-------------------内存管理-------------------
