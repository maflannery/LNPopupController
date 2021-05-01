//
//  LNFlatView.m
//  
//
//  Created by Maurice Flannery on 5/1/21.
//

#import "LNFlatView.h"

static const CGFloat _LNFlatDefaultWidth = 4.67;

IB_DESIGNABLE
@interface LNFlatView (Inspectable)

@property (nonatomic, strong, null_resettable) IBInspectable UIColor* color;
@property (nonatomic, assign) IBInspectable CGFloat width;

@end

@implementation LNFlatView
{
    UIView* _leftView;
    UIView* _rightView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self _commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self _commonInit];
    return self;
}

- (void)_commonInit
{
    [self setTintColor:nil];
    self.width = _LNFlatDefaultWidth;
    
    self.userInteractionEnabled = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_leftView == nil)
    {
        _leftView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftView.backgroundColor = self.tintColor;
        _rightView = [[UIView alloc] initWithFrame:CGRectZero];
        _rightView.backgroundColor = self.tintColor;
        
        [self addSubview:_leftView];
        [self addSubview:_rightView];
    }
    
    CGRect leftFrame, rightFrame;
    CGRectDivide(self.bounds, &leftFrame, &rightFrame, self.bounds.size.width * 0.5, CGRectMinXEdge);
    rightFrame.size.height = leftFrame.size.height = self.width;
        
    leftFrame = CGRectOffset(leftFrame, self.width / 2 - 0.75, 0.0);
    rightFrame = CGRectOffset(rightFrame, -(self.width / 2) + 0.75, 0.0);
    
    _leftView.bounds = leftFrame;
    _rightView.bounds = rightFrame;
    _leftView.center = CGPointMake(CGRectGetMidX(leftFrame), CGRectGetMidY(self.bounds));
    _rightView.center = CGPointMake(CGRectGetMidX(rightFrame), CGRectGetMidY(self.bounds));
    
    _leftView.layer.cornerRadius = self.width / 2.0;
    _rightView.layer.cornerRadius = self.width / 2.0;
}

- (void)tintColorDidChange
{
    _leftView.backgroundColor = self.tintColor;
    _rightView.backgroundColor = self.tintColor;
}

- (void)setWidth:(CGFloat)width
{
    _width = width;
    
    [self setNeedsLayout];
}

#if TARGET_INTERFACE_BUILDER
- (void)prepareForInterfaceBuilder
{
    
}
#endif

@end
