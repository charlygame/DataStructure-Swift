import UIKit


enum NodeColor {
    case black
    case red
}

class Node {
    
    var id: String = ""
    var value: Int = -1
    var color: NodeColor = .black
    var left: Node? = nil
    var right: Node? = nil
    var parent: Node? = nil
    
    init(id: String, value: Int, color: NodeColor) {
        self.id = id
        self.value = value
        self.color = .black
    }
}

class RedBlackTree {
    
    var root: Node? = nil
    static var id: Int = 1
    
    static func genNodeId() -> String {
        RedBlackTree.id += 1
        return "\(RedBlackTree.id)"
    }
    // 左旋
    func rotateLeft(node: Node?) -> Void {
        
        if node == nil {
            return
        }
        let rChild = node?.right
        if let left = rChild?.left {
            left.parent = node
        }
        rChild?.parent = node?.parent
        if node?.parent != nil {
            if node?.id == node?.parent?.left?.id { // 左节点
                node?.parent?.left = rChild
            } else {    // 右节点
                node?.parent?.right = rChild
            }
        } else {
            self.root = rChild
        }
        rChild?.left = node
        node?.parent = rChild
    }
    // 右旋
    func rotateRight(node: Node?) -> Void {
        
        if node == nil {
            return
        }
        let lChild = node?.left
        if let right = lChild?.right {
            right.parent = node
        }
        lChild?.parent = node?.parent
        if node?.parent != nil {
            if node?.id == node?.parent?.left?.id {  // 左节点
                node?.parent?.left = lChild
            } else {
                node?.parent?.right = lChild
            }
        } else {
            self.root = lChild
        }
        lChild?.right = node
        node?.parent = lChild
    }
    
    // 插入
    func insert(id: String, value: Int) -> Void {
        
        var newNode = Node(id: id, value: value, color: .red)
        let parent = nil
        
        if self.root != nil {
            var node = self.root
            while node {
                parent = node
                if value > node?.value {
                    node = node?.right
                } else {
                    node = node?.left
                }
            }
            newNode.parent = parent
            if newNode.value < parent.value {
                parent.left = newNode
            } else {
                parent.right = newNode
            }
            self.blanceInsert(node: newNode)
            
        } else {
            newNode.color = .black
            self.root = newNode
        }
    }
    // 平衡插入
    func blanceInsert(node: Node?) -> Void {
        
        while (node?.parent && node?.parent?.color == .red) {
            
            if node?.parent?.parent?.left.id == node?.parent.id {  // 是否为左节点
                let uncle = node?.parent?.parent?.right
                if uncle?.color == .red {
                    node?.parent?.color = .black
                    uncle?.color = .black
                    node?.parent?.parent?.color = .red
                    node = node?.parent?.parent
                    continue
                } else { // 叔节点是黑色
                    if node?.parent?.left.id != node?.id { // 插入节点是右节点
                        node = node?.parent
                        self.rotateLeft(node: node?.parent)
                    }
                    node?.parent?.color = .black
                    node?.parent?.parent?.color = .red
                    // 右转祖父节点
                    self.rotateRight(node: node?.parent?.parent)
                }
            } else { // 父节点是右节点
                let uncle = node?.parent?.parent?.left
                if uncle?.color == .red {
                    node?.parent?.color = .black
                     uncle?.color = .black
                     node?.parent?.parent?.color = .red
                     node = node?.parent?.parent
                    continue
                } else {
                    if node?.parent?.right.id != node?.id { // 插入节点是左节点
                        node = node?.parent
                        self.rotateRight(node: node?.parent)
                    }
                    node?.parent?.color = .black
                    node?.parent?.parent?.color = .red
                    // 右转祖父节点
                    self.rotateLeft(node: node?.parent?.parent)
                }
            }
        }
        self.root?.color = .black 
    }
}
