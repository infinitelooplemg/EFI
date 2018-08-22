//
//  ASDisplayNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/21/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import StatusAlert

extension ASDisplayNode {
    func showAlert(with title:String?,message:String?,image:UIImage?,for feedbackType:UINotificationFeedbackType,dismissable:Bool){
        
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(feedbackType)
        let statusAlert = StatusAlert.instantiate(withImage: image, title: title, message: message, canBePickedOrDismissed: dismissable)
        
        statusAlert.showInKeyWindow()
    }
}
