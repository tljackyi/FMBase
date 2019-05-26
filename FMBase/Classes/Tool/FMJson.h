//
//  FMJson.h
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMJson : NSObject{
    id _jsonObj;
}

//@property(nonatomic, readonly)id    jsonObj;//  parsed json object. Which type is NSDictionary or NSArray.

+ (FMJson*)jsonWithObject:(id)obj;
+ (FMJson*)jsonWithData:(NSData*)jsonData;
+ (FMJson*)jsonWithString:(NSString*)jsonStr;

- (id)initWithObject:(id)object;

/**
 * @return return json raw string
 */
- (NSString*)stringJson;

/**
 * @return NSDictionary or NSArray
 */
- (id)jsonObj;
- (void)setJsonObject:(id)jsonObj;

/**
 * @return count of _jsonObj
 */
- (NSUInteger)count;

- (BOOL)hasValueForKey:(NSString*)key;
- (BOOL)hasValueAtIndex:(NSUInteger)index;

- (id)originValueForKey:(NSString *)key;


- (FMJson*)jsonForKey:(NSString*)key NS_SWIFT_NAME(jsonValue(forKey:));
/**
 * retrieve string value for key
 */
- (NSString*)stringValueForKey:(NSString*)key;

/**
 * retrieve string value for key
 * if _jsonObj does't contain $key or the value for $key is NSNull, this fuction will
 * return $defaultStr
 *
 * @param key
 * @param defaultStr
 */
- (NSString*)stringValueForKey:(NSString*)key defaultValue:(NSString*)defaultStr;

/**
 * retrieve NSInteger value for key
 */
- (NSInteger)integerValueForKey:(NSString*)key;

/**
 * retrieve NSInteger value for key
 * if _jsonObj does't contain $key or the value for $key is NSNull, this fuction will
 * return $defaultInt
 *
 * @param key
 * @param defaultInt
 */
- (NSInteger)integerValueForKey:(NSString*)key defaultValue:(NSInteger)defaultInt;

- (NSUInteger)unsignedIntegerValueForKey:(NSString*)key;

- (NSUInteger)unsignedIntegerValueForKey:(NSString*)key defaultValue:(NSUInteger)defaultInt ;

- (int)intValueForKey:(NSString *)key;
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultInt;

- (char)charValueForKey:(NSString*)key;
- (NSInteger)charValueForKey:(NSString*)key defaultValue:(int)defaultChar;


- (char)charValueAtIndex:(NSUInteger)index;
- (char)charValueAtIndex:(NSUInteger)index defaultValue:(char)defaultChar;
- (long)longValueForKey:(NSString*)key;
- (long)longValueForKey:(NSString*)key defaultValue:(long)defaultLong;
- (long long)longlongValueForKey:(NSString*)key;
- (long long)longlongValueForKey:(NSString*)key defaultValue:(long long)defaultLonglong;
- (double)doubleValueForKey:(NSString*)key;
- (double)doubleValueForKey:(NSString*)key defaultValue:(double)defaultDouble;
- (float)floatValueForKey:(NSString*)key;
- (float)floatValueForKey:(NSString*)key defaultValue:(float)defaultFloat;
- (BOOL)booleanValueForKey:(NSString*)key;
- (BOOL)booleanValueForKey:(NSString*)key defaultValue:(BOOL)defaultBoolean;

- (FMJson*)jsonAtIndex:(NSUInteger)index;
- (id)originValueAtIndex:(NSUInteger)index;
- (NSString*)stringValueAtIndex:(NSUInteger)index;
- (NSString*)stringValueAtIndex:(NSUInteger)index defaultValue:(NSString*)defaultStr;
- (NSInteger)integerValueAtIndex:(NSUInteger)index;
- (NSInteger)integerValueAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultInt;
- (int)intValueAtIndex:(NSUInteger)index;
- (int)intValueAtIndex:(NSUInteger)index defaultValue:(int)defaultInt;
- (long)longValueAtIndex:(NSUInteger)index;
- (long)longValueAtIndex:(NSUInteger)index defaultValue:(long)defaultLong;
- (long long)longlongValueAtIndex:(NSUInteger)index;
- (long long)longlongValueAtIndex:(NSUInteger)index defaultValue:(long long)defaultLonglong;
- (double)doubleValueAtIndex:(NSUInteger)index;
- (double)doubleValueAtIndex:(NSUInteger)index defaultValue:(double)defaultDouble;
- (float)floatValueAtIndex:(NSUInteger)index;
- (float)floatValueAtIndex:(NSUInteger)index defaultValue:(float)defaultFloat;

@end

NS_ASSUME_NONNULL_END
