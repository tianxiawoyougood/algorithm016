//
//  Week4.swift
//  Homework
//
//  Created by sunbinhua on 2020/9/29.
//

import Foundation

private class Solution {
    
    /*
     * @lc app=leetcode.cn id=860 lang=swift
     *
     * [860] 柠檬水找零
     */
    func lemonadeChange(_ bills: [Int]) -> Bool {
        var array = [0,0,0]
        
        for bill in bills {
            if bill == 5 {
                array[0] += 1
            } else if bill == 10 {
                if array[0] == 0 {
                    return false
                }
                array[0] -= 1
                array[1] += 1
                
            } else {
                array[0] -= 1
                if array[0] < 0 {
                    return false
                }
                
                //! 找零 10块,直接换 10元， 或者 两个 5 块的
                if array[1] > 0 {
                    array[1] -= 1
                } else if array[0] >= 2 {
                    array[0] -= 2
                } else {
                    return false
                }
                
            }
            
        }
        
        return true
    }
    
    /*
     * @lc app=leetcode.cn id=122 lang=swift
     *
     * [122] 买卖股票的最佳时机 II
     */
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 {
            return 0
        }
        
        //！ 只要第二天的比当前的高，就今天低点买入，然后第二天高点抛出，短期做T
        var maxprofit = 0
        for i in 0..<prices.count-1 {
            if prices[i+1] > prices[i] {
                maxprofit += prices[i+1] - prices[i]
            }
        }
        
