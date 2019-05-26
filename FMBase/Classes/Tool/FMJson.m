//
//  FMJson.m
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import "FMJson.h"

@implementation FMJson
+ (FMJson *)jsonWithObject:(id)obj {
    __autoreleasing FMJson *mfwJson = [[FMJson alloc] initWithObject:obj];
    
    return mfwJson;
}
//////////////////////////////////////////////////////


+ (FMJson *)jsonWithData:(NSData*)jsonData; {
    id jsonObj = nil;
    
    if (jsonData) {
        jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    
    if (jsonObj) {
        return [FMJson jsonWithObject:jsonObj];
    }
    else {
        return nil;
    }
}
//////////////////////////////////////////////////////


+ (FMJson *)jsonWithString:(NSString*)jsonStr {
    if ([jsonStr isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        return [FMJson jsonWithData:jsonData];
    }
    return nil;
}
//////////////////////////////////////////////////////




- (id)initWithObject:(id)object {
    self = [super init];
    
    if (self) {
        [self setJsonObject:object];
    }
    
    return self;
}

- (void)setJsonObject:(id)jsonObj {
    if ([jsonObj isKindOfClass:[NSDictionary class]]
        || [jsonObj isKindOfClass:[NSArray class]]) {
        _jsonObj = jsonObj;
    }
    else {
        _jsonObj = nil;
    }
}
//////////////////////////////////////////////////////


- (BOOL)hasValueForKey:(NSString*)key {
    if (_jsonObj) {
        if ([_jsonObj isKindOfClass:[NSDictionary class]]) {
            return [_jsonObj valueForKeyPath:key] != nil;
        }
    }
    
    return false;
}
//////////////////////////////////////////////////////

- (BOOL)hasValueAtIndex:(NSUInteger)index {
    if (_jsonObj) {
        if ([_jsonObj isKindOfClass:[NSArray class]]
            && index < [_jsonObj count]) {
            return YES;
        }
    }
    return  NO;
}
//////////////////////////////////////////////////////

/**
 * @return return json raw string
 */
- (NSString*)stringJson {
    if (!_jsonObj) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_jsonObj options:0 error:&error];
    
    __autoreleasing NSString *stringData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return stringData;
}
//////////////////////////////////////////////////////

- (NSString *)description {
    return [_jsonObj description];
}


/**
 * @return NSDictionary or NSArray
 */
- (id)jsonObj {
    return _jsonObj;
}
//////////////////////////////////////////////////////

/**
 * @return count of
 */
- (NSUInteger)count {
    if (_jsonObj) {
        if ([_jsonObj respondsToSelector:@selector(count)]) {
            return [_jsonObj count];
        }
    }
    
    return 0;
}
//////////////////////////////////////////////////////

- (id)originValueForKey:(NSString *)key {
    if ([_jsonObj isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary*)_jsonObj valueForKeyPath:key];
    }
    
    return nil;
}
//////////////////////////////////////////////////////

- (FMJson*)jsonForKey:(NSString*)key {
    id value = [self originValueForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]
        || [value isKindOfClass:[NSArray class]]) {
        return [FMJson jsonWithObject:value];
    }
    return nil;
}
//////////////////////////////////////////////////////

/**
 * retrieve string value for key
 */
- (NSString*)stringValueForKey:(NSString*)key {
    return [self stringValueForKey:key defaultValue:@""];
}
//////////////////////////////////////////////////////

/**
 * retrieve string value for key
 *
 * @param key
 * @param defaultStr
 */
