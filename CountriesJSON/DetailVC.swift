//
//  DetailVC.swift
//  CountriesJSON
//
//  Created by Vladimir Kratinov on 2022/2/4.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Country?
    var html: String?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHTML()

        DispatchQueue.main.async {
            guard let secureHTML = self.html else { return }
            self.webView.loadHTMLString(secureHTML, baseURL: nil)
        }
        
    }
    
    func importImage(_ name: String?) -> String {
        guard let imageString = name else { return "" }
        let image = UIImage(named: imageString)
//        let data = image?.pngData()
        let data = image?.jpegData(compressionQuality: 0.5)
        guard let base64 = data?.base64EncodedString(options: []) else { return "" }
        let importedImage = "data:application/png;base64," + base64
        return importedImage
    }
    
    func loadHTML() {
        guard let detailItem = detailItem else { return }
        
        let flagImage = "\(detailItem.id.lowercased())240"
        let mapImage = "\(detailItem.name.lowercased())-map"
        let image1 = "\(detailItem.name.lowercased())-image1"
        let image2 = "\(detailItem.name.lowercased())-image2"
        let image1Description = "\(detailItem.image1Description)"
        let image2Description = "\(detailItem.image2Description)"
        
        html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body {
            font-size: 100%;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #FFFFFF;
            text-align: justify;
            color: black;
            border: 2px solid black;
            margin: 20px;
            padding: 20px;
        }
        </style>
        </head>

        <body>
        <h1 style="text-align: center; font-size: 130%;"> \(detailItem.name)</h1>

        <p class="aligncenter"> <img src="\(importImage(flagImage))" style="width: 100%; height: auto; border: 2px solid black"> </p>

        <p class="alignceter"> <img src="\(importImage(mapImage))" style="width: 100%; height: auto"> </p>

        <p> Population: \(detailItem.population) million people </p>
        <p> Area: \(detailItem.area) km² </p>
        <p> Capital: \(detailItem.capital) </p>
        <p> Language: \(detailItem.language) </p>
        
        <h3> Description: </h3>
        <p> \(detailItem.description) </p>

        <p class="alignceter"> <img src="\(importImage(image1))" style="width: 100%; height: auto"> </p>
        <p style="font-size: 60%"> \(image1Description) </p>

        <h3> Background: </h3>
        <p> \(detailItem.background) </p>

        <p class="alignceter"> <img src="\(importImage(image2))" style="width: 100%; height: auto"> </p>
        <p style="font-size: 60%"> \(image2Description) </p>
        
        <h3> Political System: </h3>
        <p> \(detailItem.political) </p>

        <h3> Export: </h3>
        <p> \(detailItem.export) </p>

        </body>

        </html>

        <style>
        .aligncenter {
            text-align: center;
        }
        </style>
        """
    }
}
