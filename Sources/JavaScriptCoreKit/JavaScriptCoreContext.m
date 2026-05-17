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

extern CUnsignedInteger32 JavaScriptCoreNodeInitializeDivisionNode();

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

extern CFloatingPoint64 JavaScriptCoreWindowGetWidth();

extern CFloatingPoint64 JavaScriptCoreWindowGetHeight();

@implementation JavaScriptCoreContext

+ (CFloatingPoint64)windowWidth {
  return JavaScriptCoreWindowGetWidth();
}

+ (CFloatingPoint64)windowHeight {
  return JavaScriptCoreWindowGetHeight();
}

+ (CUnsignedInteger32)makeDivisionNode {
  return JavaScriptCoreNodeInitializeDivisionNode();
}

+ (void)addSubnode:(CUnsignedInteger32)subnodeID
           forNode:(CUnsignedInteger32)nodeID {
  JavaScriptCoreNodeAddSubnode(nodeID, subnodeID);
}

+ (void)updateNode:(CUnsignedInteger32)nodeID
     styleProperty:(FoundationString *)property
        styleValue:(FoundationString *)value {
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

@end

C_ASSUME_NONNULL_END

//#if canImport(Darwin)
//import Darwin
//#elseif canImport(WASILibc)
//import WASILibc
//#endif
//
//import FoundationFramework
//
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
//@_extern(wasm, module: "env", name: "JavaScriptBridge_UpdateElementTextContent")
//func JavaScriptBridge_UpdateElementTextContent(
//  elementIDString: UnsafePointer<Integer32>,
//  elementIDStringCount: UnsignedInteger64,
//  textString: UnsafePointer<Integer32>,
//  textStringCount: UnsignedInteger64
//)
//
//@_extern(wasm, module: "env", name: "JavaScriptBridge_AddElementEventListener")
//func JavaScriptBridge_AddElementEventListener(
//  elementIDString: UnsafePointer<Integer32>,
//  elementIDStringCount: UnsignedInteger64,
//  eventType: UnsignedInteger32
//)
//
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
//  public static func removeElementStyleProperty(
//    elementID: UUID,
//    property: String
//  ) {
//    let elementIDString = elementID.uuidString
//
//    JavaScriptBridge_RemoveElementStyleProperty(
//      elementIDString: elementIDString.charactersView,
//      elementIDStringCount: elementIDString.count,
//      propertyString: property.charactersView,
//      propertyStringCount: property.count,
//    )
//  }
//  public static func updateElementTextContent(elementID: UUID, text: String) {
//    let elementIDString = elementID.uuidString
//
//    JavaScriptBridge_UpdateElementTextContent(
//      elementIDString: elementIDString.charactersView,
//      elementIDStringCount: elementIDString.count,
//      textString: text.charactersView,
//      textStringCount: text.count
//    )
//  }
//
//  public static func addElementEventListener(
//    elementID: UUID,
//    eventTypeRawValue: UnsignedInteger32
//  ) {
//    let elementIDString = elementID.uuidString
//
//    JavaScriptBridge_AddElementEventListener(
//      elementIDString: elementIDString.charactersView,
//      elementIDStringCount: elementIDString.count,
//      eventType: eventTypeRawValue
//    )
//  }
//}
