//
//  Waitable.swift
//  channel
//
//  Created by Henrique Sasaki Yuya on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

protocol Waitable {
    
    func wait() -> Bool
    
}
