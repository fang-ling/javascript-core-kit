/*
 *  JavaScriptCoreContext.h
 *  javascript-core-kit
 *
 *  Created by Fang Ling on 2026/5/16.
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

#import <CKit/CKit.h>
#import <CoreFoundationKit/CoreFoundationKit.h>
#import <FoundationKit/FoundationKit.h>
#import <ObjectiveCKit/ObjectiveCKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * A JavaScript execution environment.
 *
 * You create and use JavaScript contexts to evaluate JavaScript scripts from
 * Objective-C code; to access values that JavaScript defines or calculates; and
 * to make native objects, methods, or functions accessible to JavaScript.
 */
@interface JavaScriptCoreContext: ObjectiveCObject

@property (class, nonatomic, readonly) JavaScriptCoreContext* currentContext;

@property (class, nonatomic, readonly) CFloatingPoint64 windowWidth;

@property (class, nonatomic, readonly) CFloatingPoint64 windowHeight;

+ (CoreFoundationSize)measureTextSize:(FoundationString*)text
                            styleText:(FoundationString*)styleText;

+ (CUnsignedInteger32)makeButtonNode;

+ (CUnsignedInteger32)makeDivisionNode;

+ (CUnsignedInteger32)makeImageNode;

+ (CUnsignedInteger32)makeParagraphNode;

+ (CUnsignedInteger32)makeSpanNode;

+ (void)addClickEventListenerForNode:(CUnsignedInteger32)nodeID;

+ (void)addSubnode:(CUnsignedInteger32)subnodeID
           forNode:(CUnsignedInteger32)nodeID;

+ (void)insertSubnode:(CUnsignedInteger32)subnodeID
              atIndex:(CInteger)index
              forNode:(CUnsignedInteger32)nodeID;

+ (void)removeFromSupernode:(CUnsignedInteger32)supernodeID
                    forNode:(CUnsignedInteger32)nodeID;

+ (void)updateNode:(CUnsignedInteger32)nodeID
         className:(FoundationString*)className;

+ (void)updateNode:(CUnsignedInteger32)nodeID
     sourceContent:(FoundationString*)sourceContent;

+ (void)updateNode:(CUnsignedInteger32)nodeID
     styleProperty:(FoundationString*)property
        styleValue:(FoundationString*)value;

+ (void)updateNode:(CUnsignedInteger32)nodeID
       textContent:(FoundationString*)textContent;

@end

C_ASSUME_NONNULL_END
