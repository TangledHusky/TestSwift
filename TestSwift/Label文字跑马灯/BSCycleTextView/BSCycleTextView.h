//
//  BSCycleTextView.h
//  CarBracket
//
//  Created by 张亚东 on 15/12/18.
//  Copyright © 2015年 blurryssky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCycleTextView : UIView

///default is 25
@property (assign, nonatomic) CGFloat gradientWidth;

///default is 20
@property (assign, nonatomic) CGFloat spacing;

///default is 50
@property (assign, nonatomic) CGFloat velocity;

///default is 4
@property (assign, nonatomic) NSTimeInterval timeInterval;

///default is system font ,size 26
@property (strong, nonatomic) UIFont *font;

///default is [UIColor whiteColor]
@property (strong, nonatomic) UIColor *textColor;


@property (strong, nonatomic) NSString *text;

@end
