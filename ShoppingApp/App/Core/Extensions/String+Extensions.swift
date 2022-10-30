//
//  String+Extensions.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import Foundation

extension String {
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  str
   }
}
