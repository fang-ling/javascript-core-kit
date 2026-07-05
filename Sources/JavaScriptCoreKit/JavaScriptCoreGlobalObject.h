/*
 *  JavaScriptCoreGlobalObject.h
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

#import "JavaScriptCoreContext.h"

#import <CKit/CKit.h>
#import <FoundationKit/FoundationKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * The JavaScript global object.
 *
 * In a web browser, the global object is the browser window (the window object
 * in JavaScript). Outside of web-browser use, a context's global object serves
 * a similar role.
 */
@interface JavaScriptCoreGlobalObject: ObjectiveCObject

/**
 * The shared global object for the process.
 */
@property (class, nonatomic, readonly)
  JavaScriptCoreGlobalObject* defaultObject;

- (void)fetchWithURL:(FoundationString*)url
             request:(nullable FoundationDictionary*)request
           inContext:(JavaScriptCoreContext*)context
   completionHandler:(void (^)(FoundationData* data))handler;

@end

C_ASSUME_NONNULL_END
