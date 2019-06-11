//
//  UIStoryboardSegue.swift
//  UniversalAppSample
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/9/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//
import UIKit

fileprivate extension UIStoryboardSegue {
    func replaceSource() {
        source.children.forEach { $0.removeFromParent() }
        source.addChild(destination)
        source.view.addEdgeConstrained(subview: destination.view)
        destination.didMove(toParent: source)
    }
}

final class SourceReplacingEmbedSegue: UIStoryboardSegue {
    override func perform() {
        replaceSource()
    }
}

final class SourceReplacingEmbedWithBlurTransitionSegue: UIStoryboardSegue {
    override func perform() {
        replaceSource()
        
        if UIApplication.shared.keyWindow?.isRegularSize == false {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = destination.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            destination.view.addSubview(blurEffectView)
            
            UIView.animate(withDuration: 0.3, animations: { blurEffectView.effect = nil }) { _ in
                blurEffectView.removeFromSuperview()
            }
        }
    }
}


