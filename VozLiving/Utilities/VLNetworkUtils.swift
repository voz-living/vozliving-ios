//
//  VLNetworkUtils.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class VLNetworkUtils: NSObject {

    
    static let host = "https://vozforums.com/"
    private static let _instance = VLNetworkUtils()
    static var sharedInstance: VLNetworkUtils {
        
        return VLNetworkUtils._instance
    }
    
    func request(functionUrl: VLFunctionUrl, method : HTTPMethod = .get, parameters: [String : AnyObject]?, encoding: URLEncoding = .httpBody, headers: [String : String]? = nil, completionHandler: @escaping (_ response: VLResponse?) -> Void) -> Alamofire.Request {
        
        let url : URLConvertible = "\(VLNetworkUtils.host)\(functionUrl.rawValue)"
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil)
        
        
        request.responseString(encoding: .utf8) { response in
            
            let httpBody: String
            let httpRequest = request.request
            
            if httpRequest != nil, let httpBodyData = httpRequest?.httpBody,
                let bodyStr = String(data: httpBodyData, encoding: .utf8) {
                
                httpBody = bodyStr
                
            } else {
                
                httpBody = ""
            }
            
            DLog("Request: \(request)\nHttpBody: \(httpBody)");
            DLog(response.response);
            
            var requestStatus = "Request is "
            if response.result.isSuccess {
                
                requestStatus += "success!"
                
            } else {
                
                requestStatus += "fail!"
            }
            
            DLog(requestStatus)
            DLog("Response String: \(response.result.value ?? "")")
            
            completionHandler(VLResponse(response: response))
        }
        
        return request
    }
    
    func login(userName: String, password: String, remember: Bool = true, completeHandler: @escaping (_ success: Bool) -> Void) {
        
        guard let md5Pass = password.md5() else {
            
            completeHandler(false)
            return
        }
        
        var params = [String: String]()
        params["securitytoken"] = "guest"
        params["do"] = "login"
        params["vb_login_username"] = userName
        params["vb_login_md5password"] = md5Pass
        params["vb_login_md5password_utf"] = md5Pass
        params["cookieuser"] = remember ? "1" : "0"
        
        _ = self.request(functionUrl: .login, method: .post, parameters: params as [String: AnyObject], encoding: .httpBody) { (response) in
            
            DLog(response)
            
            if let response = response, response.isSuccess,
                let loginCookie = response.cookies?.first(where: {$0.name == "vfimloggedin"}),
                loginCookie.value == "yes" {
                
                completeHandler(true)
                
            } else {
                
                completeHandler(false)
            }
            
        }
        
    }
    
}
