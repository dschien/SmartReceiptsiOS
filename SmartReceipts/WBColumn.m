//
//  WBColumn.m
//  SmartReceipts
//
//  Created on 15/03/14.
//  Copyright (c) 2014 Will Baumann. All rights reserved.
//

#import "WBColumn.h"

// store original NS/LocalizedString, it's for case when you want to use localization after column names definitions
//static NSString* proxy_NS/LocalizedString(NSString* key, NSString* comment)
//{
//    return NS/LocalizedString(key, comment);
//}

// make fake NS/LocalizedString just for genstrings for easier localization
/* it's make this way because we have to use strings consts that serve as IDs and names for english locale in the same time */
#undef NSLocalizedString
#define NSLocalizedString(str, ...) (str)

NSString * const WBColumnNameBlank = NSLocalizedString(             @"Blank Column", nil);
NSString * const WBColumnNameCategoryCode = NSLocalizedString(      @"Category Code", nil);
NSString * const WBColumnNameCategoryName = NSLocalizedString(      @"Category Name", nil);
NSString * const WBColumnNameUserId = NSLocalizedString(            @"User ID", nil);
NSString * const WBColumnNameReportName = NSLocalizedString(        @"Report Name", nil);
NSString * const WBColumnNameReportStartDate = NSLocalizedString(   @"Report Start Date", nil);
NSString * const WBColumnNameReportEndDate = NSLocalizedString(     @"Report End Date", nil);
NSString * const WBColumnNameImageFileName = NSLocalizedString(     @"Image Name", nil);
NSString * const WBColumnNameImagePath = NSLocalizedString(         @"Image Path", nil);
NSString * const WBColumnNameComment = NSLocalizedString(           @"Comment", nil);
NSString * const WBColumnNameCurrency = NSLocalizedString(          @"Currency", nil);
NSString * const WBColumnNameDate = NSLocalizedString(              @"Date", nil);
NSString * const WBColumnNameName = NSLocalizedString(              @"Name", nil);
NSString * const WBColumnNamePrice = NSLocalizedString(             @"Price", nil);
NSString * const WBColumnNameTax = NSLocalizedString(               @"Tax", nil);
NSString * const WBColumnNamePictured = NSLocalizedString(          @"Pictured", nil);
NSString * const WBColumnNameExpensable = NSLocalizedString(        @"Expensable", nil);
NSString * const WBColumnNameIndex = NSLocalizedString(             @"Receipt Index", nil);
// Extras have to be filled to be active.
NSString * const WBColumnNameExtraEdittext1 = @"";
NSString * const WBColumnNameExtraEdittext2 = @"";
NSString * const WBColumnNameExtraEdittext3 = @"";

// restore NS/LocalizedString
//#undef NS/LocalizedString
//#define NS/LocalizedString(key, comment) (proxy_NS/LocalizedString(key,comment))

@interface WBColumn()
{
    int _index;
    NSString *_name;
}
@end

@implementation WBColumn

+ (NSArray*)availableColumnsNames
{
    NSMutableArray *arr = [@[
                             WBColumnNameBlank,
                             WBColumnNameCategoryCode,
                             WBColumnNameCategoryName,
                             WBColumnNameUserId,
                             WBColumnNameReportName,
                             WBColumnNameReportStartDate,
                             WBColumnNameReportEndDate,
                             WBColumnNameImageFileName,
                             WBColumnNameImagePath,
                             WBColumnNameComment,
                             WBColumnNameCurrency,
                             WBColumnNameDate,
                             WBColumnNameName,
                             WBColumnNamePrice,
                             WBColumnNameTax,
                             WBColumnNamePictured,
                             WBColumnNameExpensable,
                             WBColumnNameIndex,
                             ] mutableCopy];
    
    [arr sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSArray *optional = @[WBColumnNameExtraEdittext1,WBColumnNameExtraEdittext2,WBColumnNameExtraEdittext3];
    
    for (NSString* str in optional) {
        if (str.length > 0) {
            [arr addObject:str];
        }
    }
    
    return arr;
}

- (id)initWithIndex:(int) index name:(NSString*) columnName
{
    self = [super init];
    if (self) {
        _index = index;
        _name = columnName;
    }
    return self;
}

- (int) index
{
    return _index;
}

- (NSString*)name
{
    return _name;
}

@end
