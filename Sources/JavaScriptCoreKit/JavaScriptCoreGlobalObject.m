/*
 *  JavaScriptCoreGlobalObject.m
 *  javascript-core-kit
 *
 *  Created by Fang Ling on 2026/7/4.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "JavaScriptCoreGlobalObject.h"

#import "JavaScriptCoreContext+Private.h"

C_ASSUME_NONNULL_BEGIN

extern void JavaScriptCoreGlobalObjectFetch(
  CInteger requestID,
  CInteger32* urlBuffer,
  CInteger urlBufferCount,
  CInteger8* requestBuffer,
  CInteger requestBufferCount
);

static let defaultObject = (JavaScriptCoreGlobalObject*)nil;

void JavaScriptCoreGlobalObjectFetchDidFinish(CInteger requestID, void* data) {
  let context = JavaScriptCoreContext.currentContext;

  void (^completionHandler)(FoundationData*) =
    context.pendingFetchCompletionHandlers[@(requestID)];

  let jsonData = [FoundationData makeDataWithBytes:data
                                             count:CStringGetCount(data)];

  completionHandler(jsonData);

  /* TODO: remove the completionHandler from pending handlers. */
}

@implementation JavaScriptCoreGlobalObject

+ (void)initialize {
  defaultObject = [[JavaScriptCoreGlobalObject alloc] init];
}

+ (instancetype)defaultObject {
  return defaultObject;
}

- (void)fetchWithURL:(FoundationString*)url
             request:(nullable FoundationDictionary*)request
           inContext:(JavaScriptCoreContext*)context
   completionHandler:(void (^)(FoundationData* data))handler {
  context.fetchIndex += 1;
  context.pendingFetchCompletionHandlers[@(context.fetchIndex)] = handler;

  let urlBuffer = (CInteger32*)CMemoryAllocate(
    url.count * sizeof(CInteger32)
  );
  [url copyCharacters:urlBuffer];

  if (!request) {
    request = @{};
  }

  let requestData =
    [FoundationJSONSerialization makeDataWithJSONObject:request];

  JavaScriptCoreGlobalObjectFetch(
    context.fetchIndex,
    urlBuffer,
    url.count,
    (CInteger8*)requestData.bytes,
    requestData.count
  );

  CMemoryDeallocate(urlBuffer);
}

@end

C_ASSUME_NONNULL_END
