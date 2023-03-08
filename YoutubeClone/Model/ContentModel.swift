//
//  ContentModel.swift
//  YoutubeClone
//
//  Created by mert can çifter on 27.02.2023.
//

import Foundation

enum ContentType: Int {
    case video = 1
    case shorts = 2
}

struct ContentModel {
    var title: String
    var channelName: String
    var url: URL?
    var contentType: ContentType?
    var shorts: [ShortsModel]?
    
    init(title: String,channelName: String,url: URL?,contentType: ContentType?,shorts: [ShortsModel]? = []) {
        self.title = title
        self.channelName = channelName
        self.url = url
        self.contentType = contentType
        self.shorts = shorts
    }
}

struct ShortsModel {
    var image: String
}


extension ContentModel {
    static var exampleDatas: [ContentModel] = [
        ContentModel(title: "Barbie", channelName: "Box Office Türkiye",url: URL(string:  "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"), contentType: .video),
        
        ContentModel(title: "John Wick 4 | Altyazılı Fragman 2", channelName: "Box Office Türkiye",url: URL(string:  "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"), contentType: .video),
        
        ContentModel(title: "Batıl 2", channelName: "Box Office Türkiye",
                     url: URL(string:  "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
                     contentType: .shorts,
                     shorts: [
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                     ]),
        
        ContentModel(title: "Cin Sureti",channelName: "Box Office Türkiye",url: URL(string:  "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"), contentType: .video),
        
        ContentModel(title: "The Flash", channelName: "Box Office Türkiye",
                     url: URL(string:  "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"),
                     contentType: .shorts,
                     shorts: [
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                        ShortsModel(image: "https://picsum.photos/200/300"),
                     ]),
        
        ContentModel(title: "Hızlı ve Öfkeli 10",channelName: "Box Office Türkiye",url: URL(string:  "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"), contentType: .video)
    ]
}
