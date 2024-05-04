//
//  NetworkManager.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import Foundation
import SwiftyJSON
import UIKit


final class NetworManger {
    
    func userData(currentPageVal: Int,comp: @escaping (_ model: [PostModel]?, _ isError: Bool) -> Void){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var url: URL? = nil
        
        url = URL(string: Domain.baseUrl + "?_page=\(currentPageVal)&_limit=\(APIEndpoint.limit)")!
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        //        print("urlrequest : \(urlRequest)")
        
        let task = session.dataTask(with: urlRequest) { (data, response, error ) in
            if let response = response as? HTTPURLResponse, response.isResponseOK() {
                if let data = data {
                    //                    print("JSON  = ",JSON(data))
                    let parseData = try? JSONDecoder().decode([PostModel].self, from: data)
                    //                    print("parseData  = ",parseData)
                    comp(parseData, false)
                } else {
                    comp(nil, true)
                }
            } else {
                comp(nil, true)
            }
        }
        task.resume()
    }
}
