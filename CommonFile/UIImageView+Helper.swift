//
//  ImageView+Helper.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation

final class LoadImage {
    static func imageFromServerURL(urlString: String, completionHandler: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil, let data = data {
                completionHandler(data)
            }
        }).resume()
    }}
