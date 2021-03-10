//
//  BaseDataProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import Foundation

public protocol BaseDataProtocol: AnyObject {
    associatedtype Model
    var models: [Model] { get set }
}
