//
//  FMLoadableHeader.h
//  FMBase_Example
//
//  Created by yitailong on 2019/5/17.
//  Copyright © 2019 tljackyi. All rights reserved.
//

#ifndef FMLoadableHeader_h
#define FMLoadableHeader_h

#define FMLoadableSegmentName "__DATA"
#define FMLoadableSectionName "Loadable"

#define FMLoadable __attribute((used, section(FMLoadableSegmentName "," FMLoadableSectionName )))

typedef int (*FMLoadableFunctionCallback)(const char *);
typedef void (*FMLoadableFunctionTemplate)(FMLoadableFunctionCallback);

#define FMLoadableFunctionBegin(functionName) \
static void FMLoadable##functionName(FMLoadableFunctionCallback FMLoadableCallback){ \
if(0 != FMLoadableCallback(#functionName)) return;

#define FMLoadableFunctionEnd(functionName) \
} \
static FMLoadableFunctionTemplate varQWLoadable##functionName FMLoadable = FMLoadable##functionName;

#endif /* FMLoadableHeader_h */
