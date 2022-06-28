//
//  Routes.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 28/06/22.
//

import Foundation

struct RoutesBrain{
    
    var status: String?
    var totalMin: Int?
    
    var timeStart: String?
    var timeEnd: String?
    
    var first: String?
    var middle: String?
    var last: String?
    
}

struct Route {
    
    var recommend = [
        RoutesBrain(status: "best", totalMin: 53, timeStart: "07.20", timeEnd: "08.13", first: "Transport2", middle: "Transport3", last: "Transport1"),
        RoutesBrain(status: "other", totalMin: 60, timeStart: "07.20", timeEnd: "08.30", first: "Transport2", middle: "Transport3", last: "Transport2"),
        RoutesBrain(status: "other", totalMin: 70, timeStart: "07.20", timeEnd: "08.40", first: "Transport2", middle: "Transport3", last: "Transport1"),
        RoutesBrain(status: "other", totalMin: 120, timeStart: "07.20", timeEnd: "09.20", first: "Transport1", middle: "Transport3", last: "Transport1")
    ]
    
}
