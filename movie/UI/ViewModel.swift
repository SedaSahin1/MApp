//
//  ViewModel.swift
//  movie
//
//  Created by Seda Şahin on 3.03.2024.
//

import Foundation

public class ViewModel: NSObject {

    deinit {
        let type = Swift.type(of: self)
        print("\(type) DEALLOCATED")
    }
    
    override init(){
        let type = Swift.type(of: self)
        print("\(type) ALLOCATED")
    }
    var updateUI: (() -> Void)?
}
