//
//  UserViewModel.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import Foundation

struct UserViewModel {
    
    func getUserDataList(currentPageVal: Int,comp: @escaping (_ isInternet: Bool, _ isError: Bool, _ data: [PostModel]?) -> Void) {
        if NetworkReachability.shared.isConnectedToInternet() {
            NetworManger().userData(currentPageVal: currentPageVal) { model, isError in
                if isError {
                    comp(true, true, nil)
                } else {
                    if let model = model {
                        comp(true, false, model)
                    } else {
                        comp(true, true, nil)
                    }
                }
            }
        } else {
            comp(false, false, nil)
        }
    }
}
