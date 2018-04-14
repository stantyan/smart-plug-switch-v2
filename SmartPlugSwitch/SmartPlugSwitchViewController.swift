//
//  SmartPlugSwitchViewController.swift
//  SmartPlugSwitch
//
//  Created by Stan Tyan on 4/14/18.
//  Copyright © 2018 Stan Tyan. All rights reserved.
//

import Cocoa

class SmartPlugSwitchViewController: NSViewController {
    
    var token = "Your_TPLink_Account_Token"
    var movieLightsID = "Your_Device_ID"
    var bathroomFanID = "Your_Device_ID"
    var waterHeaterID = "Your_Device_ID"
    var kitchenLedID = "Your_Device_ID"
    var christmasLightsID = "Your_Device_ID"
    var hotWaterID = "Your_Device_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func plugSwitch(_ token: String, _ movieLightsID: String, _ plugState: String) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        let parameters = [
            "method": "passthrough",
            "params": [
                "deviceId": "" + movieLightsID + "",
                "requestData": "{\"system\":{\"set_relay_state\":{\"state\":" + plugState + "}}}"
            ]
            ] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://eu-wap.tplinkcloud.com/?token=" + token + "")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
            }
        })
        
        dataTask.resume()
    }
}

extension SmartPlugSwitchViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> SmartPlugSwitchViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "SmartPlugSwitchViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SmartPlugSwitchViewController else {
            fatalError("Why cant i find SmartPlugSwitchViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

extension SmartPlugSwitchViewController {
    
    @IBAction func plug01on(_ sender: NSButton) {
        plugSwitch(token, movieLightsID, "1")
    }
    
    @IBAction func plug01off(_ sender: NSButton) {
        plugSwitch(token, movieLightsID, "0")
    }
    
    @IBAction func plug02on(_ sender: NSButton) {
        plugSwitch(token, bathroomFanID, "1")
    }
    
    @IBAction func plug02off(_ sender: NSButton) {
        plugSwitch(token, bathroomFanID, "0")
    }
    
    @IBAction func plug03on(_ sender: NSButton) {
        plugSwitch(token, kitchenLedID, "1")
    }
    
    @IBAction func plug03off(_ sender: NSButton) {
        plugSwitch(token, kitchenLedID, "0")
    }
    
    @IBAction func plug04on(_ sender: NSButton) {
        plugSwitch(token, waterHeaterID, "1")
    }
    
    @IBAction func plug04off(_ sender: NSButton) {
        plugSwitch(token, waterHeaterID, "0")
    }
    
    @IBAction func plug05on(_ sender: NSButton) {
        plugSwitch(token, hotWaterID, "1")
    }
    
    @IBAction func plug05off(_ sender: NSButton) {
        plugSwitch(token, hotWaterID, "0")
    }
    
    @IBAction func plug06on(_ sender: NSButton) {
        plugSwitch(token, christmasLightsID, "1")
    }
    
    @IBAction func plug06off(_ sender: NSButton) {
        plugSwitch(token, christmasLightsID, "0")
    }
    
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
}
