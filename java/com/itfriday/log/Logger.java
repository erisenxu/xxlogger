/*
 * @(#) Logger.h Created on 2016-01-16
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
package com.itfriday.log;

import android.util.Log;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class Logger {
    /**
     * 日志文件名,包含路径
     */
    private String mLogFileName;

    /**
     * 日志打印级别
     */
    private int mLogLevel;

    /**
     * 最大日志大小
     */
    private int mMaxLogSize;

    /**
     * 构造函数
     * @param logFileName 日志文件名,包含路径
     * @param logLevel 日志打印级别
     * @param maxLogSize 最大日志大小
     */
    public Logger(String logFileName, int logLevel, int maxLogSize) {
        this.mLogFileName = logFileName;
        this.mLogLevel = logLevel;
        this.mMaxLogSize = maxLogSize;
    }

    /**
     * 打印debug级别的日志
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    public void debug(String format, Object...args) {
        writeLog(LogLevel.LOG_LV_DEBUG, format, args);
    }

    /**
     * 打印协议级别的日志,一般用来打印协议码流
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    public void protocol(String format, Object...args) {
        writeLog(LogLevel.LOG_LV_PROTOCOL, format, args);
    }

    /**
     * 打印info级别的日志
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    public void info(String format, Object...args) {
        writeLog(LogLevel.LOG_LV_INFO, format, args);
    }

    /**
     * 打印警告级别的日志
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    public void warn(String format, Object...args) {
        writeLog(LogLevel.LOG_LV_WARN, format, args);
    }

    /**
     * 打印错误级别的日志
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    public void error(String format, Object...args) {
        writeLog(LogLevel.LOG_LV_ERROR, format, args);
    }

    /**
     * 打印严重错误级别的日志
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    public void fatal(String format, Object...args) {
        writeLog(LogLevel.LOG_LV_FATAL, format, args);
    }

    /**
     * 打印日志
     * @param logLevel 日志级别
     * @param format 日志格式化串
     * @param args 格式化数据
     */
    private void writeLog(int logLevel, String format, Object...args) {

        // 如果日志级别不够,不要打印日志了
        if (mLogLevel > logLevel) return;

        try {
            // 日志头
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SS", Locale.getDefault());
            String logInfo = String.format(format, args);
            String logDetailInfo = String.format("[%s]<%s> %s\n", sdf.format(new Date()), Logger.getLogLevelName(logLevel), logInfo);

            // 日志信息
            doWriteLog(logDetailInfo);
        } catch (Exception ex) {
            Log.e("Logger", "Fail to write log to file:" + ex.getMessage());
        }
    }

    /**
     * 讲日志打印到文件
     * @param logInfo 要打印的日志信息
     */
    private synchronized void doWriteLog(String logInfo) {
        FileWriter fw = null;

        // 如果发现文件超过大小,更名一下
        File logFile = new File(mLogFileName);
        if (logFile.length() >= mMaxLogSize) {
            logFile.renameTo(new File(mLogFileName + ".1"));
        }

        // 讲日志写到文件中
        try {
            fw = new FileWriter(mLogFileName, true);
            fw.write(logInfo);
            //fw.flush();
            // 测试环境下打印日志,正式环境要去掉
            //Log.e("Logger", logInfo);
        } catch (IOException ex) {
            Log.e("Logger", "Fail to write log:" + ex.getMessage());
        } finally {
            // 关闭文件
            if (fw != null) {
                try {
                    fw.close();
                } catch (IOException ex) {
                    Log.e("Logger", "Fail to close file writer:" + ex.getMessage());
                }
            }
        }
    }

    /**
     * 返回指定日志级别的级别描述
     */
    public static String getLogLevelName(int nLevel) {
        switch(nLevel) {
            case LogLevel.LOG_LV_DEBUG:
                return "DEBUG";
            case LogLevel.LOG_LV_PROTOCOL:
                return "PROTOCOL";
            case LogLevel.LOG_LV_INFO:
                return "INFO";
            case LogLevel.LOG_LV_WARN:
                return "WARNING";
            case LogLevel.LOG_LV_ERROR:
                return "ERROR";
            case LogLevel.LOG_LV_FATAL:
                return "FATAL ERROR";
            default:
                return "N/A";
        }
    }

    /**
     * 返回指定日志级别
     * @param levelName 日志级别名
     * @return 返回日志级别名对应的日志级别
     */
    public static int getLogLevel(String levelName, int defLevel) {
        if (levelName == null) return defLevel;
        if ("DEBUG".equals(levelName)) return LogLevel.LOG_LV_DEBUG;
        if ("PROTOCOL".equals(levelName)) return LogLevel.LOG_LV_PROTOCOL;
        if ("INFO".equals(levelName)) return LogLevel.LOG_LV_INFO;
        if ("WARN".equals(levelName)) return LogLevel.LOG_LV_WARN;
        if ("ERROR".equals(levelName)) return LogLevel.LOG_LV_ERROR;
        if ("FATAL".equals(levelName)) return LogLevel.LOG_LV_FATAL;
        return defLevel;
    }
}
