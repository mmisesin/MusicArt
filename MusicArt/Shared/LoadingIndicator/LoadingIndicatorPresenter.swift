//
//  LoadingIndicatorPresenter.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import Foundation

enum LoadingIndicatorType {
    case `default`(status: String?, progress: Float?)
    case error(status: String?)
    case info(status: String?)
    case success(status: String?)
}

protocol LoadingIndicatorPresenter {
    func displayLoadingIndicator(ofType type: LoadingIndicatorType)
    func hideLoadingIndicator()
}

extension LoadingIndicatorPresenter {
    func displayLoadingIndicator(ofType type: LoadingIndicatorType = .default(status: nil, progress: nil)) {
        LoadingIndicatorWrapper.displayLoadingIndicator(ofType: type)
    }
    
    func hideLoadingIndicator() {
        LoadingIndicatorWrapper.hideLoadingIndicator()
    }
}
