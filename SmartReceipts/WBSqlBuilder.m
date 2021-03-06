//
//  WBSqlBuilder.m
//  SmartReceipts
//
//  Created on 29/03/14.
//  Copyright (c) 2014 Will Baumann. All rights reserved.
//

#import "WBSqlBuilder.h"

@implementation WBSqlBuilder

- (id)init
{
    self = [super init];
    if (self) {
        self.columns = [NSMutableArray array];
        self.values = [NSMutableArray array];
    }
    return self;
}

-(void) addColumn:(NSString*) columnName andObject:(NSObject*) valueObject {
    [_columns addObject:columnName];
    [self addValue:valueObject];
}

-(void) addColumn:(NSString*) columnName andInt:(int) valueInt {
    [_columns addObject:columnName];
    [self addValueFromInt:valueInt];
}

-(void) addColumn:(NSString*) columnName andBoolean:(BOOL) valueBool {
    [_columns addObject:columnName];
    [self addValueFromBoolean:valueBool];
}

-(void) addColumn:(NSString*) columnName {
    [_columns addObject:columnName];
}

-(void) addValue:(NSObject*) valueObject {
    [_values addObject:(valueObject==nil?[NSNull null]:valueObject)];
}

-(void) addValueFromInt:(int) valueInt {
    [_values addObject:[NSNumber numberWithInt:valueInt]];
}

-(void) addValueFromBoolean:(BOOL) valueBoolean {
    [_values addObject:(valueBoolean ? @1 : @0)];
}

-(NSString*) columnsStringForInsert {
    return [WBSqlBuilder columnsStringForInsertWithColumns:_columns];
}

-(NSString*) columnsStringForUpdate {
    return [WBSqlBuilder columnsStringForUpdateWithColumns:_columns];
}

-(NSString*) questionMarksStringForInsert {
    return [WBSqlBuilder questionMarksStringForInsertWithColumns:_columns];
}

+(NSString*) columnsStringForInsertWithColumns:(NSArray*) columns {
    return [columns componentsJoinedByString:@","];
}

+(NSString*) columnsStringForUpdateWithColumns:(NSArray*) columns {
    NSMutableArray *a = @[].mutableCopy;
    for (NSString* col in columns) {
        [a addObject:[NSString stringWithFormat:@"%@ = ?", col]];
    }
    return[a componentsJoinedByString:@", "];
}

+(NSString*) questionMarksStringForInsertWithColumns:(NSArray*) columns {
    NSMutableArray *a = @[].mutableCopy;
    for (id i in columns) {
        [a addObject:@"?"];
    }
    return [a componentsJoinedByString:@","];
}

@end
