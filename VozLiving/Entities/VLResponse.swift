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
import SwiftSoup

class VLResponse: NSObject {

    let response: DataResponse<String>
    let headerFields: [String: String]?
    let cookies: [HTTPCookie]?
    let isSuccess: Bool
    let responseString: String
    
    init(response: DataResponse<String>) {
        
        self.response = response
        self.isSuccess = self.response.result.isSuccess
        
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
        
        if let responseString = response.result.value {
            
            self.responseString = responseString
            
        } else {
            
            self.responseString = ""
        }
        
        super.init()
        
    }
    
    func parseBody() -> Document? {
        
        do {
            
            let document = try SwiftSoup.parse(self.responseString)
            return document
            
        } catch {
            
            DLog(error)
        }
        
        return nil
        
    }
    
    
}
