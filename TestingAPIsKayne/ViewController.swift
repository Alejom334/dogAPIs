//
//  ViewController.swift
//  TestingAPIsKayne
//
//  Created by Alejandro Martinez on 7/13/19.
//  Copyright © 2019 Alejandro Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestURL()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        nextQuote(self)
//    }

    //Struct that matches the decode
    struct dogJSON: Codable {
        let message: String?
        let status: String
    }
    
    //here we will be storing all the images that we will be deciding
    
    //var arrayOfDogs: [UIImage] = []
    
    //var globalCounter: Int = 0
    
    var imageInArray: UIImage?
    
    var urlToLoad: URL?
    
    var globalData: Data?
    
    let REST_STATUS_OK = 200

    
    @IBAction func nextQuote(_ sender: Any) {
//        
//        let imageData = try? Data(contentsOf: urlToLoad!)
//        
//        if let imageToLoad = UIImage(data: imageData!){
//            self.dog.image = imageToLoad
//        }
//        
        requestURL()
        
        
        
        
//  WE ARE GOING TO BE CANCELING THE ARRAY FOR NOW
//        let arrayCounter: Int = arrayOfDogs.count
//        let range = globalCounter...arrayCounter
//        if (arrayCounter >= globalCounter) {
//            for i in range {
//                imageInArray = arrayOfDogs[i]
//                globalCounter += 1
//                break
//            }
//        }
        
//        if let imageToLoad = imageInArray {
//            dog.image = imageToLoad
//        }
        
    }
    
    @IBOutlet var dog: UIImageView!
    
    
    func requestURL () {
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        let task = session.dataTask(with: url) {
            
            (data, response, error) in
            //Make sure to cast the HTTPResponse
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == self.REST_STATUS_OK,
                let data = data else {
                    return
            }
            //decode the JSON
            do {
                //create the JSON DECODER
                let decoder = JSONDecoder()
                //Create the variable that will hold the data
                let digest = try decoder.decode(dogJSON.self
                    , from: data)
                
                if let imageURL = digest.message {
                    
                    let url = URL(string: imageURL)!
                    
                    self.urlToLoad = url
                    
                    
//                    let imageData = try Data(contentsOf: url)
                    
                    
//-------------------------------
//create a variable as optional chaining so the variable data could be stored
//                    if let dataToStore = imageData {
//                        globalData = dataToStore
//                    }
//-------------------------------
//                    if let image = UIImage(data: imageData){
//                        self.arrayOfDogs.append(image)
//                    }
                }
                
                let queue = OperationQueue.main
                queue.addOperation {
                    let imageData = try? Data(contentsOf: self.urlToLoad!)
                    
                    if let imageToLoad = UIImage(data: imageData!){
                        self.dog.image = imageToLoad
                    }
//                    self.dog.image = self.arrayOfDogs[0]
                }
        
            } catch {
                print("Error info: \(error)")
            }
        }
        //this has to do with the thread understand it better
        task.resume()
    }
}


