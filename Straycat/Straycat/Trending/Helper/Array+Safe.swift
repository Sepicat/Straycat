//
//  Array+Safe.swift
//  Straycat
//
//  Created by Harry Twan on 2018/5/7.
//  Copyright © 2018 Harry Twan. All rights reserved.
//

import UIKit

extension Array {
    subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}
