//
//  ViewController.swift
//  JAHubExample
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import UIKit
import JAHud
import JAHudHydra
import Hydra

extension String: Error {}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	var progress: Progress = Progress(totalUnitCount: 100)
	
	func makeItShow(_ config: Hud.Configuration, fail: Bool) {
		Promise<Void>.presentProgressHud(on: self,
																		 progress: progress,
																		 title: "All your work are belong to us",
																		 text: "Please wait...",
																		 configuration: config)
			.then(in: .userInitiated) { () in
				while self.progress.fractionCompleted < 1.0 {
					Thread.sleep(forTimeInterval: 1.0)
					let amount = 10
					let value = min(100, self.progress.completedUnitCount + Int64(amount))
					self.progress.completedUnitCount += value
				}
				Thread.sleep(forTimeInterval: 1.0)
				guard fail else {
					return
				}
				throw "Something wicked this way did come"
		}.thenPresentSuccessHud(on: self)
		.then(in: .main, { () in
			self.performSegue(withIdentifier: "After", sender: self)
		}).thenDismissHud(from: self)
		.catch(in: .main) { (error) in
			Promise<Void>.presentFailureHud(on: self)
			.thenDismissHud(from: self)
		}

		
		
//		Hud.asyncPresentProgress(on: self,
//														 progress: progress,
//														 title: "All your work are belong to us",
//														 text: "Please wait...",
//														 configuration: config)
//		.then(in: .userInitiated) { () in
//			while self.progress.fractionCompleted < 1.0 {
//				Thread.sleep(forTimeInterval: 1.0)
//				let amount = 10
//				let value = min(100, self.progress.completedUnitCount + Int64(amount))
//				self.progress.completedUnitCount += value
//			}
//			Thread.sleep(forTimeInterval: 1.0)
//		}.defer(in: .userInitiated, 1.0).then(in: .main) { () -> Promise<Void> in
//			if fail {
//				return Hud.asyncPresentFailure(on: self)
//			} else {
//				return Hud.asyncPresentSuccess(on: self)
//			}
//		}.then(in: .main) { () in
//			if !fail {
//				self.performSegue(withIdentifier: "After", sender: self)
//			}
//		}.always(in: .main) {
//			Hud.dismiss(from: self)
//		}
		
		// This is the original example code from JAHud for comparision
//		Hud.presentProgress(on: self,
//												progress: progress,
//												title: "All your work are belong to us",
//												text: "Please wait...",
//												configuration: config) {
//			DispatchQueue.global(qos: .userInitiated).async {
//				while self.progress.fractionCompleted < 1.0 {
//					Thread.sleep(forTimeInterval: 1.0)
//					let amount = 10
//					let value = min(100, self.progress.completedUnitCount + Int64(amount))
//					self.progress.completedUnitCount += value
//				}
//				Thread.sleep(forTimeInterval: 1.0)
//				DispatchQueue.main.async {
//					if fail {
//						Hud.presentFailure(on: self) {
//							Hud.dismiss(from: self)
//						}
//					} else {
//						Hud.presentSuccess(on: self) {
//							self.performSegue(withIdentifier: "After", sender: self)
//						}
//					}
//				}
//			}
//		}
	}

	@IBAction func makeItMaterial(_ sender: Any) {
		progress.completedUnitCount = 0
		var config = Hud.Configuration()
		config.progress.strokeWidth = 3.0
		config.waitIndicatorStyle = .material
		
		makeItShow(config, fail: true)
	}

	@IBAction func makeItiOS(_ sender: Any) {
		progress.completedUnitCount = 0
		var config = Hud.Configuration()
		config.progress.strokeWidth = 3.0

		makeItShow(config, fail: false)
	}

	@IBAction func makeItMaterialWithColor(_ sender: Any) {
		progress.completedUnitCount = 0
		var config = Hud.Configuration()
		config.progress.strokeWidth = 3.0
		config.state.fillStyle = .filled
		config.waitIndicatorStyle = .material
		
		config.contentBackgroundColor = UIColor.blue.withAlphaComponent(0.5)
		config.textColor = UIColor.red
		config.titleColor = UIColor.white
		config.waitIndicatorColor = UIColor.magenta
		config.progress.strokeColor = UIColor.purple
		config.state.fillStyle = .filled
		config.state.failColor = .orange
		config.state.successColor = .green
		
		makeItShow(config, fail: true)
	}
	
	@IBAction func makeItiOSWithColor(_ sender: Any) {
		progress.completedUnitCount = 0
		var config = Hud.Configuration()
		config.progress.strokeWidth = 3.0
		config.state.fillStyle = .filled

		config.contentBackgroundColor = UIColor.blue.withAlphaComponent(0.5)
		config.textColor = UIColor.red
		config.titleColor = UIColor.white
		config.waitIndicatorColor = UIColor.magenta
		config.progress.strokeColor = UIColor.purple
		config.state.fillStyle = .filled
		config.state.failColor = .orange
		config.state.successColor = .green

		makeItShow(config, fail: false)
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
//		Hud.dismiss(from: self)
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
}

