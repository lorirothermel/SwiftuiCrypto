//
//  UIApplication.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/4/23.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    func  endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
