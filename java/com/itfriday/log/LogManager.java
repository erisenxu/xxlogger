/*
 * @(#) LogManager.h Created on 2016-01-16
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

/**
 * Created by erisenxu on 16/1/19.
 */
public class LogManager {

    /**
     * The LogManager instance
     */
    protected final static LogManager instance = new LogManager();

    /**
     * 日志打印对象
     */
    private Logger mLogger = null;

    /**
     * Constructs a new LogManager
     */
    private LogManager() {
    }

    /**
     * Gets the instance of the LogManager
     * @return Returns the instance of the LogManager
     */
    public static LogManager getInstance() {
        return instance;
    }

    /**
     * 初始化日志,必须调用这个
     */
    public void initLogger(String logFileName, int logLevel, int maxLogSize) {
        mLogger = new Logger(logFileName, logLevel, maxLogSize);
    }

    /**
     * 获取日志打印对象
     * @return 返回日志打印对象
     */
    public Logger getLogger() {
        return mLogger;
    }
}
