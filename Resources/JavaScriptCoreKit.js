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
let nodeIndex
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

function JavaScriptCoreNodeInitialize(nodeType) {
  nodeIndex += 1

  const node = document.createElement(nodeType)
  node.className = "view"
  nodes.set(nodeIndex, node)

  return nodeIndex
}

export function JavaScriptCoreInitialize(instance, memory) {
  _instance = instance
  _memory = memory
  nodes = new Map()
  nodeIndex = 0
  eventListeners = new Map()
}

export function JavaScriptCoreWindowGetWidth() {
  return window.innerWidth
}

export function JavaScriptCoreWindowGetHeight() {
  return window.innerHeight
}

export function JavaScriptCoreMeasureTextSize(
  textBuffer,
  textBufferCount,
  styleTextBuffer,
  styleTextBufferCount,
  result
) {
  const element = document.createElement("div")
  element.textContent = readString(textBuffer, textBufferCount)
  element.style.cssText = "position:absolute; " +
                          "visibility:hidden; " +
                          "pointer-events:none; " +
                          "white-space: pre; " +
                          readString(styleTextBuffer, styleTextBufferCount)
  document.body.appendChild(element)

  const { width, height } = element.getBoundingClientRect()

  const memoryView = new Float32Array(_memory.buffer)
  memoryView[result / 4] = width
  memoryView[result / 4 + 1] = height

  element.remove()
}

export function JavaScriptCoreNodeInitializeButtonNode() {
  return JavaScriptCoreNodeInitialize("button")
}

export function JavaScriptCoreNodeInitializeDivisionNode() {
  return JavaScriptCoreNodeInitialize("div")
}

export function JavaScriptCoreNodeInitializeImageNode() {
  return JavaScriptCoreNodeInitialize("img")
}

export function JavaScriptCoreNodeInitializeParagraphNode() {
  return JavaScriptCoreNodeInitialize("p")
}

export function JavaScriptCoreNodeInitializeSpanNode() {
  return JavaScriptCoreNodeInitialize("span")
}

export function JavaScriptCoreNodeAddSubnode(nodeID, subnodeID) {
  const node = getNode(nodeID)
  const subnode = getNode(subnodeID)

  node.appendChild(subnode)
}

export function JavaScriptCoreNodeInsertSubnodeAtIndex(
  nodeID,
  subnodeID,
  index
) {
  const node = getNode(nodeID)
  const subnode = getNode(subnodeID)

  node.insertBefore(subnode, node.childNodes[index]);
}

export function JavaScriptCoreNodeRemoveFromSupernode(supernodeID, nodeID) {
  const supernode = getNode(supernodeID)
  const node = getNode(nodeID)

  supernode.removeChild(node)
}

export function JavaScriptCoreNodeUpdateClassName(
  nodeID,
  classNameBuffer,
  classNameBufferCount
) {
  const node = getNode(nodeID)
  if (!node) {
    return
  }

  node.className = readString(classNameBuffer, classNameBufferCount)
}

export function JavaScriptCoreNodeUpdateStyleProperty(
  nodeID,
  propertyBuffer,
  propertyBufferCount,
  valueBuffer,
  valueBufferCount
) {
  getNode(nodeID)?.style.setProperty(
    readString(propertyBuffer, propertyBufferCount),
    readString(valueBuffer, valueBufferCount)
  )
}

export function JavaScriptCoreNodeUpdateTextContent(
  nodeID,
  textContentBuffer,
  textContentBufferCount
) {
  const node = getNode(nodeID)
  if (!node) {
    return
  }

  node.textContent = readString(textContentBuffer, textContentBufferCount)
}

export function JavaScriptCoreNodeAddClickEventListener(nodeID) {
  if (!eventListeners.has(nodeID)) {
    eventListeners.set(nodeID, new Map())
  }

  const eventHandler = () => {
    _instance.exports.UIKitDispatchControlEvent(nodeID, 1)
  }

  eventListeners.get(nodeID).set("click", eventHandler)
  getNode(nodeID)?.addEventListener("click", eventHandler)
}
