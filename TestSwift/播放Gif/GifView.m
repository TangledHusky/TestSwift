//
//  GifView.m
//  播放gif图片
//
//  Created by wangguoliang on 15/9/11.
//  Copyright (c) 2015年 wangguoliang. All rights reserved.
//

#import "GifView.h"

@implementation GifView

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)filePath
{
    if (self == [super initWithFrame:frame]) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:filePath], (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.12f target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame data:(NSData *)data
{
    if (self == [super initWithFrame:frame]) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithData((CFDataRef)data, (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.12f target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}
- (void)play
{
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

- (void)dealloc
{
    CFRelease(gif);
}

- (void)stopGif
{
    [timer invalidate];
    timer = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
