/*
 * @(#) Logger.m Created on 2016-03-27
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

@interface Logger()

@property (nonatomic, strong) NSString* logFileName;                    // 日志文件名,包含路径;
@property (nonatomic, assign) int logLevel;                             // 日志打印级别
@property (nonatomic, assign) unsigned long long maxLogSize;            // 最大日志大小
@property (nonatomic, strong) dispatch_queue_t logQueue;                // 打印日志的线程队列

@end

@implementation Logger

#pragma mark 初始化函数

/**
 * 初始化函数
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 */
- (instancetype)initLogWithName:(NSString *)fileName {
    return [self initLogWithName:fileName logLevel:LOG_LEVEL_ERROR];
}

/**
 * 初始化函数
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 */
- (instancetype)initLogWithName:(NSString *)fileName logLevel:(int)logLevel {
    return [self initLogWithName:fileName logLevel:logLevel maxLogSize:1048576]; // 默认1M大小
}

/**
 * 初始化函数
 * @param logFileName 日志文件名,包含路径
 * @param logLevel 日志打印级别
 * @param maxLogSize 最大日志大小
 */
- (instancetype)initLogWithName:(NSString *)fileName logLevel:(int)logLevel maxLogSize:(unsigned long long)maxLogSize {
    if (self = [super init]) {
        _logFileName = fileName;
        _logLevel = logLevel;
        _maxLogSize = maxLogSize;
        _logQueue = dispatch_queue_create("com.log.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark 日志打印函数

/**
 * 打印proto级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)protocol:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logInfo = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self writeLog:LOG_LEVEL_PROTO logInfo:logInfo];
}

/**
 * 打印debug级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)debug:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logInfo = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self writeLog:LOG_LEVEL_DEBUG logInfo:logInfo];
}

/**
 * 打印info级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)info:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logInfo = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self writeLog:LOG_LEVEL_INFO logInfo:logInfo];
}

/**
 * 打印warning级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)warn:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logInfo = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self writeLog:LOG_LEVEL_WARN logInfo:logInfo];
}

/**
 * 打印error级别的日志
 * @param format 日志格式化串
 * @param ... 格式化数据
 */
- (void)error:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logInfo = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self writeLog:LOG_LEVEL_ERROR logInfo:logInfo];
}

/**
 * 打印日志
 * @param logLevel 日志级别
 * @param format 日志格式化串
 * @param args 格式化数据
 */
- (void)writeLog:(int)logLevel logInfo:(NSString *)logInfo {
    
    // 如果日志级别不够,不要打印日志了
    if (_logLevel > logLevel) return;
    
    // 在日志打印队列中处理日志打印
    dispatch_async(_logQueue, ^{
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        // 如果文件不存在，创建文件
        if (![fileMgr fileExistsAtPath:_logFileName]) {
            [fileMgr createFileAtPath:_logFileName contents:nil attributes:nil];
        }
        
        // 获取文件大小
        NSDictionary *fileAttributes = [fileMgr attributesOfItemAtPath:_logFileName error:nil];
        unsigned long long fileSize = [fileAttributes fileSize];
        
        if (fileSize >= _maxLogSize) {
            NSString *newFileName = [NSString stringWithFormat:@"%@.1", _logFileName];
            if ([fileMgr fileExistsAtPath:newFileName]) {
                [fileMgr removeItemAtPath:newFileName error:nil];
            }
            // 文件更名
            [fileMgr moveItemAtPath:_logFileName toPath:newFileName error:nil];
            // 重新创建新文件
            [fileMgr createFileAtPath:_logFileName contents:nil attributes:nil];
        }
        
        // 格式化日志
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        
        NSString* formatInfo = [NSString stringWithFormat:@"[%@]<%@> %@\n", [formatter stringFromDate:now], [Logger getLogLevelName:logLevel], logInfo];
        
        // 写入文件
        NSFileHandle *fileHdr = [NSFileHandle fileHandleForWritingAtPath:_logFileName];
        [fileHdr seekToEndOfFile];
        [fileHdr writeData:[formatInfo dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHdr closeFile];
        
//#if DEVELOP
        if (_logLevel <= LOG_LEVEL_DEBUG) {
            NSLog(@"%@: %@", [Logger getLogLevelName:logLevel], logInfo);
        }
//#endif
    });
}

#pragma mark 辅助函数

/**
 * 返回指定日志级别的级别描述
 */
+ (NSString *)getLogLevelName:(int)logLevel {
    switch(logLevel) {
        case LOG_LEVEL_DEBUG:
            return @"DEBUG";
        case LOG_LEVEL_PROTO:
            return @"PROTOCOL";
        case LOG_LEVEL_INFO:
            return @"INFO";
        case LOG_LEVEL_WARN:
            return @"WARNING";
        case LOG_LEVEL_ERROR:
            return @"ERROR";
        default:
            return @"N/A";
    }
}

/**
 * 返回指定日志级别
 * @param levelName 日志级别名
 * @return 返回日志级别名对应的日志级别
 */
+ (int) getLogLevel:(NSString *)levelName defLevel:(int)defLevel {
    if (levelName == nil) return defLevel;
    
    if ([@"DEBUG" isEqualToString:levelName]) return LOG_LEVEL_DEBUG;
    if ([@"PROTOCOL" isEqualToString:levelName]) return LOG_LEVEL_PROTO;
    if ([@"INFO" isEqualToString:levelName]) return LOG_LEVEL_INFO;
    if ([@"WARN" isEqualToString:levelName]) return LOG_LEVEL_WARN;
    if ([@"ERROR" isEqualToString:levelName]) return LOG_LEVEL_ERROR;
    return defLevel;
}

@end
