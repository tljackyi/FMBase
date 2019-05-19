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
    SEL getObjectsRangeSEL = @selector(fm_getObjects:range:);
    SEL objectsAtIndexSEL = @selector(fm_objectAtIndex:);
    
    Class arrayClass = NSClassFromString(@"NSArray");
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(arrayByAddingObject:) swizzleSelector:@selector(fm_arrayByAddingObject:)];
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(indexOfObject:inRange:) swizzleSelector:@selector(fm_indexOfObject:inRange:)];
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(fm_getObjectsForSuperClass:range:)]; ///< 这里要注意不能把父类的方法给替换了，否则会影响到所有子类
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(indexOfObjectIdenticalTo:inRange:) swizzleSelector:@selector(fm_indexOfObjectIdenticalTo:inRange:)];
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(fm_subarrayWithRange:)];
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(objectsAtIndexes:) swizzleSelector:@selector(fm_objectsAtIndexes:)];
    [self fm_instancenSwizzleWithClass:arrayClass originSelector:@selector(writeToURL:error:) swizzleSelector:@selector(fm_writeToURL:error:)]; ///< for NSData
    
    
    
    Class originClass = NSClassFromString(@"__NSArrayI");
    [self fm_instancenSwizzleWithClass:originClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(fm_objectAtIndexedSubscript:)];
    [self fm_instancenSwizzleWithClass:originClass originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self fm_instancenSwizzleWithClass:originClass originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    
    
    
    Class array0Class = NSClassFromString(@"__NSArray0");
    [self fm_instancenSwizzleWithClass:array0Class originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    
    
    
    Class singleClass = NSClassFromString(@"__NSSingleObjectArrayI");
    [self fm_instancenSwizzleWithClass:singleClass originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self fm_instancenSwizzleWithClass:singleClass originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    
    
    Class mutableClass = NSClassFromString(@"NSMutableArray");
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectsAtIndexes:) swizzleSelector:@selector(fm_removeObjectsAtIndexes:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObject:inRange:) swizzleSelector:@selector(fm_removeObject:inRange:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(fm_removeObjectAtIndex:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(removeObjectIdenticalTo:inRange:) swizzleSelector:@selector(fm_removeObjectIdenticalTo:inRange:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:) swizzleSelector:@selector(fm_replaceObjectsInRange:withObjectsFromArray:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:range:) swizzleSelector:@selector(fm_replaceObjectsInRange:withObjectsFromArray:range:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(insertObjects:atIndexes:) swizzleSelector:@selector(fm_insertObjects:atIndexes:)];
    [self fm_instancenSwizzleWithClass:mutableClass originSelector:@selector(replaceObjectsAtIndexes:withObjects:) swizzleSelector:@selector(fm_replaceObjectsAtIndexes:withObjects:)];
    
    
    
    Class classM = NSClassFromString(@"__NSArrayM");
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(insertObject:atIndex:) swizzleSelector:@selector(fm_insertObject:atIndex:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(removeObjectsInRange:) swizzleSelector:@selector(fm_removeObjectsInRange:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(replaceObjectAtIndex:withObject:) swizzleSelector:@selector(fm_replaceObjectAtIndex:withObject:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(exchangeObjectAtIndex:withObjectAtIndex:) swizzleSelector:@selector(fm_exchangeObjectAtIndex:withObjectAtIndex:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(setObject:atIndexedSubscript:) swizzleSelector:@selector(fm_setObject:atIndexedSubscript:)];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(fm_objectAtIndexedSubscriptArrayM:)];
    ///< 据说低于11.0交换此方法会导致有键盘显示的地方，此时退到后台会crash? [UIKeyboardLayoutStar release]: message sent to deallocated instance
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(objectAtIndex:) swizzleSelector:objectsAtIndexSEL];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(getObjects:range:) swizzleSelector:getObjectsRangeSEL];
    [self fm_instancenSwizzleWithClass:classM originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(fm_removeObjectAtIndexArrayM:)];
    
    
    Class placeHolderClass = NSClassFromString(@"__NSPlaceholderArray");
    [self fm_instancenSwizzleWithClass:placeHolderClass originSelector:@selector(initWithObjects:count:) swizzleSelector:@selector(fm_initWithObjects:count:)];
    
    
    Class transferClass = NSClassFromString(@"__NSArrayI_Transfer");
    [self fm_instancenSwizzleWithClass:transferClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(fm_objectAtIndex:)];
    [self fm_instancenSwizzleWithClass:transferClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(fm_getObjects:range:)];
    [self fm_instancenSwizzleWithClass:transferClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(fm_objectAtIndexedSubscript:)];
    
    
    Class frozenClass = NSClassFromString(@"__NSFrozenArrayM");
    [self fm_instancenSwizzleWithClass:frozenClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(fm_objectAtIndex:)];
    [self fm_instancenSwizzleWithClass:frozenClass originSelector:@selector(getObjects:range:) swizzleSelector:@selector(fm_getObjects:range:)];
    [self fm_instancenSwizzleWithClass:frozenClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(fm_objectAtIndexedSubscript:)];
    
    
    Class reverseClass = NSClassFromString(@"__NSArrayReversed");
    [self fm_instancenSwizzleWithClass:reverseClass originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(fm_objectAtIndex:)];
    [self fm_instancenSwizzleWithClass:reverseClass originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(fm_subarrayWithRange:)];
    [self fm_instancenSwizzleWithClass:reverseClass originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(fm_objectAtIndexedSubscript:)];
    
    
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
     [self fm_instancenSwizzleWithClass:classCFArray__ originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(fm_objectAtIndex:)];
     */
}

- (BOOL)fm_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error
{
    if (!url) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], url can not be nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return NO;
    }
    
    return [self fm_writeToURL:url error:error];
}

- (id)fm_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self fm_objectAtIndexedSubscript:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (id)fm_objectAtIndexedSubscriptArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self fm_objectAtIndexedSubscriptArrayM:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (id)fm_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self fm_objectAtIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %ld is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (instancetype)fm_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
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
    
    return [self fm_initWithObjects:realObjects count:realCount];
}

