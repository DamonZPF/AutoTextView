//
//  AutoTextView.m
//  AutoTextView
//
//  Created by ZHOUPENGFEI on 16/8/4.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "AutoTextView.h"

@interface AutoTextView()

@property(nonatomic,assign)CGFloat textH;
@property(nonatomic,assign)CGFloat maxH;

@end


@implementation AutoTextView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
      [self setup];
}

-(void)setup{
    self.placeholderColor = [UIColor lightGrayColor];
    self.placeholder = @"fasdfasdf";
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollsToTop = NO;
    self.scrollEnabled = NO;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setCornerRadius:(NSUInteger)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}
-(void)setMaxLine:(NSInteger)maxLine{
    _maxLine = maxLine;
    //限制最大高度
    self.maxH = self.font.lineHeight * maxLine + self.textContainerInset.top + self.textContainerInset.bottom;

}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

-(void)textDidChange{
    [self setNeedsDisplay];
    CGFloat heigth =  [self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height;
    if (self.textH != heigth){
        self.scrollEnabled = (heigth > self.maxH && self.maxH >0);
        if (self.textViewChangeBlock && self.scrollEnabled == NO){
            self.textH = heigth;
            self.textViewChangeBlock(self.text,heigth);
            [self.superview layoutIfNeeded];
        }
    }
}


-(void)drawRect:(CGRect)rect{

    if (self.hasText){
        return;
    }
    CGFloat x = 8;
    CGFloat y = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.width - 2*y;
    [self.placeholder drawInRect:CGRectMake(x, y, w, h) withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.placeholderColor}];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
