/*
 *  JavaScriptCoreContext.m
 *  javascript-core-kit
 *
 *  Created by Fang Ling on 2026/4/4.
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

#import "JavaScriptCoreContext+Private.h"

C_ASSUME_NONNULL_BEGIN

extern CFloatingPoint64 JavaScriptCoreWindowGetWidth();

extern CFloatingPoint64 JavaScriptCoreWindowGetHeight();

extern void JavaScriptCoreMeasureTextSize(
  CInteger32* textBuffer,
  CUnsignedInteger64 textBufferCount,
  CInteger32* styleTextBuffer,
  CUnsignedInteger64 styleTextBufferCount,
  CFloatingPoint* result
);

static let currentContext = (JavaScriptCoreContext*)nil;

@implementation JavaScriptCoreContext

+ (void)initialize {
  currentContext = [[JavaScriptCoreContext alloc] init];
}

+ (instancetype)currentContext {
  return currentContext;
}

- (instancetype)init {
  if (!(self = [super init])) {
    return nil;
  }

  self.fetchIndex = 0;
  self.pendingFetchCompletionHandlers =
    [FoundationMutableDictionary makeDictionary];

  return self;
}

+ (CFloatingPoint64)windowWidth {
  return JavaScriptCoreWindowGetWidth();
}

+ (CFloatingPoint64)windowHeight {
  return JavaScriptCoreWindowGetHeight();
}

+ (CoreFoundationSize)measureTextSize:(FoundationString*)text
                            styleText:(FoundationString*)styleText {
  let textBuffer = (CInteger32*)CMemoryAllocate(text.count, sizeof(CInteger32));
  let styleTextBuffer = (CInteger32*)CMemoryAllocate(
    styleText.count,
    sizeof(CInteger32)
  );
  [text copyCharacters:textBuffer];
  [styleText copyCharacters:styleTextBuffer];

  CFloatingPoint result[2] = { 0 };

  JavaScriptCoreMeasureTextSize(
    textBuffer,
    text.count,
    styleTextBuffer,
    styleText.count,
    result
  );

  CMemoryDeallocate(textBuffer);
  CMemoryDeallocate(styleTextBuffer);

  return CoreFoundationSizeMake(result[0], result[1]);
}

@end

C_ASSUME_NONNULL_END
