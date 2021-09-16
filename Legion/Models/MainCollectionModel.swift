//
//  MainCollectionModel.swift
//  Legion
//
//  Created by Evans Owamoyo on 29.08.2021.
//

import UIKit


// MARK: - Brain for all apps on the main screen

struct MainCollectionModel {
    let screens: [AppModel] = [
        AppModel(title: "Flower Classifier ML",
                 description: "A machine learning model that identifies flower picked from the library and gives a detailed description of the flower. Recommended for flower lovers",
                 storyBoardId: "FlowerClassifier"),
        AppModel(title: "Inceptionv3 ML Classifier",
                 description: "A machine learning model that identifies objects picked from the library",
                 storyBoardId: "SeeFood"),
        AppModel(title: "Todoey Task App",
                 description: "",
                 storyBoardId: "Todoey"),
        AppModel(title: "FlashChat",
                 description: "A Firebase chat app",
                 storyBoardId: "FlashChat",
                 iconName: "FlashChat"),
        AppModel(title: "ByteCoin",
                 description: "A ByteCoin currency converter",
                 storyBoardId: "ByteCoin",
                 iconName: "ByteCoin"),
        AppModel(title: "Clima Weather App",
                 description: "An app that get's your weather",
                 storyBoardId: "Clima",
                 iconName: "Clima"),
        AppModel(title: "Tipsy Bills Calculator",
                 description: "A calculator for splitting bills among people",
                 storyBoardId: "Tipsy",
                 iconName: "Tipsy"),
        
        
    ]
}

// MARK: - Model for each screen

struct AppModel {
    let title: String
    let description: String
    let storyBoardId: String
    var iconName: String? = nil
}
