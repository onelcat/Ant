//
//  LottieViewController.swift
//  Ant
//
//  Created by flqy on 2020/11/30.
//

import UIKit
import Lottie
class LottieViewController: UIViewController {

    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let animation = Animation.named("39411_relax", subdirectory: nil)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.frame = CGRect(x: 0, y: 84, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        view.addSubview(animationView)
      
        animationView.backgroundBehavior = .pauseAndRestore

        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.play()

        // Do any additional setup after loading the view.
    }
    
}
