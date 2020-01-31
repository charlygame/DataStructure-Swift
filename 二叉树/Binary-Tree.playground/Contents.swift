import UIKit

class BinaryNode {
    var leftPtr: BinaryNode? = nil
    var rightPtr: BinaryNode? = nil
    var value: Int = -1
    
    public func setLeftNode(node: BinaryNode?) -> Void {
        leftPtr = node
    }
    
    public func setRightNode(node: BinaryNode?) -> Void {
        rightPtr = node
    }
    
    public func setValue(v: Int) -> Void {
        value = v
    }
}

class BinaryTree {
    
    static var root: BinaryNode? = nil
    static var curIdx: Int = 1
    static var count: Int = 0
    
    enum NodePos {
        case left
        case right
    }
    
    
    static func create (count: Int) {
        BinaryTree.count = count
        BinaryTree.root = BinaryTree.createNode(parent: BinaryTree.root, pos: NodePos.left)
    }
    // 二叉树创建结点
    static func createNode(parent:  BinaryNode?, pos: NodePos) -> BinaryNode? {
        var n = parent
        var result: BinaryNode? = nil
        if n == nil {
            n = BinaryNode()
            n?.setValue(v: 1)
            n?.setLeftNode(node: createNode(parent: n, pos: .left))
            n?.setRightNode(node: createNode(parent: n, pos: .right))
            result = n
        } else {
            switch pos {
            case .left:
                if parent!.value * 2 <= BinaryTree.count {
                    result = BinaryNode()
                    result?.setValue(v: parent!.value * 2)
                    result?.setLeftNode(node: createNode(parent: result, pos: .left))
                    result?.setRightNode(node: createNode(parent: result, pos: .right))
                }
            case .right:
                if parent!.value * 2 + 1 <= BinaryTree.count {
                    result = BinaryNode()
                    result?.setValue(v: parent!.value * 2 + 1)
                    result?.setLeftNode(node: createNode(parent: result, pos: .left))
                    result?.setRightNode(node: createNode(parent: result, pos: .right))
                }

            default:
                break
            }
            
        }
        return result
    }
    // 前序遍历
    static func preOrderTraverse (node: BinaryNode?) {
        if node == nil {
            return;
        }
        print("\(node!.value)")
        preOrderTraverse(node: node?.leftPtr)
        preOrderTraverse(node: node?.rightPtr)
    }
    // 中序遍历
    static func midOrderTraverse (node: BinaryNode?) {
        if node == nil {
            return;
        }
        midOrderTraverse(node: node?.leftPtr)
        print("\(node!.value)")
        midOrderTraverse(node: node?.rightPtr)
    }
    // 后序遍历
    static func postOrderTraverse (node: BinaryNode?) {
        if node == nil {
            return;
        }
        postOrderTraverse(node: node?.leftPtr)
        postOrderTraverse(node: node?.rightPtr)
        print("\(node!.value)")
    }
}

BinaryTree.create(count: 10)
print("###### 前序遍历 #######")
BinaryTree.preOrderTraverse(node: BinaryTree.root)
print("###### 中序遍历 #######")
BinaryTree.midOrderTraverse(node: BinaryTree.root)
print("###### 后序遍历 #######")
BinaryTree.postOrderTraverse(node: BinaryTree.root)
