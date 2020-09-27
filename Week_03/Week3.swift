//
//  Week3.swift
//  Homework
//
//  Created by sunbinhua on 2020/9/26.
//

import Foundation

private class Solution {
    
    /*
     * @lc app=leetcode.cn id=236 lang=swift
     *
     * [236] 二叉树的最近公共祖先
     */
    
    var ans:TreeNode?
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        if self.dfs(root, p, q) {
            return self.ans
        }
        return nil
    }
    
    func dfs(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if root == nil {
            return false
        }
        let left = dfs(root?.left, p, q)
        let right = dfs(root?.right, p, q)
        
        if (left && right) || ((p?.val == root?.val || q?.val == root?.val) && (left || right)) {
            self.ans = root;
        }
        return left || right || (p?.val == root?.val || q?.val == root?.val)
    }
    
    /*
     * @lc app=leetcode.cn id=105 lang=swift
     *
     * [105] 从前序与中序遍历序列构造二叉树
     */
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        func preorderTraversal( preorder: [Int],  inorder: [Int],preStart: Int,preEnd:Int,inStart: Int,inEnd:Int,inMap:[Int:Int])  -> TreeNode?  {
            guard preStart <= preEnd && preStart <= preEnd else {
                return nil
            }
            
            let treeVal = preorder[preStart]
            let node = TreeNode(treeVal)
            let inIndex = inMap[treeVal]!
            
            node.left = preorderTraversal(preorder: preorder, inorder: inorder, preStart: preStart + 1, preEnd: preStart + inIndex - inStart, inStart: inStart, inEnd: inIndex - 1, inMap: inMap)
            node.right = preorderTraversal(preorder: preorder, inorder: inorder, preStart:  preStart + inIndex - inStart + 1, preEnd: preEnd, inStart: inIndex + 1, inEnd: inEnd, inMap: inMap)
            return node
        }
        
        var inMap = [Int:Int]()
        for (index,value) in inorder.enumerated() {
            inMap[value] = index
        }
        return preorderTraversal(preorder: preorder, inorder: inorder, preStart: 0, preEnd: preorder.count - 1, inStart: 0, inEnd: inorder.count - 1, inMap: inMap)
    }
    
    /*
     * @lc app=leetcode.cn id=77 lang=swift
     *
     * [77] 组合
     */
    fileprivate var res = [[Int]]()
    func bt(_ n:Int, _ count:Int, _ t:[Int]){
        let tLen = t.count
        if tLen == count {
            res.append(t);
            return;
        }
        
        let minT = t.count > 0 ? t.last!+1 : 1
        if minT > n || n-minT+1 < count-tLen {return;}
        var tmp = t
        
        for i in minT ... n {
            tmp.append(i)
            bt(n,count,tmp)
            tmp.removeLast()
        }
    }
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        let tmp = [Int]()
        bt(n, k, tmp)
        return res
    }
    
    /*
     * @lc app=leetcode.cn id=46 lang=swift
     *
     * [46] 全排列
     */
    
    func permute(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else { return [nums] }
        var tmpNums = nums
        let l = tmpNums.removeLast()
        let array = permute(tmpNums)
        return array.reduce(into: [[Int]]()) { (result, element) in
            for i in element.startIndex...element.endIndex {
                var tmpElement = element
                tmpElement.insert(l, at: i)
                result.append(tmpElement)
            }
        }
    }
    
    /*
     * @lc app=leetcode.cn id=47 lang=swift
     *
     * [47] 全排列 II
     */
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        //首先进行排序，然后
        if nums.count == 0 {
            return []
        }
        var result = [[Int]]()
        //used用来记录当前哪个参数已经被使用
        var used = [Bool](repeating: false, count: nums.count)
        //stack用来记录当前添加进入的值
        var stack = [Int]()
        self.permuteUniqueDFS(nums.sorted(), &result, &used, &stack)
        return result
    }
    
    func permuteUniqueDFS(_ nums: [Int], _ result: inout [[Int]], _ used: inout [Bool], _ stack: inout [Int]){
        if stack.count == nums.count {
            result.append(stack)
            return
        }
        for (i, item) in nums.enumerated() {
            /*
             剪枝条件1：
             搜索起点与上一次搜索的起点一样
             */
            if used[i] == true {
                continue
            }
            /*
             剪枝条件2：（之前已经进行了排序，所以此处可以直接拿i与i-1位进行比较）
             第i与第i-1位相同，且第i-1位未被使用
             此处可以这么理解：
             当前搜索的数字和上次的一样，但是上一次的刚被撤销，正是因为刚被撤销，下面的搜索还会被用到，因此会产生重复，那么就应该剪枝
             */
            if i > 0 && nums[i] == nums[i-1] && used[i-1]==false {
                continue
            }
            stack.append(item)
            used[i] = true
            self.permuteUniqueDFS(nums, &result, &used, &stack)
            stack.removeLast()
            used[i] = false
        }
    }
    
}
