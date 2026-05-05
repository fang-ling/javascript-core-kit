//
//  JavaScriptCoreKit.js
//  javascript-core-kit
//
//  Created by Fang Ling on 2026/4/4.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

let _instance
let _memory
let nodes
let eventListeners

function readString(string, count) {
  const characters = new Uint32Array(
    _memory.buffer,
    string,
    Number(count)
  )
  return String.fromCodePoint(...characters)
}

function getNode(nodeID) {
  if (nodeID === 0) {
    return document.body
  }

  return nodes.get(nodeID)
}

//function _JavaScriptCore_Element_Initialize(elementType) {
//  const element = document.createElement(elementType)
//  element.className = "view"
//  elements.push(element)
//
//  return elements.length
//}

//export function JavaScriptCore_Initialize(instance, memory) {
//  _instance = instance
//  _memory = memory
//  elements = []
//  eventListeners = new Map()
//}

//export function JavaScriptCore_Element_InitializeDivision() {
//  return _JavaScriptCore_Element_Initialize("div")
//}
//
//export function JavaScriptBridge_GetWindowWidth() {
//  return window.innerWidth
//}
//
//export function JavaScriptBridge_GetWindowHeight() {
//  return window.innerHeight
//}
//
//export function JavaScriptBridge_MeasureTextSize(
//  textString,
//  textStringCount,
//  styleTextString,
//  styleTextStringCount,
//  result
//) {
//  const element = document.createElement("div")
//  element.textContent = readString(textString, textStringCount)
//  element.style.cssText = "position:absolute; " +
//                          "visibility:hidden; " +
//                          "pointer-events:none; " +
//                          "white-space: pre; " +
//                          readString(styleTextString, styleTextStringCount)
//  document.body.appendChild(element)
//
//  const { width, height } = element.getBoundingClientRect()
//
//  const memoryView = new Float64Array(_memory.buffer)
//  memoryView[result / 8] = width
//  memoryView[result / 8 + 1] = height
//
//  element.remove()
//}
//
//export function JavaScriptBridge_SetElementStyleProperty(
//  elementIDString,
//  elementIDStringCount,
//  propertyString,
//  propertyStringCount,
//  valueString,
//  valueStringCount
//) {
//  const elementID = readString(elementIDString, elementIDStringCount)
//
//  getElement(elementID)?.style.setProperty(
//    readString(propertyString, propertyStringCount),
//    readString(valueString, valueStringCount)
//  )
//}
//
//export function JavaScriptBridge_RemoveElementStyleProperty(
//  elementIDString,
//  elementIDStringCount,
//  propertyString,
//  propertyStringCount
//) {
//  const elementID = readString(elementIDString, elementIDStringCount)
//
//  getElement(elementID)?.style.removeProperty(
//    readString(propertyString, propertyStringCount)
//  )
//}

export function JavaScriptCoreDOMNodeAddSubnode(nodeID, subnodeID) {
  const node = getElement(nodeID)
  const subnode = getElement(subnodeID)

  node.appendChild(subnode)
}

//export function JavaScriptBridge_UpdateElementTextContent(
//  elementIDString,
//  elementIDStringCount,
//  textString,
//  textStringCount
//) {
//  const elementID = readString(elementIDString, elementIDStringCount)
//
//  getElement(elementID).textContent = readString(textString, textStringCount)
//}
//
//export function JavaScriptBridge_AddElementEventListener(
//  elementIDString,
//  elementIDStringCount,
//  eventType
//) {
//  const elementID = readString(elementIDString, elementIDStringCount)
//  const eventTypeString = (() => {
//    switch (eventType) {
//      case 1: return "click" // touchUpInside
//    }
//  })()
//
//  const eventHandler = () => {
//    const characters = [...elementID].map((c) => c.codePointAt(0))
//    const buffer = _instance.exports.JavaScriptBridge_Allocate(144)
//    new Uint32Array(_memory.buffer, buffer, 36).set(characters)
//
//    _instance.exports.UIFramework_DispatchElementEvent(buffer, 36n, eventType)
//
//    _instance.exports.JavaScriptBridge_Deallocate(buffer)
//  }
//
//  if (!eventListeners.has(elementID)) {
//    eventListeners.set(elementID, new Map())
//  }
//  eventListeners.get(elementID).set(eventType, eventHandler)
//
//  getElement(elementID)?.addEventListener(eventTypeString, eventHandler)
//}
