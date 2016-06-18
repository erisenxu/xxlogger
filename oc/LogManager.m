/*
 * @(#) LogManager.m Created on 2016-03-27
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

#import "LogManager.h"

@interface LogManager ()

@property (nonatomic, strong) Logger* logger;

@end

@implementation LogManager

/**
 * 单例
 */
+ (instancetype) getInstance {
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance ;
}

/**
 * 初始化日志
 */
- (void) initLogger {
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    
    // 1. 获取日志文件名，如果没有配置，使用程序名称
    NSString *logName = [dic objectForKey:@"AppLogFileName"];
    
    if (!logName) {
        logName = [dic objectForKey:@"CFBundleName"];
    }
    
    // 2. 获取日志路径，把日志放在cache目录下面，并得到包含路径日志文件名
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    NSString *logFileName = [NSString stringWithFormat:@"%@/%@.log", cachePath, logName];
    
    // 3. 日志打印级别
    NSString *sLogLevel = [dic objectForKey:@"AppLogLevel"];
    int logLevel = [Logger getLogLevel:sLogLevel defLevel:LOG_LEVEL_ERROR];
    
    // 4. 最大日志大小
    unsigned long long maxLogSize = [[dic objectForKey:@"AppMaxLogLevel"] unsignedLongLongValue];
    if (0 == maxLogSize) maxLogSize = 1048576;
    
    [self initLogger:logFileName logLevel:logLevel maxLogSize:maxLogSize];
}

/**
 * 初始化日志
 */
- (void) initLogger:(NSString *)logFileName logLevel:(int)logLevel maxLogSize:(unsigned long long)maxLogSize {
    _logger = [[Logger alloc] initLogWithName:logFileName logLevel:logLevel maxLogSize:maxLogSize];
}

/**
 * 获取日志打印对象
 * @return 返回日志打印对象
 */
- (Logger *) getLogger {
    return _logger;
}

@end
