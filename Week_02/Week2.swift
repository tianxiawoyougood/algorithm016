//
//  Week2.swift
//  Homework
//
//  Created by sunbinhua on 2020/9/13.
//

import Foundation

/// 题目中使用的类
public class Node {
    public var val: Int
    public var children: [Node]
    public init(_ val: Int) {
        self.val = val
        self.children = []
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

private class Solution {
    
    /// 242. 有效的字母异位词
    func isAnagram(_ s: String, _ t: String) -> Bool {
        return s.sorted() == t.sorted()
    }
    
    /// 1. 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic  = [Int:Int]()
        for (index,n) in nums.enumerated() {
            let complement = target - n
            if dic.keys.contains(complement) && index != dic[complement] {
                return [dic[complement]!,index]
            }
            dic[n] = index
        }
        return []
    }
    
    /// 589. N叉树的前序遍历
    func preorder(_ root: Node?) -> [Int] {
        
        if root == nil {
            return [Int]()
        }
        
        var resultList: [Int] = [Int]()
        
        /// 层序遍历
        /// 先找到父节点
        var nodeList: [Node] = [root!]
        
        while !nodeList.isEmpty {
            
            let rootNode: Node? = nodeList.removeLast()
            resultList.append(rootNode!.val)
            
            if rootNode?.children.count != 0 {
                /// 添加所有子节点
                for node in rootNode!.children.reversed() {
                    nodeList.append(node)
                }
            }
            
        }
        
        return resultList
    }
    
    /// 49. 字母异位词分组
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.count == 0 {
            return []
        }
        if strs.count == 1 {
            return [strs]
        }
        // key: 字符串中每个字母出现的次数组成的字符串，value：异位词数组
        var map: [String: [String]] = [:]
        for str in strs {
            // 字母出现的次数数组，按字母ASCII索引-'a' 保存对应字母出现次数
            var alphabet = [Int](repeating: 0, count: 26)
            let aScalarValue = "a".unicodeScalars.first!.value
            for scalar in str.unicodeScalars {
                alphabet[Int(scalar.value - aScalarValue)] += 1
            }
            // map中没有这个key
            let key = alphabet.description
            if !map.keys.contains(key) {
                map[key] = [String]()
            }
            map[key]!.append(str)
        }
        return Array(map.values)
    }
    
    
    ///94. 二叉树的中序遍历
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        
        var seq: [Int] = []
        seq += inorderTraversal(root.left)
        seq.append(root.val)
        seq += inorderTraversal(root.right)
        
        return seq
    }
    
    
    /// 144. 二叉树的前序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        
        //确保输入不为空
        guard root != nil else { return [] }
        
        //指向树根
        var node: TreeNode? = root
        //用数组模拟一个栈用来存放已经探索过的节点
        var stack: [TreeNode?] = []
        //返回结果
        var output: [Int] = []
        
        while node != nil || !stack.isEmpty {
            
            if node != nil {
                
                output.append(node!.val)    //探索过的节点值用来返回
                stack.append(node)  //将探索过的节点入栈
                
                node = node?.left   //指向左子
            } else {
                
                //将栈顶的节点出栈，然后指向它的右子
                node = stack.removeLast()?.right
            }
        }
        
        return output
    }
    
    ///  429. N叉树的层序遍历
    func levelOrder(_ root: Node?) -> [[Int]] {
        var result = [[Int]]()
        if root == nil {
            return result
        }
        // 辅助存储队列：先进先出
        var queue = [Node]()
        queue.insert(root!, at: 0)
        while !queue.isEmpty {
            // 单行数组
            var level = [Int]()
            // 单行个数
            let count = queue.count
            // 遍历单行节点
            for _ in 0..<count {
                // 尾出
                let current = queue.popLast()
                level.append(current!.val)
                if !current!.children.isEmpty {
                    // 子节点 头插队列
                    for child in current!.children {
                        queue.insert(child, at: 0)
                    }
                }
            }
            result.append(level)
        }
        return result
    }
    
    
    /// 剑指 Offer 49. 丑数
    func nthUglyNumber(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }
        var count2 = 0
        var count3 = 0
        var count5 = 0
        var uglyNums = [1]
        while uglyNums.count < n {
            uglyNums.append(min(min(uglyNums[count2] * 2, uglyNums[count3] * 3), uglyNums[count5] * 5))
            while uglyNums[count2] * 2 <= uglyNums.last! {
                count2 += 1
            }
            while uglyNums[count3] * 3 <= uglyNums.last! {
                count3 += 1
            }
            while uglyNums[count5] * 5 <= uglyNums.last! {
                count5 += 1
            }
        }
        return uglyNums.last!
    }
    
    
    /// 347. 前 K 个高频元素
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        return nums.reduce(into: [:]) { (parames, number) in
            parames[number,default: 0] += 1
        }.sorted(by: {$0.value > $1.value}).prefix(k).map{$0.key}
    }
}
