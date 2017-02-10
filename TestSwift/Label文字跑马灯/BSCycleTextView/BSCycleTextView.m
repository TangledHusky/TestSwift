//
//  BSCycleTextView.m
//  CarBracket
//
//  Created by 张亚东 on 15/12/18.
//  Copyright © 2015年 blurryssky. All rights reserved.
//

#import "BSCycleTextView.h"
#import "NSString+BSExt.h"

static const CGFloat GradientWidth = 25;
static const CGFloat Spacing = 20;
static const CGFloat Velocity = 50;
static const NSTimeInterval TimeInterval = 4;
static const CGFloat FontSize = 26;

@interface BSCycleTextView ()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) UIView *animationView;
@property (strong, nonatomic) UILabel *primaryLabel;
@property (strong, nonatomic) UILabel *secondaryLabel;
@property (strong, nonatomic) CABasicAnimation *positionXAnimation;
@property (strong, nonatomic) CAAnimationGroup *delaypositionXAnimationGroup;

@end

@implementation BSCycleTextView

#pragma mark - Override

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
    self.animationView.frame = CGRectMake(self.gradientWidth,
                                          0,
                                          self.bounds.size.width - self.gradientWidth * 2,
                                          self.bounds.size.height);
    [self displayIfNeeded];
}

#pragma mark - Private

- (void)setup {
    [self setupVars];
    [self setupView];
    [self setupSubviews];
}

- (void)setupVars {
    self.gradientWidth = GradientWidth;
    self.spacing = Spacing;
    self.velocity = Velocity;
    self.timeInterval = TimeInterval;
    self.font = [UIFont systemFontOfSize:FontSize];
    self.textColor = [UIColor whiteColor];
}

- (void)setupView {
    self.clipsToBounds = YES;
    self.layer.mask = self.gradientLayer;
    self.backgroundColor = [UIColor blackColor];
}

- (void)setupSubviews {
    [self addSubview:self.animationView];
    [self.animationView addSubview:self.primaryLabel];
    [self.animationView addSubview:self.secondaryLabel];
}

- (void)displayIfNeeded {
    if (self.text == nil || self.text.length == 0) {
        return;
    }
    
    [self.animationView.layer removeAllAnimations];
    
    self.primaryLabel.text = self.text;
    self.secondaryLabel.text = self.text;
    
    CGSize size = [self.text sizeWithFont:self.font constraintSize:CGSizeMake(CGFLOAT_MAX, 0)];
    CGFloat targetWidth = 0;
    if (size.width + 5 > self.animationView.bounds.size.width) {
        targetWidth = size.width + self.spacing;
        
        self.primaryLabel.textAlignment = NSTextAlignmentLeft;
        self.secondaryLabel.hidden = NO;
        
        NSTimeInterval playDuration = targetWidth/self.velocity;
        self.positionXAnimation.duration = playDuration;
        self.positionXAnimation.toValue = @(-targetWidth + self.bounds.size.width/2);
        self.delaypositionXAnimationGroup.duration = playDuration + self.timeInterval;
        [self.animationView.layer addAnimation:self.delaypositionXAnimationGroup forKey:@"group"];
    }
    else {
        targetWidth = self.animationView.bounds.size.width;
        
        self.primaryLabel.textAlignment = NSTextAlignmentCenter;
        self.secondaryLabel.hidden = YES;
    }
    self.primaryLabel.frame = CGRectMake(0, 0, targetWidth, self.bounds.size.height);
    self.secondaryLabel.frame = CGRectOffset(self.primaryLabel.frame, targetWidth, 0);
}

#pragma mark - Getter
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                              (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[UIColor clearColor].CGColor];
        _gradientLayer.locations  = @[@(0),
                                      @(self.gradientWidth/self.bounds.size.width),
                                      @(1 - self.gradientWidth/self.bounds.size.width),
                                      @(1)];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint   = CGPointMake(1, 0);
    }
    return _gradientLayer;
}

- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [UIView new];
        _animationView.backgroundColor = [UIColor clearColor];
    }
    return _animationView;
}

- (UILabel *)primaryLabel {
    if (!_primaryLabel) {
        _primaryLabel = [UILabel new];
        _primaryLabel.font = self.font;
        _primaryLabel.textAlignment = NSTextAlignmentCenter;
        _primaryLabel.textColor = self.textColor;
    }
    return _primaryLabel;
}

- (UILabel *)secondaryLabel {
    if (!_secondaryLabel) {
        _secondaryLabel = [UILabel new];
        _secondaryLabel.font = self.font;
        _secondaryLabel.textAlignment = NSTextAlignmentLeft;
        _secondaryLabel.textColor = self.primaryLabel.textColor;
        _secondaryLabel.hidden = YES;
    }
    return _secondaryLabel;
}

- (CABasicAnimation *)positionXAnimation {
    if (!_positionXAnimation) {
        _positionXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        _positionXAnimation.beginTime = self.timeInterval;
        _positionXAnimation.fromValue = @(self.bounds.size.width/2);
    }
    return _positionXAnimation;
}

- (CAAnimationGroup *)delaypositionXAnimationGroup {
    if (!_delaypositionXAnimationGroup) {
        _delaypositionXAnimationGroup = [CAAnimationGroup animation];
        _delaypositionXAnimationGroup.animations = @[[CABasicAnimation new],self.positionXAnimation];
        _delaypositionXAnimationGroup.repeatCount = HUGE;
        _delaypositionXAnimationGroup.fillMode = kCAFillModeBackwards;
    }
    return _delaypositionXAnimationGroup;
}

@end
