//
//  Hud+Promise.swift
//  JAHudHydra
//
//  Created by Shane Whitehead on 9/9/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//
import Foundation
import JAHud
import Hydra

public extension Promise {
	@discardableResult
	public func thenPresentWaitHud(on parent: UIViewController,
													title: String? = nil,
													text: String? = nil,
													presentationStyle: Hud.PresentationStyle = .overCurrentContext,
													configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentWait(on: parent,
																title: title,
																text: text,
																presentationStyle: presentationStyle,
																configuration: configuration)
	}

	@discardableResult
	public func thenPresentProgressHud(on parent: UIViewController,
															progress: Progress,
															title: String? = nil,
															text: String? = nil,
															presentationStyle: Hud.PresentationStyle = .overCurrentContext,
															configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentProgress(on: parent,
																		progress: progress,
																		title: title,
																		text: text,
																		presentationStyle: presentationStyle,
																		configuration: configuration)
	}
	
	@discardableResult
	public func thenPresentSuccessHud(on parent: UIViewController,
																				title: String? = nil,
																				text: String? = nil,
																				presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																				configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentSuccess(on: parent,
																	 title: title,
																	 text: text,
																	 presentationStyle: presentationStyle,
																	 configuration: configuration)
	}
	
	@discardableResult
	public func thenPresentFailureHud(on parent: UIViewController,
																 title: String? = nil,
																 text: String? = nil,
																 presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																 configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentFailure(on: parent,
																	 title: title,
																	 text: text,
																	 presentationStyle: presentationStyle,
																	 configuration: configuration)
	}
	
	@discardableResult
	public func thenDismissHud(from parent: UIViewController) -> Promise<Void> {
		return Hud.asynDismiss(from: parent)
	}
}

public extension Promise {
	public static func presentWaitHud(on parent: UIViewController,
																		title: String? = nil,
																		text: String? = nil,
																		presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																		configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentWait(on: parent,
																title: title,
																text: text,
																presentationStyle: presentationStyle,
																configuration: configuration)
	}
	
	@discardableResult
	public static func presentProgressHud(on parent: UIViewController,
															progress: Progress,
															title: String? = nil,
															text: String? = nil,
															presentationStyle: Hud.PresentationStyle = .overCurrentContext,
															configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentProgress(on: parent,
																		progress: progress,
																		title: title,
																		text: text,
																		presentationStyle: presentationStyle,
																		configuration: configuration)
	}
	
	@discardableResult
	public static func presentSuccessHud(on parent: UIViewController,
																		title: String? = nil,
																		text: String? = nil,
																		presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																		configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentSuccess(on: parent,
																	 title: title,
																	 text: text,
																	 presentationStyle: presentationStyle,
																	 configuration: configuration)
	}
	
	@discardableResult
	public static func presentFailureHud(on parent: UIViewController,
																		title: String? = nil,
																		text: String? = nil,
																		presentationStyle: Hud.PresentationStyle = .overCurrentContext,
																		configuration: Hud.Configuration? = nil) -> Promise<Void> {
		return Hud.asyncPresentFailure(on: parent,
																	 title: title,
																	 text: text,
																	 presentationStyle: presentationStyle,
																	 configuration: configuration)
	}
	
	@discardableResult
	public static func dismissHud(from parent: UIViewController) -> Promise<Void> {
		return Hud.asynDismiss(from: parent)
	}

}

public extension Hud {
	
	public static func asyncPresentWait(on parent: UIViewController,
																			title: String? = nil,
																			text: String? = nil,
																			presentationStyle: PresentationStyle = .overCurrentContext,
																			configuration: Configuration? = nil) -> Promise<Void> {
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
	
	public static func asyncPresentProgress(on parent: UIViewController,
																					progress: Progress,
																					title: String? = nil,
																					text: String? = nil,
																					presentationStyle: PresentationStyle = .overCurrentContext,
																					configuration: Configuration? = nil) -> Promise<Void> {
		return Promise<Void>(in: .main, { (fulfill, fail, _) in
			Hud.presentProgress(on: parent,
													progress: progress,
													title: title,
													text: text,
													presentationStyle: presentationStyle,
													configuration: configuration,
													then: {
														fulfill(())
			})
		})
	}
	
	public static func asyncPresentSuccess(on parent: UIViewController,
																				 title: String? = nil,
																				 text: String? = nil,
																				 presentationStyle: PresentationStyle = .overCurrentContext,
																				 configuration: Configuration? = nil) -> Promise<Void> {
		return Promise<Void>(in: .main, { (fulfill, fail, _) in
			Hud.presentSuccess(on: parent,
												 title: title,
												 text: text,
												 presentationStyle: presentationStyle,
												 configuration: configuration,
												 then: {
													fulfill(())
			})
		})
	}
	
	public static func asyncPresentFailure(on parent: UIViewController,
																				 title: String? = nil,
																				 text: String? = nil,
																				 presentationStyle: PresentationStyle = .overCurrentContext,
																				 configuration: Configuration? = nil) -> Promise<Void> {
		return Promise<Void>(in: .main, { (fulfill, fail, _) in
			Hud.presentFailure(on: parent,
												 title: title,
												 text: text,
												 presentationStyle: presentationStyle,
												 configuration: configuration,
												 then: {
													fulfill(())
			})
		})
	}
  
  public static func asynDismiss(from parent: UIViewController) -> Promise<Void> {
    return Promise<Void>(in: .main, { (fulfill, fail, _) in
      Hud.dismiss(from: parent, then: {
        fulfill(())
      })
    })
  }
	
}
