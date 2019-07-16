//
//  Extension.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 11/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        
        URLSession.shared.dataTask(with: URL(string: link)!) { (data, respone, error) in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }.resume()
    }
}

extension String {
    
    func stringToDate() -> Date {
    // change to your date format
    
        let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
    
    let date = dateFormatter.date(from: self)
    
        return date ?? Date()
    }
}

extension Date {
    func toString(format: String = "dd-MMM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


extension UIView {
    func cardView() {
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.7
    }
}

extension UIViewController {
    func showAlert(alertText : String, alertMessage : String) {
        
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
