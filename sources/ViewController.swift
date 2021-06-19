//
//  ViewController.swift
//  NetSpider
//
//  Created by David‘s Studio on 2019/6/27.
//  Copyright © 2019 David‘s Studio. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var reminderTimer: CountDownTimer?
    var askUserStatusTimer: CountDownTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        obtainMusicDownloadUrl()
        startCountDownTimer()
    }

    func obtainMusicDownloadUrl() {
        
        SpiderLogger.info(msg: "current thread is main ? ==> \(Thread.current.isMainThread)")
        
        NetSpider.shared().restful.request(
            builder: RestfulRequestBuilder()
                .with(endpoint: "/cloudmusic")
                .with(method: .get)
                .with(parameters: ["type": "song", "id": "28012031", "br": 128000])
        ).fire { (response: HTTPResponseResult<MusicsModel>) in
            SpiderLogger.info(msg: "current thread is main ? ==> \(Thread.current.isMainThread)")
            switch response.result {
            case .success(let model):
                SpiderLogger.info(msg: model.toJSONString(prettyPrint: true) ?? "null")
            case .failure(let error):
                SpiderLogger.error(msg: error.debugDescription)
            }
        }

        NetSpider.shared().graphQL.request(
            with: CountryListQuery()
        ).fire { (response: HTTPResponseResult<CoutryListModel>) in
            SpiderLogger.info(msg: "current thread is main ? ==> \(Thread.current.isMainThread)")
            switch response.result {
            case .success(let model):
                SpiderLogger.info(msg: model.toJSONString(prettyPrint: true) ?? "null")
            case .failure(let error):
                SpiderLogger.error(msg: error.debugDescription)
            }
        }
    }
    
    func startCountDownTimer() {
        var remiderIndex: Int = 0
        self.reminderTimer = CountDownTimer(countDownInterval: 5, isRepeat: true) { [weak self] in
            print("reminderTimer .......\(remiderIndex)")
            if remiderIndex >= 5 {
                self?.reminderTimer?.stop()
                print("reminderTimer .......stop")
            }
            remiderIndex += 1
        }.start()
        
        var askIndex: Int = 0
        self.askUserStatusTimer = CountDownTimer(countDownInterval: 10, isRepeat: true) { [weak self] in
            print("askUserStatusTimer .......\(askIndex)")
            if askIndex >= 5 {
                self?.askUserStatusTimer?.stop()
                print("askUserStatusTimer .......stop")
            }
            askIndex += 1
        }.start()
    }
}

