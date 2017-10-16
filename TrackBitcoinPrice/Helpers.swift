//
//  Helpers.swift
//  TrackBitcoinPrice
//
//  Created by Jianyu ZHU on 16/10/17.
//  Copyright © 2017 Unimelb. All rights reserved.
//

import UIKit

let REQUEST_URL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
let CURRENCY_ARRAY = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
let CURRENCY_SYMBOL = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
