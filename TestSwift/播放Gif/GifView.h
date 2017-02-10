//
//  GifView.h
//  播放gif图片
//
//  Created by wangguoliang on 15/9/11.
//  Copyright (c) 2015年 wangguoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface GifView : UIView
{
    CGImageSourceRef gif;          // 保存gif动画
    NSDictionary *gifProperties;
    size_t index;
    size_t count;
    NSTimer *timer;
}
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)filePath;
- (id)initWithFrame:(CGRect)frame data:(NSData *)data;

- (void)stopGif;
@end
