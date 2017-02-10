//
//  NSString+BSExt.m
//  BSCycleTextViewSample
//
//  Created by 张亚东 on 16/5/24.
//  Copyright © 2016年 blurryssky. All rights reserved.
//

#import "NSString+BSExt.h"

@implementation NSString (BSExt)

- (CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize {
    CGSize size;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes = @{ NSFontAttributeName: font };
    CGRect bounds = [self boundingRectWithSize:constraintSize options:options attributes:attributes context:nil];
    size = bounds.size;
#else
    size = [self sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByCharWrapping];
#endif
    return size;
}

@end
