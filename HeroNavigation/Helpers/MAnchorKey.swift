//
//  MAnchorKey.swift
//  HeroNavigation
//
//  Created by Bilal SIMSEK on 20.07.2023.
//

import SwiftUI

struct MAnchorKey:PreferenceKey{
  
    
    static var defaultValue:[String:Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }

}
