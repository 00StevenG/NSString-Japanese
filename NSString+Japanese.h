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

// convenience function to get the the predictive Inputs results (via UITExtChecker) for the passed string
+(NSArray*)possibleJapaneseCompletionsForString:(NSString*)aString;



// transliteration
-(NSString*)stringByTransliteratingJapaneseToRomajiWithWordSeperator:(NSString*)separator;

// calls stringByTransliteratingJapaneseToRomajiWithWordSeperator: with 'nil'
-(NSString*)stringByTransliteratingJapaneseToRomaji;


-(NSString*)stringByTransliteratingJapaneseToHiragana;

-(NSString*)stringByTransliteratingRomajiToKatakana;
-(NSString*)stringByTransliteratingRomajiToHiragana;






@end
