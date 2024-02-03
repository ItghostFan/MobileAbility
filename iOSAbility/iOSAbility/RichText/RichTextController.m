//
//  RichTextController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/29.
//

#import "RichTextController.h"

#import <Masonry/Masonry.h>

#import "RichTextView.h"

@interface RichTextController ()

@property (weak, nonatomic) UILabel *richTextLabel;
@property (weak, nonatomic) RichTextView *richTextView;

@end

@implementation RichTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    NSMutableAttributedString *text = NSMutableAttributedString.new;
    
    // 文本
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"这是一个富文本例子！" attributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName: UIColor.blueColor
    }]];
    
    // 图片
//    NSTextAttachment *attachment = NSTextAttachment.new;
//    attachment.image = [UIImage imageNamed:@"natura"];
//    attachment.bounds = CGRectMake(0.0f, 0.0f, 90.0f, 45.0f);
//    [text appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
//    NSString *url = @"https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=NSlayoutmanager%20numberOfGlyphs%20%E5%B4%A9%E6%BA%83&fenlei=256&rsv_pq=0xef039a2d006ba7ae&rsv_t=2b457ljgBJO0tucQIn0ISXlLtb%2FVDar%2Fhvle6MUd7gYYSCvTYaxK%2B1sG6CQ&rqlang=en&rsv_enter=1&rsv_dl=tb&rsv_sug3=28&rsv_sug1=1&rsv_sug7=100&rsv_sug2=0&rsv_btype=i&inputT=13818&rsv_sug4=13819";
//    [text appendAttributedString:[[NSAttributedString alloc] initWithString:url attributes:@{
//        NSFontAttributeName: self.richTextLabel.font,
//        NSForegroundColorAttributeName: UIColor.blueColor
//    }]];
    
    self.richTextLabel.attributedText = text;
    self.richTextLabel.numberOfLines = 0;
    self.richTextLabel.textAlignment = NSTextAlignmentCenter;
    self.richTextView.attributedText = text;
    self.richTextView.font = self.richTextLabel.font;
    self.richTextView.textAlignment = NSTextAlignmentCenter;
    self.richTextView.text = @"这是一个富文本例子！";
    CGSize size = [self.richTextView intrinsicContentSize];
    size = [self.richTextView sizeThatFits:CGSizeMake(100.0f, 0.0f)];
}

#pragma mark - Getter

- (UILabel *)richTextLabel {
    if (!_richTextLabel) {
        UILabel *richTextLabel = UILabel.new;
        _richTextLabel = richTextLabel;
        [self.view addSubview:_richTextLabel];
        [_richTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.height.mas_equalTo(100);
        }];
    }
    return _richTextLabel;
}

- (RichTextView *)richTextView {
    if (!_richTextView) {
        RichTextView *richTextView = RichTextView.new;
        _richTextView = richTextView;
        [self.view addSubview:_richTextView];
        [_richTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.richTextLabel.mas_bottom);
            make.leading.trailing.equalTo(self.view);
            make.height.equalTo(self.richTextLabel);
        }];
    }
    return _richTextView;
}

@end