        return maxprofit
    }
    
    /*
     * @lc app=leetcode.cn id=455 lang=swift
     *
     * [455] 分发饼干
     */
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        let g = g.sorted()
        let s = s.sorted()
        var res = 0
        
        var g_index = 0
        var s_index = 0
        
        while g_index < g.count && s_index < s.count {
            if g[g_index] <= s[s_index] {
                //! 当前饼干可以满足小朋友，喂给他
                res += 1
                g_index += 1
                s_index += 1
            } else {
                //! 不满足，看下一块
                s_index += 1
            }
        }
        return res
    }
    
    /*
     * @lc app=leetcode.cn id=874 lang=swift
     *
     * [874] 模拟行走机器人
     */
    let dx = [0,1,0,-1]
    let dy = [1,0,-1,0]
    func robotSim(_ commands: [Int], _ obstacles: [[Int]]) -> Int {
        var obstacleSet = Set<Int>()
        
        for obstacle in obstacles {
            let ox = obstacle[0] + 30000
            let oy = obstacle[1] + 30000
            obstacleSet.insert( ox<<16 + oy)
        }
        
        var ans = 0
        
        var x = 0
        var y = 0
        var di = 0
        
        for cmd in commands {
            if cmd == -2 {
                di = (di+3)%4
            } else if cmd == -1 {
                di = (di+1)%4
            } else {
                
                for k in 0..<cmd {
                    let nx = x + dx[di]
                    let ny = y + dy[di]
                    let code = (nx + 30000)<<16 + (ny + 30000)
                    if !obstacleSet.contains(code) {
                        x = nx
                        y = ny
                        ans = max(ans, x*x+y*y)
                    }
                }
            }
        }
        
        return ans
    }
    
    /*
     * @lc app=leetcode.cn id=127 lang=swift
     *
     * [127] 单词接龙
     */
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        // 处理 list
        if !wordList.contains(endWord){
            return 0
        }
        
        let dict = Set(wordList)
        var beginSet = Set<String>()
        var endSet = Set<String>()
        var visitedSet = Set<String>()
        var length = 1
        var found = false
        
        beginSet.insert(beginWord)
        endSet.insert(endWord)
        
        while !found && !beginSet.isEmpty && !endSet.isEmpty {
            var nextSet = Set<String>()
            //accelerating search speed by swap begin and end
            if beginSet.count > endSet.count {
                swap(&beginSet, &endSet)
            }
            found = helper(beginSet, endSet, dict, &visitedSet, &nextSet)
            beginSet = nextSet
            length += 1
        }
        return found ? length : 0
    }
    
    private func helper(_ beginSet: Set<String>, _ endSet: Set<String>, _ dict: Set<String>,
                        _ visitedSet: inout Set<String>, _ resSet: inout Set<String>) -> Bool {
        
        let alphaArray = Array("abcdefghijklmnopqrstuvwxyz")
        
        for word in beginSet {
            for i in 0 ..< word.count {
                var chars = Array(word)
                for j in 0 ..< alphaArray.count{
                    chars[i] = alphaArray[j]
                    let str = String(chars)
                    if dict.contains(str) {
                        if endSet.contains(str)
                        {
                            return true
                        }
                        if !visitedSet.contains(str)
                        {
                            resSet.insert(str)
                            visitedSet.insert(str)
                        }
                    }
                }
            }
        }
        return false
    }
    /*
     * @lc app=leetcode.cn id=200 lang=swift
     *
     * [200] 岛屿数量
     */
    func numIslands(_ grid: [[Character]]) -> Int {
        if grid.count == 0 || grid[0].count == 0 { return 0 }
        var res = 0, grid = grid
        
        func dfs(_ i: Int, _ j: Int) {
            if i < 0 || i >= grid.count || j < 0 || j >= grid[0].count {
                return
            }
            if grid[i][j] != "1" {
                return
            }
            // 做标记
            grid[i][j] = "0"
            // 上下左右进行递归标记
            dfs(i - 1, j)
            dfs(i + 1, j)
            
            dfs(i, j - 1)
            dfs(i, j + 1)
        }
        
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                if grid[i][j] == "1" {
                    dfs(i, j)
                    res += 1
                }
            }
        }
        
        return res
    }
    
    /*
     * @lc app=leetcode.cn id=529 lang=swift
     *
     * [529] 扫雷游戏
     */
    let dirX:[Int] = [0, 1, 0, -1, 1, 1, -1, -1]
    let dirY:[Int] = [1, 0, -1, 0, 1, -1, 1, -1]
    
    
    func updateBoard(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
        
        
        
        var result:[[Character]] = board
        
        let x = click[0]
        let y = click[1]
        
        if (result[x][y] == "M") {
            ///规则1
            result[x][y] = "X"
        } else {
            dfs(&result, x: x, y: y)
        }
        return result
    }
    
    func dfs(_  board: inout [[Character]], x:Int, y:Int) {
        
        var cnt = 0
        for i in 0..<8 {
            let tx = x + dirX[i];
            let ty = y + dirY[i];
            
            if (tx < 0 || tx >= board.count || ty < 0 || ty >= board[0].count) {
                continue
            }
            
            if (board[tx][ty] == "M") {
                cnt+=1
            }
        }
        
        if (cnt > 0) {
            ///规则3
            board[x][y] = Character.init("\(cnt)")
        }else {
            ///规则2
            board[x][y] = "B"
            for i in 0..<8 {
                let tx = x + dirX[i]
                let ty = y + dirY[i]
                ///这里不需要在存在B的时候继续扩展 因为B之前被点击的时候 已经被扩展过了
                if (tx < 0 || tx >= board.count || ty < 0 || ty >= board[0].count || board[tx][ty] != "E") {
                    continue
                }
                dfs(&board, x: tx, y: ty)
            }
            
        }
    }
    
    
    /*
     * @lc app=leetcode.cn id=55 lang=swift
     *
     * [55] 跳跃游戏
     */
    func canJump(_ nums: [Int]) -> Bool {
        let count = nums.count
        var distance = 0
        for i in 0..<count {
            guard i <= distance else{
                return false
            }
            distance = max(distance,nums[i]+i)
            if distance >= count - 1 {
                return true
            }
        }
        return true
    }
    
    /*
     * @lc app=leetcode.cn id=33 lang=swift
     *
     * [33] 搜索旋转排序数组
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty {
            return -1
        }
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = (l + r) >> 1
            if nums[mid] == target {
                return mid
            }
            //判断前半部分是否是递增的
            if nums[l] <= nums[mid] {
                if nums[l] <= target && nums[mid] > target {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if nums[mid] < target && nums[r] >= target {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return -1
    }
    
    /*
     * @lc app=leetcode.cn id=74 lang=swift
     *
     * [74] 搜索二维矩阵
     */
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let n = matrix.count
        if n == 0 {
            return false
        }
        let m = matrix.first!.count
        if m == 0 {
            return false
        }
        if matrix[n - 1][m - 1] < target {
            return false
        }
        var start = 0, end = m * n - 1
        while start <= end {
            let mid = start + (end - start) / 2
            //一维转二维下标
            let x = mid % m
            let y = mid / m
            if matrix[y][x] == target {
                return true
            } else if matrix[y][x] > target {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        return false
    }
    
    /*
     * @lc app=leetcode.cn id=153 lang=swift
     *
     * [153] 寻找旋转排序数组中的最小值
     */
    func findMin(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            
            let mid = (left + right) / 2
            
            if nums[mid] > nums[right] {
                
                left = mid + 1
                
            } else if nums[mid] < nums[right] {
                right = mid
            } else {
                
                right -= 1
            }
            
        }
        
        
        return nums[left]
    }
    /*
     * @lc app=leetcode.cn id=45 lang=swift
     *
     * [45] 跳跃游戏 II
     */
    func jump(_ nums: [Int]) -> Int {
        let count = nums.count
        var maxPosition = 0
        var step = 0
        var end = 0
        for i in 0..<(count - 1) {
            maxPosition = max(maxPosition,nums[i]+i)
            if i == end{
                end = maxPosition
                step += 1
            }
            //优化：提前结束
            if maxPosition >= count - 1{
                if end < count - 1{
                    step += 1
                }
                break
            }
        }
        return step
    }
    
    
}
