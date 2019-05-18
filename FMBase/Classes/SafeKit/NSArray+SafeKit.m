//
//  NSArray+SafeKit.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "NSArray+SafeKit.h"
#import "NSObject+FMMethodSwizzle.h"
#import "FMExceptionLog.h"

@implementation NSArray (SafeKit)

+ (void)load{
    SEL getObjectsRangeSEL = @selector(getObjects:range:);
    SEL objectsAtIndexSEL = @selector(objectAtIndex:);
    
    Class arrayClass = NSClassFromString(@"NSArray");
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(arrayByAddingObject:) swizzleSelector:@selector(arrayByAddingObject:)];
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(indexOfObject:inRange:) swizzleSelector:@selector(indexOfObject:inRange:)];
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(getObjectsForSuperClass:range:)]; ///< 这里要注意不能把父类的方法给替换了，否则会影响到所有子类
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(indexOfObjectIdenticalTo:inRange:) swizzleSelector:@selector(indexOfObjectIdenticalTo:inRange:)];
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(subarrayWithRange:)];
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(objectsAtIndexes:) swizzleSelector:@selector(objectsAtIndexes:)];
    [self instancenSwizzleWithClass:arrayClass originSelector:@selector(writeToURL:error:) swizzleSelector:@selector(writeToURL:error:)]; ///< for NSData
    

    Class originClass = NSClassFromString(@"__NSArrayI");
    [self instancenSwizzleWithClass:originClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(objectAtIndexedSubscript:)];
    [self instancenSwizzleWithClass:originClass originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self instancenSwizzleWithClass:originClass originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];


    Class array0Class = NSClassFromString(@"__NSArray0");
    [self instancenSwizzleWithClass:array0Class originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];

    
    Class singleClass = NSClassFromString(@"__NSSingleObjectArrayI");
    [self instancenSwizzleWithClass:singleClass originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self instancenSwizzleWithClass:singleClass originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];


    Class mutableClass = NSClassFromString(@"NSMutableArray");
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectsAtIndexes:) swizzleSelector:@selector(removeObjectsAtIndexes:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObject:inRange:) swizzleSelector:@selector(removeObject:inRange:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(removeObjectAtIndex:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectIdenticalTo:inRange:) swizzleSelector:@selector(removeObjectIdenticalTo:inRange:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:) swizzleSelector:@selector(replaceObjectsInRange:withObjectsFromArray:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:range:) swizzleSelector:@selector(replaceObjectsInRange:withObjectsFromArray:range:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(insertObjects:atIndexes:) swizzleSelector:@selector(insertObjects:atIndexes:)];
    [self instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsAtIndexes:withObjects:) swizzleSelector:@selector(replaceObjectsAtIndexes:withObjects:)];
    
    
    
    Class classM = NSClassFromString(@"__NSArrayM");
    [self instancenSwizzleWithClass:classM originSelector:@selector(insertObject:atIndex:) swizzleSelector:@selector(insertObject:atIndex:)];
    [self instancenSwizzleWithClass:classM originSelector:@selector(removeObjectsInRange:) swizzleSelector:@selector(removeObjectsInRange:)];
    [self instancenSwizzleWithClass:classM originSelector:@selector(replaceObjectAtIndex:withObject:) swizzleSelector:@selector(replaceObjectAtIndex:withObject:)];
    [self instancenSwizzleWithClass:classM originSelector:@selector(exchangeObjectAtIndex:withObjectAtIndex:) swizzleSelector:@selector(exchangeObjectAtIndex:withObjectAtIndex:)];
    [self instancenSwizzleWithClass:classM originSelector:@selector(setObject:atIndexedSubscript:) swizzleSelector:@selector(setObject:atIndexedSubscript:)];
    [self instancenSwizzleWithClass:classM originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(objectAtIndexedSubscriptArrayM:)];
    ///< 据说低于11.0交换此方法会导致有键盘显示的地方，此时退到后台会crash? [UIKeyboardLayoutStar release]: message sent to deallocated instance
    [self instancenSwizzleWithClass:classM originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self instancenSwizzleWithClass:classM originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    [self instancenSwizzleWithClass:classM originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(removeObjectAtIndexArrayM:)];
    
    
    Class placeHolderClass = NSClassFromString(@"__NSPlaceholderArray");
    [self instancenSwizzleWithClass:placeHolderClass originSelector:@selector(initWithObjects:count:) swizzleSelector:@selector(initWithObjects:count:)];
    
    
    Class transferClass = NSClassFromString(@"__NSArrayI_Transfer");
    [self instancenSwizzleWithClass:transferClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(objectAtIndex:)];
    [self instancenSwizzleWithClass:transferClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(getObjects:range:)];
    [self instancenSwizzleWithClass:transferClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(objectAtIndexedSubscript:)];
    
    
    Class frozenClass = NSClassFromString(@"__NSFrozenArrayM");
    [self instancenSwizzleWithClass:frozenClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(objectAtIndex:)];
    [self instancenSwizzleWithClass:frozenClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(getObjects:range:)];
    [self instancenSwizzleWithClass:frozenClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(objectAtIndexedSubscript:)];
    
    
    Class reverseClass = NSClassFromString(@"__NSArrayReversed");
    [self instancenSwizzleWithClass:reverseClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(objectAtIndex:)];
    [self instancenSwizzleWithClass:reverseClass originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(subarrayWithRange:)];
    [self instancenSwizzleWithClass:reverseClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(objectAtIndexedSubscript:)];
    
    /*
     addObject:
     objectAtIndex:
     getObjects:range:
     insertObject:atIndex:
     removeObjectAtIndex:
     countByEnumeratingWithState:objects:count:
     replaceObjectAtIndex:withObject:
     objectAtIndexedSubscript:
     //    这个是系统内部用到的，hook后会崩溃on ios11
     Class classCFArray__ = NSClassFromString(@"__NSCFArray");
     [self instancenSwizzleWithClass:classCFArray__ originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(objectAtIndex:)];
     */
}

