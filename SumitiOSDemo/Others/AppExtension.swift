//
//  AppExtension.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 160, y: self.view.frame.size.height-150, width: 320, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        //        toastLabel.font = UIFont(name: Constants.font, size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds  =  true
        toastLabel.layoutMargins.bottom = 200
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showAlert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension UIView{
    func activityStartAnimating() {
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.tag = 475647
            self.isUserInteractionEnabled = false
            self.addSubview(activityIndicator)
        }
    }
    
    func activityStopAnimating() {
        DispatchQueue.main.async{
            if let background = self.viewWithTag(475647){
                background.removeFromSuperview()
            }
            self.isUserInteractionEnabled = true
        }
    }
    
    func cardview() {
        self.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor(red: 0/255, green: 214/255, blue: 94/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.7
    }
    
    func cardCorner() {
        self.layer.cornerRadius = 20.0
    }
    
}


//MARK: - HTTPURLResponse
extension HTTPURLResponse {
    func isResponseOK() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
