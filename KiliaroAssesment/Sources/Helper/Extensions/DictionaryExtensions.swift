//
//  DictionaryExtensions.swift
//  KiliaroAssesment
//
//  Created by tanaz on 15/04/1401 AP.
//

import Foundation

extension Dictionary {
    func keysSortedByValue(_ isOrderedBefore: (Value, Value) -> Bool) -> [Key] {
        return Array(self).sorted{ isOrderedBefore($0.1, $1.1) }.map{ $0.0 }
    }
}
