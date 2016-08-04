//
//  AutoTextView.h
//  AutoTextView
//
//  Created by ZHOUPENGFEI on 16/8/4.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoTextView : UITextView
@property(nonatomic,copy)NSString * placeholder;
@property(nonatomic,strong)UIColor * placeholderColor;
@property (nonatomic, assign) NSUInteger cornerRadius;
@property(nonatomic,assign)NSInteger maxLine;
@property(nonatomic,copy) void (^textViewChangeBlock)(NSString * text ,CGFloat height);
@end
