//
//  Promise+PresentHud.swift
//  JAHudHydra
//
//  Created by Shane Whitehead on 8/11/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import Hydra
import JAHud

public extension Promise {
	static func presentWaitHud(on parent: UIViewController,
																		title: String? = nil,
																		text: String? = nil,
																		presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																		configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Promise<Void>(in: .main, { (fulfill, fail, _) in
			Hud.presentWait(on: parent,
											title: title,
											text: text,
											presentationStyle: presentationStyle,
											configuration: configuration,
											then: {
												fulfill(())
			})
		})
	}

	@discardableResult
	func thenPresentWaitHud(on parent: UIViewController,
													title: String? = nil,
													text: String? = nil,
													presentationStyle: Hud.PresentationStyle = .overCurrentContext,
													configuration: Hud.Configuration? = nil) -> Promise<Void> {
		// Don't ask me why it needs to wrapped in a then...
		return then(in: .main, { (Void) in
			return Promise<Void>(in: .main, { (fulfill, fail, _) in
				Hud.presentWait(on: parent,
												title: title,
												text: text,
												presentationStyle: presentationStyle,
												configuration: configuration,
												then: {
													fulfill(())
				})
			})
		})
	}

	@discardableResult
	func thenDismissHud(from parent: UIViewController) -> Promise<Void> {
		// Don't ask me why it needs to wrapped in a then...
		return then(in: .main, { (Void) in
			return Promise<Void>(in: .main, { (fulfill, fail, _) in
				Hud.dismiss(from: parent, then: {
					fulfill(())
				})
			})
		})
	}
}
