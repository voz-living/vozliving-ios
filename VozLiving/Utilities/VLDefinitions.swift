//
//  VLDefinitions.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit

#if DEBUG
    
    func DLog<T>(_ value: T, className: String = #file, functionName: String = #function, lineNumber: Int = #line, column: Int = #column) {
        let realClassName = className.lastPathComponent.stringByDeletingPathExtension
        let debugStr = "=>\n[\(realClassName):\(functionName)][\(lineNumber):\(column)]: \(value) \n<=\n"
        print(debugStr)
        
    }
    
#else
    
    func DLog<T>(value: T, className: String = #file, functionName: String = #function, lineNumber: Int = #line, column: Int = #column) {
        
    }
    
#endif

typealias VLClosueNonArgument = ()-> Void
typealias VLAlertHandlerClosue = (_ buttonIndex: Int)-> Void


enum VLFunctionUrl: String {
    
    case login = "login.php?do=login"
    
}


class VLDefinitions: NSObject {

}
