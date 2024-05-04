//
//  DetailViewController.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var vwDetailsOfPost: UIView!
    @IBOutlet weak var lblDetailsPost: UILabel!
    
    var postData : PostModel?
    
    //MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetailsPost.text = "id : \(postData?.id ?? 0)" + ", \n\n" + "userID : \(postData?.userID ?? 0)" + ", \n\n" + "title : \(postData?.title ?? "")" + ", \n\n" + "body : \(postData?.body ?? "")"
    }
    
    override func viewDidLayoutSubviews() {
        vwDetailsOfPost.cardview()
    }
    
    //MARK: - UIButton actions
    @IBAction func btnBackOnClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
