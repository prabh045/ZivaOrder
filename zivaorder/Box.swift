//
//  Box.swift
//  zivaorder
//
//  Created by Prabhdeep Singh on 07/12/21.
//
import Foundation

class Box<T> {
    //MARK: Properties
    typealias Listener = (T) -> Void
    private var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    //MARK: Initialiser
    init(_ value: T) {
        self.value = value
    }
    
    //MARK: Methods
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
