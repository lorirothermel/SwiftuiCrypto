//
//  String.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/10/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
}
