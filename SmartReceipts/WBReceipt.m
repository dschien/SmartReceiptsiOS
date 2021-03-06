//
//  WBReceipt.m
//  SmartReceipts
//
//  Created on 18/03/14.
//  Copyright (c) 2014 Will Baumann. All rights reserved.
//

#import "WBReceipt.h"
#import "WBTrip.h"
#import "WBCurrency.h"

static NSString * const NO_DATA = @"null";

static NSString* checkNoData(NSString* str) {
    if ([NO_DATA caseInsensitiveCompare:str] == NSOrderedSame) {
        return nil;
    }
    return str;
}

@implementation WBReceipt
{
    int _id;
    NSString *_fileName;
    NSString *_name, *_category, *_comment;
    NSDecimalNumber *_price, *_tax;
    NSString *_extraEditText1, *_extraEditText2, *_extraEditText3;
    long long _dateMs;
    NSTimeZone *_timeZone;
    BOOL _isExpensable, _isFullPage;
    WBCurrency *_currency;
}

+(NSString*) NO_DATA {
    return NO_DATA;
}

- (id)initWithId:(int) rid
            name:(NSString*)name
        category:(NSString*)category
   imageFileName:(NSString*)imageFileName
          dateMs:(long long)dateMs
    timeZoneName:(NSString*)timeZoneName
         comment:(NSString*)comment
           price:(NSDecimalNumber*)price
             tax:(NSDecimalNumber*)tax
    currencyCode:(NSString*)currencyCode
    isExpensable:(BOOL)isExpensable
      isFullPage:(BOOL)isFullPage
  extraEditText1:(NSString*)extraEditText1
  extraEditText2:(NSString*)extraEditText2
  extraEditText3:(NSString*)extraEditText3
{
    self = [super init];
    if (self) {
        _id = rid;
        _name = [name lastPathComponent];
        _category = category;
        _fileName = checkNoData([imageFileName lastPathComponent]);
        
        // _date = [NSDate dateWithTimeIntervalSince1970:(dateMs/1000)];
        // NSDate store seconds so we have to store just milliseconds
        _dateMs = dateMs;
        
        _timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
        if (!_timeZone) {
            _timeZone = [NSTimeZone localTimeZone];
        }
        
        _comment = comment;
        _price = price;
        _tax = tax;
        
        _currency = [WBCurrency currencyForCode:currencyCode];
        
        _isExpensable = isExpensable;
        _isFullPage = isFullPage;
        _extraEditText1 = checkNoData(extraEditText1);
        _extraEditText2 = checkNoData(extraEditText2);
        _extraEditText3 = checkNoData(extraEditText3);
    }
    return self;
}

-(int)receiptId {
    return _id;
}

-(NSString*)imageFileName {
    return _fileName;
}

- (long long) dateMs {
    return _dateMs;
}

-(NSTimeZone*)timeZone {
    if (_timeZone) {
        return _timeZone;
    }
    return [NSTimeZone localTimeZone];
}

-(NSString*)name {
    return _name;
}

-(NSString*)category {
    return _category;
}

-(NSString*)comment {
    return _comment;
}

-(NSString*)price_as_string {
    NSString* price = [NSString stringWithFormat:@"%@", _price];
    return price;
}

-(NSString*)tax_as_string {
    NSString* tax = [NSString stringWithFormat:@"%@", _tax];
    return tax;
}

-(NSDecimalNumber*)price_as_nsdecnum {
    return _price;
}

-(NSDecimalNumber*)tax_as_nsdecnum{
    return _tax;
}

-(WBCurrency*)currency {
    return _currency;
}

-(BOOL)isExpensable {
    return _isExpensable;
}

-(BOOL)isFullPage {
    return _isFullPage;
}

-(NSString*)extraEditText1 {
    return _extraEditText1;
}

-(NSString*)extraEditText2 {
    return _extraEditText2;
}

-(NSString*)extraEditText3 {
    return _extraEditText3;
}

-(NSDate*) dateFromDateMs {
    return [NSDate dateWithTimeIntervalSince1970:(_dateMs/1000)];
}

-(void)setImageFileName:(NSString*)imageFileName{
    _fileName = [imageFileName lastPathComponent];
}

-(NSString*)imageFilePathForTrip:(WBTrip*)trip {
    if (!_fileName) {
        return nil;
    }
    return [[trip directoryPath] stringByAppendingPathComponent:_fileName];
}

-(BOOL)hasFileForTrip:(WBTrip*)trip{
    return _fileName && ([[NSFileManager defaultManager] fileExistsAtPath:[self imageFilePathForTrip:trip]]);
}

-(BOOL)fileHasExtension:(NSArray*) possibleExtensions {
    NSString* ext = [_fileName pathExtension];
    for (NSString* pe in possibleExtensions) {
        if ([pe caseInsensitiveCompare:ext]==NSOrderedSame) {
            return true;
        }
    }
    return false;
}

-(BOOL)hasImageForTrip:(WBTrip*)trip {
    return [self hasFileForTrip:trip] && [self hasImageFileName];
}

-(BOOL)hasPDFForTrip:(WBTrip*)trip {
    return [self hasFileForTrip:trip] && [self hasPDFFileName];
}

-(BOOL)hasImageFileName {
    return [self fileHasExtension:@[@"jpg",@"jpeg",@"png"]];
}

-(BOOL)hasPDFFileName {
    return [self fileHasExtension:@[@"pdf"]];
}

-(void)setDateMs:(long long) dateMs {
    self->_dateMs = dateMs;
}

-(NSString*)priceWithCurrencyFormatted {
    NSString *string_price = [NSString stringWithFormat:@"%@", _price];
    return [self formattedMoneyString:string_price];
}

-(NSString*)taxWithCurrencyFormatted {
    NSString *string_tax = [NSString stringWithFormat:@"%@", _tax];
    return [self formattedMoneyString:string_tax];
}

-(NSString*)formattedMoneyString:(NSString*) moneyString {
    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_currencyFormatter setCurrencyCode:[[self currency] code]];
    return [_currencyFormatter stringFromNumber:[NSNumber numberWithDouble:[moneyString doubleValue]]];
}

-(BOOL)hasExtraEditText1 {
    return _extraEditText1 != nil;
}

-(BOOL)hasExtraEditText2 {
    return _extraEditText2 != nil;
}

-(BOOL)hasExtraEditText3 {
    return _extraEditText3 != nil;
}

@end
