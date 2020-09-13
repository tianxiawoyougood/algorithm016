//
//  Homework.swift
//  Solution
//
//  Created by sunbinhua on 2020/9/13.
//

import Foundation

//题目中需要的类
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    
    /// 26. 删除排序数组中的重复项
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0
        } else if nums.count == 1 {
            return 1
        }
        var temp = nums.last
        for i in (0...nums.count-2).reversed() {
            if temp == nums[i] {
                nums.remove(at: i);
            } else {
                temp = nums[i];
            }
        }
        return nums.count
    }
    
    /// 189. 旋转数组
    func rotate(_ nums: inout [Int], _ k: Int) {
            if k == 0 {
                return
            }
            var temp1:Int, temp2: Int;
            for _ in 0...k - 1 {
                temp2 = nums[nums.count - 1]
                for j in 0...nums.count - 1 {
                    temp1 = nums[j];
                    nums[j] = temp2;
                    temp2 = temp1;
                }
            }
            
        }
    
    /// 21. 合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var list1: ListNode? = l1
        var list2: ListNode? = l2
        let dummyNode = ListNode(-1)
        var prev = dummyNode
        while list1 != nil && list2 != nil {
            if list1!.val > list2!.val{
                prev.next = list2
                list2 = list2?.next
            } else {
                prev.next = list1
                list1 = list1?.next
            }
            prev = prev.next!
        }
        prev.next = (list1 == nil) ? list2: list1
        return dummyNode.next
        
    }
    
    /// 88. 合并两个有序数组
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
            var i = m - 1, j = n - 1, res = m + n - 1
            while j >= 0 {
                if i >= 0 && nums1[i] > nums2[j] {
                    nums1[res] = nums1[i]
                    i -= 1
                } else {
                    nums1[res] = nums2[j]
                    j -= 1
                }
                res -= 1
            }
        }
    
    ///1. 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
            var result = [Int]()
            if nums.count > 1 {
                var dict = [Int : Int]()
                for i in 0 ..< nums.count {
                    dict[nums[i]] = i
                }
                
                for i in 0 ..< nums.count {
                    let val = target - nums[i]
                    if dict.keys.contains(val) && i != dict[val]! {
                        if dict[val]! > i {
                            result.append(i)
                            result.append(dict[val]!)
                        } else {
                            result.append(dict[val]!)
                            result.append(i)
                        }
                        break
                    }
                }
            }
            return result
        }
    
    /// 283. 移动零
    func moveZeroes(_ nums: inout [Int]) {
            var j = 0
            for i in 0..<nums.count {
                if nums[i] != 0 {
                    nums.swapAt(i, j)
                    j += 1
                }
            }
        }
    
    /// 66. 加一
    func plusOne(_ digits: [Int]) -> [Int] {
            var digits = digits
            for index in stride(from: digits.count - 1, through: 0, by: -1) {
                let result = digits[index] + 1
                if result < 10 {
                    digits[index] = result
                    break
                } else {
                    digits[index] = 0
                    if index == 0 {
                        digits.insert(1, at: 0)
                    }
                }
            }
            return digits
        }
    
    
    /// 42. 接雨水
    func trap(_ height: [Int]) -> Int {
            // 过滤边界条件，三个以下无法形成漏斗接水
            if height.count <= 2 {
                return 0
            }
            var stack = [Int]()
            var sum = 0
            for i in 0..<height.count {
                while !stack.isEmpty && height[i] > height[stack.last!] {
                    // 当前索引
                    let currentIndex = stack.last!
                    while !stack.isEmpty && height[stack.last!] == height[currentIndex] {
                        stack.popLast()
                    }
                    if !stack.isEmpty {
                        let width = i - stack.last! - 1
                        let height = min(height[i], height[stack.last!]) - height[currentIndex]
                        sum += width * height
                    }
                }
                stack.append(i)
            }
            return sum
        }
}


/// 641. 设计循环双端队列
class MyCircularDeque {
    
    let capacity:Int!
    var arr:[Int]!
    var front:Int!
    var rear:Int!
    
    init(_ k: Int) {
        
        capacity = k + 1

        arr = Array(repeating: 0, count: capacity)
        front = 0
        rear = 0
        
        
    }
    
    func insertFront(_ value: Int) -> Bool {
        if (isFull()) {
            return false
        }
        front = (front - 1 + capacity) % capacity
        arr[front] = value
        return true
        
        
    }
    
    func insertLast(_ value: Int) -> Bool {
        if (isFull()) {
            return false
        }
        arr[rear] = value
        rear = (rear + 1) % capacity
        return true
    }
    
    func deleteFront() -> Bool {
        if (isEmpty()) {
            return false
        }
        front = (front + 1) % capacity
        return true
    }
    
    func deleteLast() -> Bool {
        if (isEmpty()) {
            return false
        }
        rear = (rear - 1 + capacity) % capacity
        return true
    }
    
    func getFront() -> Int {
        if (isEmpty()) {
            return -1
        }
        return arr[front]
    }
    
    func getRear() -> Int {
        if (isEmpty()) {
            return -1
        }
        return arr[(rear - 1 + capacity) % capacity]
    }
    
    func isEmpty() -> Bool {
        return front == rear
    }
    
    func isFull() -> Bool {
        return (rear + 1) % capacity == front
    }
}



