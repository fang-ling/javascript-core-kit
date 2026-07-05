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

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeButtonNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeDivisionNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeImageNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeParagraphNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeSpanNode();

extern void JavaScriptCoreNodeAddClickEventListener(CUnsignedInteger32 nodeID);

extern void JavaScriptCoreNodeAddSubnode(
  CUnsignedInteger32 nodeID,
  CUnsignedInteger32 subnodeID
);

extern void JavaScriptCoreNodeInsertSubnodeAtIndex(
  CUnsignedInteger32 nodeID,
  CUnsignedInteger32 subnodeID,
  CInteger index
);

extern void JavaScriptCoreNodeRemoveFromSupernode(
  CUnsignedInteger32 supernodeID,
  CUnsignedInteger32 nodeID
);

extern void JavaScriptCoreNodeUpdateStyleProperty(
  CUnsignedInteger32 nodeID,
  CInteger32* propertyBuffer,
  CUnsignedInteger64 propertyBufferCount,
  CInteger32* valueBuffer,
  CUnsignedInteger64 valueBufferCount
);

extern void JavaScriptCoreNodeUpdateClassName(
  CUnsignedInteger32 nodeID,
  CInteger32* classNameBuffer,
  CInteger classNameBufferCount
);

extern void JavaScriptCoreNodeUpdateSourceContent(
  CUnsignedInteger32 nodeID,
  CInteger32* sourceContentBuffer,
  CInteger sourceContentBufferCount
);

extern void JavaScriptCoreNodeUpdateTextContent(
  CUnsignedInteger32 nodeID,
  CInteger32* textContentBuffer,
  CUnsignedInteger64 textContentBufferCount
);

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
  let textBuffer = (CInteger32*)CMemoryAllocate(
    text.count * sizeof(CInteger32)
  );
  let styleTextBuffer = (CInteger32*)CMemoryAllocate(
    styleText.count * sizeof(CInteger32)
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

+ (CUnsignedInteger32)makeButtonNode {
  return JavaScriptCoreNodeInitializeButtonNode();
}

+ (CUnsignedInteger32)makeDivisionNode {
  return JavaScriptCoreNodeInitializeDivisionNode();
}

+ (CUnsignedInteger32)makeImageNode {
  return JavaScriptCoreNodeInitializeImageNode();
}

+ (CUnsignedInteger32)makeParagraphNode {
  return JavaScriptCoreNodeInitializeParagraphNode();
}

+ (CUnsignedInteger32)makeSpanNode {
  return JavaScriptCoreNodeInitializeSpanNode();
}

+ (void)addClickEventListenerForNode:(CUnsignedInteger32)nodeID {
  JavaScriptCoreNodeAddClickEventListener(nodeID);
}

+ (void)addSubnode:(CUnsignedInteger32)subnodeID
           forNode:(CUnsignedInteger32)nodeID {
  JavaScriptCoreNodeAddSubnode(nodeID, subnodeID);
}

+ (void)insertSubnode:(CUnsignedInteger32)subnodeID
              atIndex:(CInteger)index
              forNode:(CUnsignedInteger32)nodeID {
  JavaScriptCoreNodeInsertSubnodeAtIndex(nodeID, subnodeID, index);
}

+ (void)removeFromSupernode:(CUnsignedInteger32)supernodeID
                    forNode:(CUnsignedInteger32)nodeID {
  JavaScriptCoreNodeRemoveFromSupernode(supernodeID, nodeID);
}

+ (void)updateNode:(CUnsignedInteger32)nodeID
         className:(FoundationString*)className {
  let classNameBuffer = (CInteger32*)CMemoryAllocate(
    className.count * sizeof(CInteger32)
  );
  [className copyCharacters:classNameBuffer];

  JavaScriptCoreNodeUpdateClassName(
    nodeID,
    classNameBuffer,
    className.count
  );

  CMemoryDeallocate(classNameBuffer);
}

+ (void)updateNode:(CUnsignedInteger32)nodeID
     sourceContent:(FoundationString*)sourceContent {
  let sourceContentBuffer = (CInteger32*)CMemoryAllocate(
    sourceContent.count * sizeof(CInteger32)
  );
  [sourceContent copyCharacters:sourceContentBuffer];

  JavaScriptCoreNodeUpdateSourceContent(
    nodeID,
    sourceContentBuffer,
    sourceContent.count
  );

  CMemoryDeallocate(sourceContentBuffer);
}

+ (void)updateNode:(CUnsignedInteger32)nodeID
     styleProperty:(FoundationString*)property
        styleValue:(FoundationString*)value {
  let propertyBuffer = (CInteger32*)CMemoryAllocate(
    property.count * sizeof(CInteger32)
  );
  let valueBuffer = (CInteger32*)CMemoryAllocate(
    value.count * sizeof(CInteger32)
  );
  [property copyCharacters:propertyBuffer];
  [value copyCharacters:valueBuffer];

  JavaScriptCoreNodeUpdateStyleProperty(
    nodeID,
    propertyBuffer,
    property.count,
    valueBuffer,
    value.count
  );

  CMemoryDeallocate(propertyBuffer);
  CMemoryDeallocate(valueBuffer);
}

+ (void)updateNode:(CUnsignedInteger32)nodeID
       textContent:(FoundationString*)textContent {
  let textContentBuffer = (CInteger32*)CMemoryAllocate(
    textContent.count * sizeof(CInteger32)
  );
  [textContent copyCharacters:textContentBuffer];

  JavaScriptCoreNodeUpdateTextContent(
    nodeID,
    textContentBuffer,
    textContent.count
  );

  CMemoryDeallocate(textContentBuffer);
}

@end

C_ASSUME_NONNULL_END
