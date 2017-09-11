//
//  LDSearchBar.m
//  LDSearchController
//
//  Created by WeTime on 2017/9/5.
//  Copyright © 2017年 WeTime. All rights reserved.
//

#import "LDSearchBar.h"

@interface LDSearchBar()
@property (nonatomic, strong)UITextField *textField;
@end
@implementation LDSearchBar

- (instancetype)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage placeholderColor:(UIColor *)placeholderColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.hasCentredPlaceholder = YES;
        self.leftImage = leftImage;
        self.placeholderColor = placeholderColor;
    }
    return self;
}

#pragma mark - Methods
- (void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage;
    [self setImage:leftImage forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}
- (void)setInputBackgroundColor:(UIColor *)inputBackgroundColor{
    _inputBackgroundColor = inputBackgroundColor;
    self.textField.backgroundColor = inputBackgroundColor;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.textField.placeholder = placeholderColor;
}

- (void)setHasCentredPlaceholder:(BOOL)hasCentredPlaceholder {
    _hasCentredPlaceholder = hasCentredPlaceholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&_hasCentredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

-(void)setIsHideClearButton:(BOOL)isHideClearButton{
    _isHideClearButton = isHideClearButton;
    if (isHideClearButton) {
        [self.textField setClearButtonMode:UITextFieldViewModeNever];
    }
}
#pragma mark - Getter
- (UITextField *)textField{
    if (!_textField) {
        self.backgroundImage = [[UIImage alloc] init];
        self.barStyle = UIBarStyleBlack;
        _textField = [self valueForKey:@"_searchField"];
    }
    return _textField;
}


@end
