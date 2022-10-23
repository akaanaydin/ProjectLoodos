//
//  String+Extension.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 23.10.2022.
//

import UIKit

//MARK: - First Letter Uppercased
extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
