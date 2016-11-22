import Foundation

extension NSData {

    static func dataWithValue<T>(value: T) -> NSData {
        var variableValue = value
        return NSData(bytes: &variableValue, length: sizeof(T))
    }

    func int8Value() -> Int8 {
        var value: Int8 = 0
        getBytes(&value, length: sizeof(Int8))
        return value
    }

}