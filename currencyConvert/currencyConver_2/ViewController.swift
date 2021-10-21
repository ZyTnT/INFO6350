//
//  ViewController.swift
//  currencyConver_2
//
//  Created by 赵芷涵 on 10/20/21.
//

import UIKit
import SwiftSpinner
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
    

    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var lblResult: UILabel!
    let baseURL = "http://api.exchangeratesapi.io/v1/latest?access_key=0b85a5f2c10b726eb98c0dc74e8aef56&symbols=USD,CAD,JPY"
    
    var currencyList: [String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fromPicker.delegate = self
        self.fromPicker.dataSource = self
        self.toPicker.delegate = self
        self.toPicker.dataSource = self
        currencyList = ["EUR","USD","CAD","JPY"]
    }

    @IBAction func Convert(_ sender: Any) {
        var fromCurrency = currencyList[fromPicker.selectedRow(inComponent: 0)]
        var toCurrency = currencyList[toPicker.selectedRow(inComponent: 0)]
        AF.request(baseURL).responseJSON{ response in
            if response.error != nil{
                print(response.error)
                return;
            }
            let result = JSON(response.data!)
            let EUR:Double = 1.0
            let USD:Double = result["rates"]["USD"].doubleValue
            let CAD:Double = result["rates"]["CAD"].doubleValue
            let JPY:Double = result["rates"]["JPY"].doubleValue
            var first:Double
            var second:Double
            
            if fromCurrency == "EUR"{
                 first = EUR
            }else if fromCurrency == "USD"{
                 first = USD
            }else if fromCurrency == "CAD"{
                 first = CAD
            }else{
                 first = JPY
            }
            
            if toCurrency == "EUR"{
                 second = EUR
            }else if toCurrency == "USD"{
                 second = USD
            }else if toCurrency == "CAD"{
                 second = CAD
            }else{
                 second = JPY
            }
            
            self.lblResult.text = "\(fromCurrency) to \(toCurrency) rate is \(second/first)"
        }
    }
}

