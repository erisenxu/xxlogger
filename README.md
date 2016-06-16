xxlogger
=============

xxlogger是日志打印工具类，提供对java, object-c, c的支持。xxlogger中的xx指某种语言<p>
其中：<p>
&nbsp;&nbsp;&nbsp;&nbsp;c目录下的是c语言的实现<p>
&nbsp;&nbsp;&nbsp;&nbsp;oc目录下的是object-c语言的实现<p>
&nbsp;&nbsp;&nbsp;&nbsp;java目录下的是java语言的实现<p>
<p>
主要功能包括：<p>
1. 将日志输出到指定文件<p>
2. 可指定日志文件的最大大小<p>
3. 日志文件大小超过最大大小，会自动备份原日志文件<p>
4. 日志分不同的级别，可配置最小级别，级别高于或等于最小级别的才会打印<p>

为什么会有xxlogger
=============
因为想要一个简单的实现。无论是代码、还是使用，都要简单。大名鼎鼎的log4xx，虽然功能强大，但是太复杂了，配置也复杂，不利于维护，一般的应用根本用不到它的一些特性<p>
所以，如果您和我一样，想要一个简单、干净、纯粹的代码，那么xxlogger会是一个不错的选择。<p>

如何使用xxlogger
=============
xxlogger的使用非常简单，您只需要在主程序中，调用initLogger进行一次初始化，在其他地方就可以使用了。<p>

建议：<p>
1. c语言的实现，是基于linux的，最好用于服务器的开发。它是非线程安全的，适合无锁编程。一般高性能的服务器都是单进程单线程的，资源的使用不需要加锁。所以它的应用场景比较适合单进程单线程的服务器开发。如果您的程序采用多线程，您可以修改代码自己加锁。<p>
2. object-c和java的实现，是线程安全的，可以用于多线程的应用。其中object-c的实现，是在一个独立的线程中输出日志，比较适合移动应用开发场景。<p>
