/*
You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

Return true if you can reach the last index, or false otherwise.

Example 1:

Input: nums = [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.

Example 2:

Input: nums = [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.
 
Constraints:

1 <= nums.length <= 10^4
0 <= nums[i] <= 10^5
*/

// Greedy
func canJump(_ nums: [Int]) -> Bool {
    var goal = nums.count - 1
    for i in stride(from: nums.count - 1, through: 0, by: -1) where i < nums.count - 1 {
        if i + nums[i] >= goal {
          goal = i
        }
    }
    return goal == 0
}

// DP (Bottom Up)
func canJump(_ nums: [Int]) -> Bool {
    var table: [Bool] = Array(repeating: false, count: nums.count)
    table[0] = true

    outerLoop: for i in nums.indices {
        let jumps = nums[i]
        for jump in 0...jumps where jump > 0 && jump + i < table.count {
            table[jump + i] = table[i]
            if jump + i == table.count - 1 { break outerLoop }
        }
    }

    return table.last!
}

// DP (Top Down)
func canJump(_ nums: [Int]) -> Bool {
    var memo: [Int: Bool] = [:]

    func helper(_ i: Int) -> Bool {
        if let result = memo[i] {
            return result
        }

        if i == nums.count - 1 {
            memo[i] = true
            return memo[i]!
        }

        if i >= nums.count {
            memo[i] = false
            return memo[i]!
        }

        for jumps in 0...nums[i] where jumps > 0 {
            if helper(i + jumps) { return true }
        }

        memo[i] = false
        return memo[i]!
    }

     return helper(0)
}

// Exhuastive Enumeration
func canJump(_ nums: [Int]) -> Bool {
    func helper(_ i: Int) -> Bool {
        if i == nums.count - 1 {
            return true
        }

        if i >= nums.count {
            return false
        }

        for jumps in 0...nums[i] where jumps > 0 {
            if helper(i + jumps) { return true }
        }

        return false
    }

     return helper(0)
}