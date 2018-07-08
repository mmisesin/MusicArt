//
//  LoadingIndicatorWrapper.swift
//  MusicArt
//
//  Created by Artem Misesin on 7/8/18.
//  Copyright © 2018 misesin. All rights reserved.
//

import SVProgressHUD

class LoadingIndicatorWrapper {
    static func setupAppearance(withSuperview superview: UIView) {
        SVProgressHUD.setViewForExtension(superview)
        SVProgressHUD.setDefaultMaskType(.gradient)
        // TODO: setup appearance
    }
    
    static func displayLoadingIndicator(ofType type: LoadingIndicatorType) {
        Queues.executeOnMain {
            switch type {
            case .default(let status, let progress):
                if let progress = progress {
                    SVProgressHUD.showProgress(progress, status: status)
                } else {
                    SVProgressHUD.show(withStatus: status)
                }
            case .error(let status):
                SVProgressHUD.showError(withStatus: status)
            case .info(let status):
                SVProgressHUD.showInfo(withStatus: status)
            case .success(let status):
                SVProgressHUD.showSuccess(withStatus: status)
            }
        }
    }
    
    static func hideLoadingIndicator() {
        Queues.executeOnMain {
            SVProgressHUD.popActivity()
        }
    }
}
