//
//  ViewController.swift
//  Daily wisdom
//
//  Created by Simon Alam on 30.04.21.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, QuoteManagerDelegate {
   
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    var currentQuote = ""
    var managerr = QuoteManager()
    
    func updateUI(_ data: Quote) {
        DispatchQueue.main.async {
            self.label.text = data.quote
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 17
        managerr.delegate = self
        managerr.fetchData()
        
        
    }


    @IBAction func buttonPressed(_ sender: Any) {
        managerr.fetchData()
    }
    
    func scheduleNotificaiton() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("YAYY")
            } else {
                print("F*ck")
            }
        }
        let content = UNMutableNotificationContent()
       
        
       // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 2
      
        content.title = "Daily quote"
        managerr.fetchData()
        content.body = currentQuote

        let randomIdentifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)

        // 3
        UNUserNotificationCenter.current().add(request) { error in
          if error != nil {
            print("something went wrong")
          }
        }
        
    }
}

