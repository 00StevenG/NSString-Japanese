//
//  SLGViewController.m
//  NSString-Japanese
//
//  Created by Steven Grace on 4/19/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "SLGViewController.h"
#import "NSString+Japanese.h"

@interface SLGViewController ()<UITextViewDelegate>

@end

@implementation SLGViewController

#pragma mark - Rotation
-(BOOL)shouldAutorotate{
    return NO;
}
#pragma mark - View Lifecycle
//
//
//
- (void)viewDidLoad
{
    self.textView.editable = NO;
    self.textView.delegate = self;
    
    
    [super viewDidLoad];
    
    NSString *jaText = @"主人公、「フーテンの寅」こと車寅次郎は、父親、車平造が芸者、菊との間に作った子供。実母の出奔後父親のもとに引き取られたが、16歳の時に父親と大ゲンカをして家を飛び出したという設定。第1作は、テキ屋稼業で日本全国を渡り歩く渡世人となった寅次郎が家出から20年後突然、倍賞千恵子演じる異母妹さくらと叔父夫婦が住む、生まれ故郷の東京都葛飾区柴又・柴又帝釈天の門前にある草団子屋に戻ってくるところから始まる。";
    
    self.textView.text = jaText;
    
    self.outputLabel.text = [jaText stringByReplacingJapaneseKanjiWithHiragana];
   
}
//
//
//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TextViewDelegate
//
//
//
- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    NSRange range = _textView.selectedRange;
    if(range.length==0){
        self.selectedTextLabel.text = @"";
        self.outputLabel.text = @"";
        return;
    }
    
    NSString* selectedString = [_textView.text substringWithRange:range];
    

    switch ([self.segementedControl selectedSegmentIndex]) {
        case 0:
            self.outputLabel.text = [selectedString stringByTransliteratingJapaneseToRomajiWithWordSeperator:@" "]; 
            break;
        case 1:
            self.outputLabel.text = [selectedString stringByReplacingJapaneseKanjiWithHiragana];
            break;
        default:{
            [NSException raise:NSInternalInconsistencyException
                        format:@"Unhandled case in %s",__PRETTY_FUNCTION__];
        }
            break;
    }
    
    
    SLGJapaneseStringType type = [NSString japaneseStringTypeForString:selectedString];
    
    switch (type) {
        case SLGJapaneseStringTypeHiragana:
            self.selectedTextLabel.text = @"Hiragana";
            break;
        case SLGJapaneseStringTypeKanji:
            self.selectedTextLabel.text = @"Kanji";
            break;
        case SLGJapaneseStringTypeKatakana:
            self.selectedTextLabel.text = @"Katakana";
            break;
        case SLGJapaneseStringTypeCompound:
            self.selectedTextLabel.text = @"Compound";
            break;
        case SLGJapaneseStringTypeOther:
            self.selectedTextLabel.text = @"Other";
            break;
            
        default:{
            [NSException raise:NSGenericException
                        format:@"Unhandled case in :%s",__PRETTY_FUNCTION__];
        }
            break;
    }
    
}



@end
