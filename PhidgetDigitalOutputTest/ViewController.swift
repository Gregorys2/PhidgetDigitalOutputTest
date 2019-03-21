//
//  ViewController.swift
//  PhidgetDigitalOutputTest
//
//  Created by Gregory Paul Sim on 2019-03-19.
//  Copyright © 2019 Gregory Paul Sim. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    let led = DigitalOutput()
    let button = DigitalInput()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            try led.setDeviceSerialNumber(527868)
            try led.setHubPort(3)
            try led.setIsHubPortDevice(true)
            
            try button.setDeviceSerialNumber(527868)
            try button.setHubPort(1)
            try button.setIsHubPortDevice(true)
            
            let _ = led.attach.addHandler(attach_handler)
            let _ = button.attach.addHandler(attach_handler)
            
            let _ = button.stateChange.addHandler(state_change)
            
         
            try button.open()
            try led.open()
            
        } catch let err as PhidgetError {
            print(err)
        } catch {
            print(error)
        }
    }
    
    
    func attach_handler(sender: Phidget){
        do{
            if(try sender.getHubPort() == 3){
                print("LED Attached")
            }
            else{
                print("Button Attached")
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    
    
    func state_change(sender:DigitalInput, state:Bool){
        do{
            if(state == true){
                print("Button Pressed")
                try led.setState(true)
            }
            else{
                print("Button Not Pressed")
                try led.setState(false)
            }
        } catch let err as PhidgetError{
            print("PPPhidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
}
