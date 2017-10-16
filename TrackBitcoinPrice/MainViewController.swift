//
//  ViewController.swift
//  TrackBitcoinPrice
//
//  Created by Jianyu ZHU on 16/10/17.
//  Copyright © 2017 Unimelb. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let topImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "bitcoin")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 42)
        label.textColor = UIColor(red: 241, green: 167, blue: 52)
        label.text = "Price"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.showsSelectionIndicator = true
        picker.contentMode = .scaleAspectFill
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    func setupView() {
        view.backgroundColor = UIColor(red: 18, green: 135, blue: 151)
        
        view.addSubview(topImageView)
        topImageView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        topImageView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        topImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 42).isActive = true
        
        view.addSubview(priceLabel)
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 110).isActive = true
        priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        
        view.addSubview(currencyPicker)
        currencyPicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        currencyPicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        currencyPicker.heightAnchor.constraint(equalToConstant: 216).isActive = true
        currencyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CURRENCY_ARRAY.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CURRENCY_ARRAY[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(REQUEST_URL)\(CURRENCY_ARRAY[row])")
        SVProgressHUD.show()
        getBitcoinPrice(url: "\(REQUEST_URL)\(CURRENCY_ARRAY[row])")
    }

    func getBitcoinPrice(url : String) {
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            if response.result.isSuccess {
//                print("Success! Got the price data")
                SVProgressHUD.dismiss()
                self.updatePriceData(data: JSON(response.result.value!))
            } else {
                print("Error: \(response.result.error)")
                self.priceLabel.text = "Connection Issues"
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func updatePriceData(data : JSON) {
//        print(data)

        if let price = data["averages"]["day"].double {
            priceLabel.text = "\(CURRENCY_SYMBOL[currencyPicker.selectedRow(inComponent: 0)])\(price)"
        } else {
            priceLabel.text = "Price unavailable"
        }
    }

}

