import UIKit

var str = "Hello, playground"

var list = [1,2,3,4]

let f = list.compactMap {
    return $0
}
