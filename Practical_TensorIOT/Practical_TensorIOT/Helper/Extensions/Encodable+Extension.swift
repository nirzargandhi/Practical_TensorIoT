//
//  Encodable+Extension.swift
//  Practical_TensorIOT
//

import Foundation

//MARK: - Encodable Extension
extension Encodable {

    var values: [String: Any]? {

        guard let data = try? JSONEncoder().encode(self) else { return nil }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
