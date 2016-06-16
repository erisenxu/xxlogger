/*
 * @(#) ErrorCode.h Created on 2014-03-27
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
 
#ifndef ERROR_CODE_H
#define ERROR_CODE_H

/* 普通错误码-1~-1000 */
#define ERROR_INPUT_PARAM_NULL                      -1      /* 输入参数不合法，为NULL */
#define ERROR_ARRAY_LEN_NOT_ENOUGH                  -2      /* 数组长度不够 */
#define ERROR_GET_CURRENT_PATH                      -3      /* 取当前目录时，发生错误 */
#define ERROR_FILE_OPEN_FAILURE                     -4      /* 打开文件时，发生错误 */
#define ERROR_FILE_TOKEN_FAILURE                    -5      /* 获取文件的token信息失败(调用ftok失败) */
#define ERROR_FILE_RENAME_FAILURE                   -6      /* 文件更名失败 */
#define ERROR_FILE_STAT_FAILURE                     -7      /* 获取文件信息失败 */
#define ERROR_PATH_NAME_TOO_LONG                    -8      /* 路径名太长 */
#define ERROR_PATH_CREATE_FAILURE                   -9      /* 创建路径失败 */
#define ERROR_MEM_LEN_NOT_ENOUGH                    -10     /* 内存长度不够 */

/* 日志处理错误码段-1601~-1700 */
#define ERROR_LOG_MAX_SIZE_INVALID                  -1601   /* 日志最大文件长度不正确 */
#define ERROR_LOG_MAX_FILE_NUM_INVALID              -1602   /* 日志最大文件数量不正确 */
#define ERROR_LOG_OPEN_FILE_FAILURE                 -1603   /* 打开日志文件出错 */
#define ERROR_LOG_NO_INIT                           -1604   /* 日志对象未初始化 */

#endif
