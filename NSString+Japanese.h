//
//  NSString+JapaneseExtras.m
//
//  Created by Grace Steven on 3/26/11.
//  Copyright 2011 works5.com All rights reserved.
//

#import <Foundation/Foundation.h>


/*
* Text Type
*/
typedef enum{
    SLGJapaneseStringTypeHiragana,
    SLGJapaneseStringTypeKatakana,
    SLGJapaneseStringTypeKanji,
    SLGJapaneseStringTypeCompound,
    SLGJapaneseStringTypeOther,    
}SLGJapaneseStringType;


@interface NSString (NSString_Japanese)


// returns the type of text contained in the string (mixed or just hiragana / katakan / kanji etc)
+(SLGJapaneseStringType)japaneseStringTypeForString:(NSString*)string;

// checks if any of the chars in the string are katakana or hiragana or kanij
+(BOOL)stringContainsJapaneseText:(NSString*)aString;


// transliteration


-(NSString*)stringByTransliteratingJapaneseToRomajiWithWordSeperator:(NSString*)separator;
// calls stringByTransliteratingJapaneseToRomajiWithWordSeperator: with 'nil'
-(NSString*)stringByTransliteratingJapaneseToRomaji;

-(NSString*)stringByTransliteratingJapaneseToHiragana;

-(NSString*)stringByTransliteratingRomajiToKatakana;
-(NSString*)stringByTransliteratingRomajiToHiragana;


// Kanji
-(NSString*)stringByReplacingJapaneseKanjiWithHiragana;



// very RUDIMENTARY 'sounds like' comparison of two japanese strings
// compares the the reciever to the passed string
// returns a 'score' from 0 to 1 (1 being the most similar to the reciever)
-(CGFloat)phoneticSimilarityToString:(NSString*)targetString;

// pass YES to improve performance by skipping transliteraion
// the reciever and the passed string should already be converted to latinScript
-(CGFloat)phoneticSimilarityToString:(NSString*)string isLatinScript:(BOOL)isLatinScript;

 

@end
