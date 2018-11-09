# JAHud+Hydra

[Hydra (promises)](https://github.com/malcommac/Hydra) extensions for JAHud

# Why (a seperate library)?

Because you shouldn't be burdened by my lazieness or choices.  It's bad enough that I've included PureLayout in the initial library

This extension takes...

~~~~
progress.completedUnitCount = 0
var config = Hud.Configuration()
config.progress.strokeWidth = 3.0
config.state.fillStyle = .filled
Hud.presentProgress(on: self, progress: progress, title: "All your base are belong to us", text: "So there", configuration: config) {
	DispatchQueue.global(qos: .userInitiated).async {
		while self.progress.fractionCompleted < 1.0 {
			Thread.sleep(forTimeInterval: 0.5)//Double.random(in: 1.0...5.0))
			let amount = Int.random(in: 5...10)
			let value = min(100, self.progress.completedUnitCount + Int64(amount))
			self.progress.completedUnitCount += value
		}
		Thread.sleep(forTimeInterval: 1.0)
		DispatchQueue.main.async {
			Hud.presentSuccess(on: self) {
				Hud.dismiss(from: self)
			}
		}
	}
}
~~~~

And turns it into something more like...

~~~
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
~~~

# JAHud

JAHud is Just Another HUD, written in Swift.

There a plenty of other (and better) HUDs for Swift, but I just wanted something a little more ... different.

The project is also a learning exercise in building, implementing and managing custom views as well as maintaining their dynamic states

## Features

- Infinite wait, using a customised "activity indicator", which can be configured with different colors (and technically different sizes)
- Progress. Simply circular progress, which is presented around the wait indicator, because most implementations I found didn't provide both and it's annoying
- Success and Failure indicators.  Simple tick and cross images, supporting outline and filled states and configurable colors
- Animated state changes.  So swicthing from "progress" to "success" doesn't require a new hud, the state is changed on the existing hud
- Visual effects background.  Sure you can color it and do all sorts of other fancy things, but I was playing around with it

One feature I really like, is the ability to provide a "completion" handler with the presentation and dismissal phases

~~~~
progress.completedUnitCount = 0
var config = Hud.Configuration()
config.progress.strokeWidth = 3.0
config.state.fillStyle = .filled
Hud.presentProgress(on: self, progress: progress, title: "All your base are belong to us", text: "So there", configuration: config) {
	DispatchQueue.global(qos: .userInitiated).async {
		while self.progress.fractionCompleted < 1.0 {
			Thread.sleep(forTimeInterval: 0.5)//Double.random(in: 1.0...5.0))
			let amount = Int.random(in: 5...10)
			let value = min(100, self.progress.completedUnitCount + Int64(amount))
			self.progress.completedUnitCount += value
		}
		Thread.sleep(forTimeInterval: 1.0)
		DispatchQueue.main.async {
			Hud.presentSuccess(on: self) {
				Hud.dismiss(from: self)
			}
		}
	}
}
~~~~

Basically these are called AFTER the animation effects have completed, meaning you don't need to try and "guess" when the Hud's animation has completed, espically helpful when switch states

The API also provides both global and instance configuration support, allowing for an adaptable solution, because there's always that one screen that just wants to be different 🙄
