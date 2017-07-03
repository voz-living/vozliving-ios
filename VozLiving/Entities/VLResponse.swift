//
//  VLResponse.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/4/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class VLResponse: NSObject {

    let response: DataResponse<String>
    let headerFields: [String: String]?
    let cookies: [HTTPCookie]?
    var isSuccess: Bool {
        return self.response.result.isSuccess
    }
    
    init(response: DataResponse<String>) {
        
        self.response = response
        
        if let headerFields = response.response?.allHeaderFields as? [String: String],
            let URL = response.request?.url
        {
            
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
            self.cookies = cookies
            self.headerFields = headerFields
        } else {
            
            self.cookies = nil
            self.headerFields = nil
        }
        
        super.init()
        
    }
    
    
}
