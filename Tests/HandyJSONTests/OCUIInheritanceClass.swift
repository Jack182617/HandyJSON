//
//  OCUIInheritanceClass.swift
//  HandyJSON iOS Tests
//
//  Created by chantu on 2020/2/24.
//  Copyright © 2020 aliyun. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
import HandyJSON

class InheritFromUIViewControllerClass: UIViewController, HandyJSON {

    var a: Int?
    var b: String = ""
}

class SubClassOfInheritFromUIViewController: InheritFromUIViewControllerClass {
    var c: Double?
}
#endif
