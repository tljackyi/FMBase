//
//  NSDictionary+SafeKit.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "NSDictionary+SafeKit.h"
#import "NSObject+FMMethodSwizzle.h"
#import "FMExceptionLog.h"

@implementation NSDictionary (SafeKit)

+ (void)load{
    Class placeHolderClass = NSClassFromString(@"__NSPlaceholderDictionary");
    [self fm_instancenSwizzleWithClass:placeHolderClass originSelector:@selector(initWithObjects:forKeys:count:) swizzleSelector:@selector(fm_initWithObjects:forKeys:count:)];
    
    Class originClass = NSClassFromString(@"NSDictionary");
    [self fm_instancenSwizzleWithClass:originClass originSelector:@selector(writeToURL:error:) swizzleSelector:@selector(fm_writeToURL:error:)];
    [self fm_instancenSwizzleWithClass:originClass originSelector:@selector(initWithObjects:forKeys:) swizzleSelector:@selector(fm_initWithObjects:forKeys:)];
    [self fm_classSwizzleWithClass:originClass originSelector:@selector(sharedKeySetForKeys:) swizzleSelector:@selector(fm_sharedKeySetForKeys:)];
    
    Class mutableClass = NSClassFromString(@"NSMutableDictionary");
    [self fm_classSwizzleWithClass:mutableClass originSelector:@selector(sharedKeySetForKeys:) swizzleSelector:@selector(mutable_sharedKeySetForKeys:)];
    [self fm_classSwizzleWithClass:mutableClass originSelector:@selector(dictionaryWithSharedKeySet:) swizzleSelector:@selector(fm_dictionaryWithSharedKeySet:)];
    
    Class classM = NSClassFromString(@"__NSDictionaryM");
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(removeObjectForKey:) swizzleSelector:@selector(fm_removeObjectForKey:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(setObject:forKey:) swizzleSelector:@selector(fm_setObject:forKey:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(setObject:forKeyedSubscript:) swizzleSelector:@selector(fm_setObject:forKeyedSubscript:)];

}

- (instancetype)fm_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    NSUInteger realCount = 0;
    id realObjects[cnt];
    id realKeys[cnt];
    
    BOOL capture = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (keys && objects && keys[i] && objects[i]) {
            realObjects[realCount] = objects[i];
            realKeys[realCount] = keys[i];
            realCount++;
        } else {
            if (!capture) {
                capture = YES;
                NSUInteger count = cnt > 0 ? (cnt -1) : cnt;
                NSString *msg = [NSString stringWithFormat:@"+[%@ %@], the %lu keys %p or objects %p is nil in  0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)i, keys, objects, (long)count];
                [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
            }
        }
    }
    
    return [self fm_initWithObjects:realObjects forKeys:realKeys count:realCount];
}

- (instancetype)fm_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    if (objects.count == keys.count) {
        return [self fm_initWithObjects:objects forKeys:keys];
    }
    
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects count %lu must equal keys count %lu", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)objects.count, (long)keys.count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (BOOL)fm_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error
{
    if (url) {
        return [self fm_writeToURL:url error:error];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], url can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return NO;
}

+ (id)fm_sharedKeySetForKeys:(NSArray<id<NSCopying>> *)keys
{
    if (keys) {
        return [self fm_sharedKeySetForKeys:keys];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], keys can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    
    return nil;
}

+ (id)mutable_sharedKeySetForKeys:(NSArray<id<NSCopying>> *)keys
{
    if (!keys) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], keys can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return nil;
    }
    
    return [self mutable_sharedKeySetForKeys:keys];
}

- (void)fm_removeObjectForKey:(id)aKey
{
    if (aKey) {
        return [self fm_removeObjectForKey:aKey];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_setObject:(id)anObject forKey:(id)aKey
{
    if (anObject && aKey) {
        return [self fm_setObject:anObject forKey:aKey];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key %@ or object %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), aKey, anObject];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_setObject:(nullable id)obj forKeyedSubscript:(id <NSCopying>)key
{
    if (key) { // if obj be nil, it will call removeObjectForKey:
        return [self fm_setObject:obj forKeyedSubscript:key];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], key %@ or object %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), key, obj];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

+ (NSMutableDictionary *)fm_dictionaryWithSharedKeySet:(id)keyset
{
    if (keyset) {
        return [self fm_dictionaryWithSharedKeySet:keyset];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], keySet can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}
@end
