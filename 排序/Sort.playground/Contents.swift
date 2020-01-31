import UIKit


var arr = [6, 3, 2, 4, 5, 12, 14]

// 简单排序
func simpleSort (_ nums: inout [Int]) -> Void {
    for i in 0 ..< nums.count {
        for j in i + 1 ..< nums.count {
            if nums[i] > nums[j] {
                nums.swapAt(i, j)
            }
        }
    }
}
//simpleSort(&arr)
//print(arr)

// 冒泡排序
func bubbleSort (_ nums: inout [Int]) -> Void {
    for i in 0 ..< nums.count {
        for j in 0 ..< nums.count - i - 1 {
            if nums[j] > nums[j + 1] {
                nums.swapAt(j, j + 1)
            }
        }
    }
}
//bubbleSort(&arr)
//print(arr)

// 冒泡排序 优化1 特性1 没有发生交换时，证明已经排序完毕
func bubbleSort_1 (_ nums: inout [Int]) -> Void {
    var isSwap = false
    for i in 0 ..< nums.count {
        isSwap = false
        for j in 0 ..< nums.count - i - 1 {
            if nums[j] > nums[j + 1] {
                nums.swapAt(j, j + 1)
                isSwap = true
            }
        }
        if (!isSwap) {
            return
        }
    }
}


//bubbleSort_1(&arr)
//print(arr)
// 冒泡排序优化2 特性2 最后一次交换的位置之后都是有序的
func bubbleSort_2 (_ nums: inout [Int]) -> Void {
    var isSwap = false
    var k = 0
    for i in 0 ..< nums.count {
        isSwap = false
        k = nums.count - i - 1
        for j in 0 ..< k {
            if nums[j] > nums[j + 1] {
                nums.swapAt(j, j + 1)
                isSwap = true
                k = j // 记录最后一次发生交换的位置
            }
        }
        if (!isSwap) {
            return
        }
    }
}

//bubbleSort_2(&arr)
//print(arr)
// 快速排序的实现

arr = [6, 3, 2, 5, 4, 14, 12, 19]
func quickSort (_ nums: inout [Int], _ begin: Int, _ end: Int) -> Void {
    if (begin > end) {
        return
    }
    let pivot = nums[begin]
    var i = begin
    var j = end
    
    while i < j {
        while nums[j] > pivot {
            j -=  1
        }
        if i < j {
            nums[i] = nums[j]
        }
        while nums[i] < pivot {
            i += 1
        }
        if i < j {
            nums[j] = nums[i]
        }
    }
    nums[j] = pivot
    
    quickSort(&nums, begin, j - 1)
    quickSort(&nums, j + 1, end)
}

//quickSort(&arr, 0, arr.count - 1)
//print(arr)

//
func process(_ nums: inout [Int], _ begin: Int, _ end: Int) -> Int {

    var left = begin, right = end
    let pivot = nums[begin]
    while left < right {
        while nums[right] >= pivot && left < right {
            right -= 1
        }
        while nums[left] <= pivot && left < right {
            left += 1
        }
        nums.swapAt(left, right)
    }
    nums.swapAt(begin, left)
    return left
}
//
func quickSort_1(_ nums: inout [Int], _ begin: Int, _ end: Int) -> Void {
    if begin < end {
        let index = process(&nums, begin, end)
        quickSort_1(&nums, begin , index - 1)
        quickSort_1(&nums, index + 1, end)
    }
}

//quickSort_1(&arr, 0, arr.count - 1)
//print(arr)
// 汉诺塔问题
func hanoi_move(_ n: Int, _ from: String, _ buff: String, _ to: String) ->  Void {
    if (n == 1) {
        print("Move \(n) from \(from) to \(to)")
    } else {
        hanoi_move(n - 1, from, to, buff)
        hanoi_move(1, from, buff, to)
        hanoi_move(n - 1, buff, from , to)
    }
}

hanoi_move(3, "A", "B", "C")
