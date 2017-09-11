//
//  LDSearchBar.h
//  LDSearchController
//
//  Created by WeTime on 2017/9/5.
//  Copyright © 2017年 WeTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDSearchBar : UISearchBar

// set text left image
@property (nonatomic, strong) UIImage *leftImage;
// set TextField Background Color
@property (nonatomic, strong)UIColor *inputBackgroundColor;
// set placeholder color
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *placeHolderFont;
@property (nonatomic, strong) UIFont *textFont;

// default is YES，if NO，aliment Left
@property (nonatomic, assign) BOOL hasCentredPlaceholder;
// default is NO, hide text clear button
@property (nonatomic, assign) BOOL isHideClearButton;

- (instancetype)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage placeholderColor:(UIColor *)placeholderColor;

@end
