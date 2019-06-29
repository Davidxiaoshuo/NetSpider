//
//  ViewController.swift
//  NetSpider
//
//  Created by David小硕 on 2019/6/27.
//  Copyright © 2019 David小硕. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        obtainMusicDownloadUrl()
    }

    func obtainMusicDownloadUrl() {
        guard let url = URL.init(string: "https://api.imjad.cn/cloudmusic/?type=song&id=28012031&br=128000") else { return }
        Alamofire.request(url).responseJSON { dataResponse in
            if let statusCode = dataResponse.response?.statusCode {
                print("http response status code \(statusCode)")
            }
            dataResponse.result.ifSuccess {
                if let data = dataResponse.data, let utf8Str = String(data: data, encoding: String.Encoding.utf8) {
                    print("json result ===> \(utf8Str)")
                }
            }
            dataResponse.result.ifFailure {
                if let error = dataResponse.error {
                    print("error description ===> \(error.localizedDescription)")
                }
            }
        }
    }
}

