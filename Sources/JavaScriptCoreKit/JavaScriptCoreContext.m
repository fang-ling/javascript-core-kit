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

C_ASSUME_NONNULL_BEGIN

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeButtonNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeDivisionNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeParagraphNode();

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeSpanNode();

extern void JavaScriptCoreNodeAddClickEventListener(CUnsignedInteger32 nodeID);

extern void JavaScriptCoreNodeAddSubnode(
  CUnsignedInteger32 nodeID,
  CUnsignedInteger32 subnodeID
);

extern void JavaScriptCoreNodeUpdateStyleProperty(
  CUnsignedInteger32 nodeID,
  CInteger32* propertyBuffer,
  CUnsignedInteger64 propertyBufferCount,
  CInteger32* valueBuffer,
  CUnsignedInteger64 valueBufferCount
);

extern void JavaScriptCoreNodeUpdateTextContent(
  CUnsignedInteger32 nodeID,
  CInteger32* textContentBuffer,
  CUnsignedInteger64 textContentBufferCount
);

extern CFloatingPoint64 JavaScriptCoreWindowGetWidth();

extern CFloatingPoint64 JavaScriptCoreWindowGetHeight();

@implementation JavaScriptCoreContext

+ (CFloatingPoint64)windowWidth {
  return JavaScriptCoreWindowGetWidth();
}

+ (CFloatingPoint64)windowHeight {
  return JavaScriptCoreWindowGetHeight();
}

+ (CUnsignedInteger32)makeButtonNode {
  return JavaScriptCoreNodeInitializeButtonNode();
}

+ (CUnsignedInteger32)makeDivisionNode {
  return JavaScriptCoreNodeInitializeDivisionNode();
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
  CMemoryDeallocate(propertyBuffer);
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

//@_expose(wasm, "JavaScriptBridge_Allocate")
//@_cdecl("JavaScriptBridge_Allocate")
//@available(macOS 13.3.0, *)
//func JavaScriptBridge_Allocate(size: Integer32) -> UnsafeMutableRawPointer {
//  return malloc(Int(size))
//}
//
//@_expose(wasm, "JavaScriptBridge_Deallocate")
//@_cdecl("JavaScriptBridge_Deallocate")
//@available(macOS 13.3.0, *)
//func JavaScriptBridge_Deallocate(pointer: UnsafeMutableRawPointer) {
//  free(pointer)
//}
//@_extern(wasm, module: "env", name: "JavaScriptBridge_MeasureTextSize")
//func JavaScriptBridge_MeasureTextSize(
//  textString: UnsafePointer<Integer32>,
//  textStringCount: UnsignedInteger64,
//  styleTextString: UnsafePointer<Integer32>,
//  styleTextStringCount: UnsignedInteger64,
//  result: UnsafeMutablePointer<FloatingPoint64>
//)
//@available(macOS 13.3.0, *)
//public enum JavaScriptBridge {
//  public static func measureTextSize(
//    text: String,
//    styleText: String
//  ) -> Size {
//    let result = UnsafeMutablePointer<FloatingPoint64>.allocate(capacity: 2)
//    defer { result.deallocate() }
//
//    JavaScriptBridge_MeasureTextSize(
//      textString: text.charactersView,
//      textStringCount: text.count,
//      styleTextString: styleText.charactersView,
//      styleTextStringCount: styleText.count,
//      result: result
//    )
//
//    return .init(width: result[0], height: result[1])
//  }
//}
