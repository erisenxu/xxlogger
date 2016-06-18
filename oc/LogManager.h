/*
 * @(#) LogManager.h Created on 2016-03-27
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

#import "Logger.h"

#define LOGGER [[LogManager getInstance] getLogger]

@interface LogManager : NSObject

/**
 * 单例
 */
+ (instancetype) getInstance ;

/**
 * 初始化日志
 */
- (void) initLogger ;

/**
 * 初始化日志
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 * @param maxLogSize 最大日志大小
 */
- (void) initLogger:(NSString *)logFileName logLevel:(int)logLevel maxLogSize:(unsigned long long)maxLogSize ;

/**
 * 获取日志打印对象
 * @return 返回日志打印对象
 */
- (Logger *) getLogger ;

@end