- (NSString*)stringValueForKey:(NSString*)key defaultValue:(NSString*)defaultStr {
    id value = [self originValueForKey:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    else {
        return defaultStr;
    }
}
//////////////////////////////////////////////////////

- (NSInteger)integerValueForKey:(NSString*)key {
    return [self integerValueForKey:key defaultValue:0];
}
//////////////////////////////////////////////////////

- (NSInteger)integerValueForKey:(NSString*)key defaultValue:(NSInteger)defaultInt {
    id value = [self originValueForKey:key];
    
    if ([value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    else {
        return defaultInt;
    }
}

//////////////////////////////////////////////////////

- (NSUInteger)unsignedIntegerValueForKey:(NSString*)key {
    return [self unsignedIntegerValueForKey:key defaultValue:0];
}

- (NSUInteger)unsignedIntegerValueForKey:(NSString*)key defaultValue:(NSUInteger)defaultInt {
    NSInteger value = [self integerValueForKey:key defaultValue:defaultInt];
    if (value >= 0) {
        return (NSUInteger)value;
    }
    else {
        return defaultInt;
    }
}


//////////////////////////////////////////////////////
- (int)intValueForKey:(NSString *)key {
    return  [self intValueForKey:key defaultValue:0];
}

//////////////////////////////////////////////////////
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultInt {
    id value = [self originValueForKey:key];
    if ([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    else {
        return defaultInt;
    }
}



//////////////////////////////////////////////////////

- (char)charValueForKey:(NSString*)key {
    return [self integerValueForKey:key defaultValue:0];
}
//////////////////////////////////////////////////////

- (NSInteger)charValueForKey:(NSString*)key defaultValue:(int)defaultChar {
    id value = [self originValueForKey:key];
    
    if ([value respondsToSelector:@selector(charValue)]) {
        return [value charValue];
    }
    else {
        return defaultChar;
    }
}
//////////////////////////////////////////////////////

- (long)longValueForKey:(NSString*)key {
    return [self longValueForKey:key defaultValue:0];
}
//////////////////////////////////////////////////////

- (long)longValueForKey:(NSString*)key defaultValue:(long)defaultLong {
    id value = [self originValueForKey:key];
    
    if ([value respondsToSelector:@selector(longValue)]) {
        return [value longValue];
    }
    else {
        return defaultLong;
    }
}
//////////////////////////////////////////////////////

- (long long)longlongValueForKey:(NSString*)key {
    return [self longlongValueForKey:key defaultValue:0];
}
//////////////////////////////////////////////////////

- (long long)longlongValueForKey:(NSString*)key defaultValue:(long long)defaultLonglong {
    id value = [self originValueForKey:key];
    
    if ([value respondsToSelector:@selector(longLongValue)]) {
        return [value longLongValue];
    }
    else {
        return defaultLonglong;
    }
}
//////////////////////////////////////////////////////

- (double)doubleValueForKey:(NSString*)key {
    return [self doubleValueForKey:key defaultValue:0.0];
}
//////////////////////////////////////////////////////

- (double)doubleValueForKey:(NSString*)key defaultValue:(double)defaultDouble {
    id value = [self originValueForKey:key];
    
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    else {
        return 0;
    }
}
//////////////////////////////////////////////////////

- (float)floatValueForKey:(NSString*)key {
    return [self floatValueForKey:key defaultValue:0];
}
//////////////////////////////////////////////////////

- (float)floatValueForKey:(NSString*)key defaultValue:(float)defaultFloat {
    id value = [self originValueForKey:key];
    
    if ([value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    else {
        return defaultFloat;
    }
}

//////////////////////////////////////////////////////

- (char)charValueAtIndex:(NSUInteger)index {
    return [self integerValueAtIndex:index defaultValue:0];
}
//////////////////////////////////////////////////////

- (char)charValueAtIndex:(NSUInteger)index defaultValue:(char)defaultChar {
    id value = [self originValueAtIndex:index];
    
    if ([value respondsToSelector:@selector(charValue)]) {
        return [value charValue];
    }
    
    return defaultChar;
}

//////////////////////////////////////////////////////

- (BOOL)booleanValueForKey:(NSString*)key {
    return [self booleanValueForKey:key defaultValue:NO];
}
//////////////////////////////////////////////////////

- (BOOL)booleanValueForKey:(NSString*)key defaultValue:(BOOL)defaultBoolean {
    NSString *value = [self stringValueForKey:key defaultValue:nil];
    if (value) {
        return [value boolValue];
    }
    return defaultBoolean;
}
//////////////////////////////////////////////////////

- (FMJson*)jsonAtIndex:(NSUInteger)index {
    id value = [self originValueAtIndex:index];
    if ([value isKindOfClass:[NSDictionary class]]
        || [value isKindOfClass:[NSArray class]]) {
        return [FMJson jsonWithObject:value];
    }
    return nil;
}
//////////////////////////////////////////////////////

- (id)originValueAtIndex:(NSUInteger)index {
    if (_jsonObj && [_jsonObj isKindOfClass:[NSArray class]] && index < [_jsonObj count]) {
        return [(NSArray*)_jsonObj objectAtIndex:index];
    }
    return nil;
}
//////////////////////////////////////////////////////

- (NSString*)stringValueAtIndex:(NSUInteger)index {
    return [self stringValueAtIndex:index defaultValue:nil];
}
//////////////////////////////////////////////////////

- (NSString*)stringValueAtIndex:(NSUInteger)index defaultValue:(NSString*)defaultStr {
    id value = [self originValueAtIndex:index];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    else {
        return defaultStr;
    }
}
//////////////////////////////////////////////////////

- (int)intValueAtIndex:(NSUInteger)index {
    return [self intValueAtIndex:index defaultValue:0];
}

- (int)intValueAtIndex:(NSUInteger)index defaultValue:(int)defaultInt {
    id value = [self originValueAtIndex:index];
    if ([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    return defaultInt;
}

- (NSInteger)integerValueAtIndex:(NSUInteger)index;
{
    return [self integerValueAtIndex:index defaultValue:0];
}
//////////////////////////////////////////////////////

- (NSInteger)integerValueAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultInt;
{
    id value = [self originValueAtIndex:index];
    
    if ([value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    
    return defaultInt;
}
//////////////////////////////////////////////////////

- (long)longValueAtIndex:(NSUInteger)index {
    return [self longValueAtIndex:index defaultValue:0];
}
//////////////////////////////////////////////////////

- (long)longValueAtIndex:(NSUInteger)index defaultValue:(long)defaultLong {
    id value = [self originValueAtIndex:index];
    
    if ([value respondsToSelector:@selector(longValue)]) {
        return [value longValue];
    }
    
    return defaultLong;
}
//////////////////////////////////////////////////////

- (long long)longlongValueAtIndex:(NSUInteger)index {
    return [self longlongValueAtIndex:index defaultValue:0];
}
//////////////////////////////////////////////////////

- (long long)longlongValueAtIndex:(NSUInteger)index defaultValue:(long long)defaultLonglong {
    id value = [self originValueAtIndex:index];
    
    if ([value respondsToSelector:@selector(longLongValue)]) {
        return [value longLongValue];
    }
    else {
        return defaultLonglong;
    }
}
//////////////////////////////////////////////////////

- (double)doubleValueAtIndex:(NSUInteger)index {
    return [self doubleValueAtIndex:index defaultValue:0];
}
//////////////////////////////////////////////////////

- (double)doubleValueAtIndex:(NSUInteger)index defaultValue:(double)defaultDouble {
    id value = [self originValueAtIndex:index];
    
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    
    return defaultDouble;
}
//////////////////////////////////////////////////////

- (float)floatValueAtIndex:(NSUInteger)index {
    return [self floatValueAtIndex:index defaultValue:0];
}
//////////////////////////////////////////////////////

- (float)floatValueAtIndex:(NSUInteger)index defaultValue:(float)defaultFloat {
    id value = [self originValueAtIndex:index];
    
    if ([value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    
    return defaultFloat;
}
//////////////////////////////////////////////////////

- (id)copyWithZone:(NSZone *)zone {
    FMJson *copyJson = [[self.class alloc] initWithObject:[_jsonObj copyWithZone:zone]];
    return copyJson;
}
@end