- (BOOL)writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error
{
    if (!url) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], url can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return NO;
    }
    
    return [self writeToURL:url error:error];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndexedSubscript:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (id)objectAtIndexedSubscriptArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndexedSubscriptArrayM:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (id)objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
{
    NSUInteger realCount = 0;
    id  _Nonnull __unsafe_unretained realObjects[cnt];
    
    // cnt比数组长度大，objects[i]会读取到其他内存对象比如控制器啊什么的，所以cnt要慎重不能乱写
    BOOL capture = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects && objects[i]) {
            realObjects[realCount] = objects[i];
            realCount++;
        } else {
            if (!capture) {
                capture = YES;
                
                NSString *msg = [NSString stringWithFormat:@"+[%@ %@], the %lu object is nil in   0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)i, (long)cnt];
                [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
            }
        }
    }
    
    return [self initWithObjects:realObjects count:realCount];
}

- (NSArray *)arrayByAddingObject:(id)anObject
{
    if (anObject) {
        return [self arrayByAddingObject:anObject];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

///< 给除了NSArray之外的子类用
- (void)getObjects:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self getObjects:objects range:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

///< 给NSArray用
- (void)getObjectsForSuperClass:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self getObjectsForSuperClass:objects range:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self indexOfObject:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return 0;
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self indexOfObjectIdenticalTo:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return 0;
}

- (NSArray *)subarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self subarrayWithRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], NSIndexset can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return nil;
    }
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.count) {
            flag = YES;
            *stop = YES;
            
            NSString *msg = [NSString stringWithFormat:@"+[%@ %@], idx %ld is out of bounds 0...%ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), idx, (long)(self.count)];
            [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        }
    }];
    
    if (flag) {
        return nil;
    }
    
    return [self objectsAtIndexes:indexes];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        return [self insertObject:anObject atIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)removeObjectsInRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self removeObjectsInRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], NSIndexset can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.count) {
            flag = YES;
            *stop = YES;
            
            NSString *msg = [NSString stringWithFormat:@"+[%@ %@], idx %ld is out of bounds 0...%ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), idx, (long)self.count];
            [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        }
    }];
    
    if (flag) {
        return;
    }
    
    return [self removeObjectsAtIndexes:indexes];
}

- (void)removeObject:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self removeObject:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, range is %@, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self removeObjectAtIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)removeObjectAtIndexArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self removeObjectAtIndexArrayM:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject && index < self.count) {
        return [self replaceObjectAtIndex:index withObject:anObject];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.count && idx2 < self.count) {
        return [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index1 is %lu, index2 is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)idx1, (long)idx2, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self removeObjectIdenticalTo:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, range is %@, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    ///< idx can equal self.count here, it will add to the last of array when equal.
    if (obj && idx <= self.count) {
        return [self setObject:obj atIndexedSubscript:idx];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), obj, (long)idx, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (range.location + range.length <= self.count) {
        return [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if (!otherArray) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], otherArray can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (range.location + range.length <= self.count) {
        if (otherRange.location + otherRange.length <= otherArray.count) {
            return [self replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
        }
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ or othreRange %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), NSStringFromRange(otherRange), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (!objects || !indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects %@ or indexes %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), objects, indexes];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (objects.count != indexes.count) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects count %lu must equal indexes count %lu", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)objects.count, (long)indexes.count-1];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.count + objects.count) {
            flag = YES;
            *stop = YES;
            
            NSString *msg = [NSString stringWithFormat:@"+[%@ %@], idx %ld is out of bounds 0...%ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), idx, (long)(self.count+objects.count)];
            [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        }
    }];
    
    if (flag) {
        return;
    }
    
    return [self insertObjects:objects atIndexes:indexes];
}

- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (!objects || !indexes) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects %@ or indexes %@ can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd), objects, indexes];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (objects.count != indexes.count) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], objects count %lu must equal indexes count %lu", NSStringFromClass([self class]), NSStringFromSelector(_cmd), (long)objects.count, (long)indexes.count-1];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    __block BOOL flag = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.count) {
            flag = YES;
            *stop = YES;
            
            NSString *msg = [NSString stringWithFormat:@"+[%@ %@], idx %ld is out of bounds 0...%ld", NSStringFromClass([self class]), NSStringFromSelector(_cmd), idx, (long)(self.count)];
            [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        }
    }];
    
    if (flag) {
        return;
    }
    
    return [self replaceObjectsAtIndexes:indexes withObjects:objects];
}

@end
