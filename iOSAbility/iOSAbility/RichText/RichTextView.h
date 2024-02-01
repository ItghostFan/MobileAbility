//
//  RichTextView.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichTextView : UIView

@property (strong, nonatomic) NSAttributedString *attributedText;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) NSInteger numberOfLines;
@property (assign, nonatomic) NSLineBreakMode lineBreakMode;
@property (assign, nonatomic) NSTextAlignment textAlignment;

@end

NS_ASSUME_NONNULL_END