- (NSArray *)fm_arrayByAddingObject:(id)anObject
{
    if (anObject) {
        return [self fm_arrayByAddingObject:anObject];
    }
    
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return self;
}

///< 给除了NSArray之外的子类用
- (void)fm_getObjects:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self fm_getObjects:objects range:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

///< 给NSArray用
- (void)fm_getObjectsForSuperClass:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self fm_getObjectsForSuperClass:objects range:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (NSUInteger)fm_indexOfObject:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self fm_indexOfObject:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return 0;
}

- (NSUInteger)fm_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self fm_indexOfObjectIdenticalTo:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return 0;
}

- (NSArray *)fm_subarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self fm_subarrayWithRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
    return nil;
}

- (NSArray *)fm_objectsAtIndexes:(NSIndexSet *)indexes
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
    
    return [self fm_objectsAtIndexes:indexes];
}

- (void)fm_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        return [self fm_insertObject:anObject atIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_removeObjectsInRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self fm_removeObjectsInRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_removeObjectsAtIndexes:(NSIndexSet *)indexes
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
    
    return [self fm_removeObjectsAtIndexes:indexes];
}

- (void)fm_removeObject:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self fm_removeObject:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, range is %@, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self fm_removeObjectAtIndex:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_removeObjectAtIndexArrayM:(NSUInteger)index
{
    if (index < self.count) {
        return [self fm_removeObjectAtIndexArrayM:index];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index %lu is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject && index < self.count) {
        return [self fm_replaceObjectAtIndex:index withObject:anObject];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, (long)index, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.count && idx2 < self.count) {
        return [self fm_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], index1 is %lu, index2 is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), (long)idx1, (long)idx2, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if (anObject && range.location + range.length <= self.count) {
        return [self fm_removeObjectIdenticalTo:anObject inRange:range];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, range is %@, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), anObject, NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    ///< idx can equal self.count here, it will add to the last of array when equal.
    if (obj && idx <= self.count) {
        return [self fm_setObject:obj atIndexedSubscript:idx];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], object is %@, index is %lu, array bounds is 0...%lu", NSStringFromClass([self class]),NSStringFromSelector(_cmd), obj, (long)idx, count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (range.location + range.length <= self.count) {
        return [self fm_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if (!otherArray) {
        NSString *msg = [NSString stringWithFormat:@"+[%@ %@], otherArray can not be nil", NSStringFromClass([self class]),NSStringFromSelector(_cmd)];
        [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
        return;
    }
    
    if (range.location + range.length <= self.count) {
        if (otherRange.location + otherRange.length <= otherArray.count) {
            return [self fm_replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
        }
    }
    
    long count = self.count > 0 ? self.count - 1 : self.count;
    NSString *msg = [NSString stringWithFormat:@"+[%@ %@], range %@ or othreRange %@ is out of bounds 0...%ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd), NSStringFromRange(range), NSStringFromRange(otherRange), count];
    [[FMExceptionLog sharedInstance] reportExceptionWithMessage:msg extraDic:nil];
}

- (void)fm_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
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
    
    return [self fm_insertObjects:objects atIndexes:indexes];
}

- (void)fm_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
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
    
    return [self fm_replaceObjectsAtIndexes:indexes withObjects:objects];
}

@end
