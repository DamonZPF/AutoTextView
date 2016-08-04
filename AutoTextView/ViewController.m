//
//  ViewController.m
//  AutoTextView
//
//  Created by ZHOUPENGFEI on 16/8/4.
//  Copyright © 2016年 ZPF. All rights reserved.
//

#import "ViewController.h"
#import "AutoTextView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightCons;

@property (weak, nonatomic) IBOutlet AutoTextView *textView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];

    self.textView.placeholderColor = [UIColor redColor];
    self.textView.placeholder = @"请输入文字";
    self.textView.textViewChangeBlock = ^(NSString * text,CGFloat heigth){
        _bottomHeightCons.constant = heigth+10;
    };
    self.textView.maxLine = 5;
  
    
}

-(void)keyboardDidChange:(NSNotification*)note{

    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardDidChangeFrameNotification] floatValue];

    self.bottomCons.constant = self.bottomCons.constant == 0 ? keyboardFrame.size.height : 0;

    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];

}


@end
