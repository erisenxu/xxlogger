/*
 * @(#) Logger.h Created on 2016-03-27
 *
 * Copyright (c) 2014-2016 Erisen Xu (@itfriday)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

/**
 * 日志Level
 * DEBUG    100
 * INFO     200
 * WARNING  300
 * ERROR    400
 */
#define LOG_LEVEL_PROTO     50
#define LOG_LEVEL_DEBUG     100
#define LOG_LEVEL_INFO      200
#define LOG_LEVEL_WARN      300
#define LOG_LEVEL_ERROR     400

@interface Logger : NSObject

#pragma mark 初始化函数

/**
 * 初始化函数
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 */
- (instancetype)initLogWithName:(NSString *)fileName ;

/**
 * 初始化函数
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 */
- (instancetype)initLogWithName:(NSString *)fileName logLevel:(int)logLevel ;

/**
 * 初始化函数
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 * @param maxLogSize 最大日志大小
 */
- (instancetype)initLogWithName:(NSString *)fileName logLevel:(int)logLevel maxLogSize:(unsigned long long)maxLogSize ;

#pragma mark 日志打印函数

/**
 * 打印proto级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)protocol:(NSString *)format, ... ;

/**
 * 打印debug级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)debug:(NSString *)format, ... ;

/**
 * 打印info级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)info:(NSString *)format, ... ;

/**
 * 打印warning级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)warn:(NSString *)format, ... ;

/**
 * 打印error级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)error:(NSString *)format, ... ;

#pragma mark 辅助函数

/**
 * 返回指定日志级别的级别描述
 */
+ (NSString *)getLogLevelName:(int)logLevel ;

/**
 * 返回指定日志级别
 * @param levelName 日志级别名
 * @return 返回日志级别名对应的日志级别
 */
+ (int)getLogLevel:(NSString *)levelName defLevel:(int)defLevel ;

@end
