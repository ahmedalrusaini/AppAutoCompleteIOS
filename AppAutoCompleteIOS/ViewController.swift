//
//  ViewController.swift
//  AppAutoCompleteIOS
//
//  Created by AhmedALRUSAINI on ١١‏/٧‏/٢٠١٨.
//  Copyright © ٢٠١٨ AhmedALRUSAINI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SearchTextField
/*
   repo : https://github.com/ahmedalrusaini/SearchTextField.git
   just add pod 'SearchTextField' in Project target in PODFILE $ commande in dir project pod install
   in readme The Way of usage of this lib .
*/
class ViewController: UIViewController {
    @IBOutlet weak var txtAutoComplete: SearchTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getCities() {
        var Cities:[String] = [String]()
        Alamofire
            .request("https://apina.address.gov.sa/NationalAddress/v3.1/lookup/cities?format=JSON&regionid=-1&language=E&api_key=03276a0c4d6f46719efba071a0c3b8be")
            .responseJSON
            { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar1 = JSON(responseData.result.value!)
                    let strjson = swiftyJsonVar1.rawString()!.data(using: String.Encoding.utf8)!
                    let swiftyJsonVar = JSON(strjson)
                    if let resData = swiftyJsonVar["Cities"].arrayObject {
                        for a in resData {
                            let v = a as! [String:Any]
                            let City = v["Name"]!
                            Cities.append(City as! String)
                        }
                        self.txtAutoComplete.filterStrings(Cities) // put data from array to Component AutoComplete
                        self.txtAutoComplete.startVisible = true
                        self.txtAutoComplete.maxNumberOfResults = 5
                    }
                }
        }
        }
}
