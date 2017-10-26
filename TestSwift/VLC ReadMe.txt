
/**************************************************************/


 由于github限制大于100M文件上传，VLC测试模块的Framework被移除了，运行可能报错。



 =》如何运行 VLC Demo，请做下面几步：
    1、右键 Show in finder，找到VLC播放器.rar解压文件，解压后再添加到项目里。
    2、在TestSwift-Bridging-Header桥接文件里，放开注释：#import <DynamicMobileVLCKit/VLCMediaPlayer.h>
    3、下载MobileVLCKit的framework包，并添加到项目（方法参考博客截图），以及在 General->Embedded Binaries 里add一下。
    4、如果项目的依赖库没有添加，记得添加下
    5、到ViewController.swift文件，199行，放开cell的点击跳转代码。

    VLC如何使用教程博客～～～：
    http://www.cnblogs.com/yajunLi/p/7728952.html




/**************************************************************/
