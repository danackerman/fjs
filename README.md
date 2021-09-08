# fjs
iOS Coding

I went for the Bonus of using SwiftUI.   While fun, that did bring in complications.

Requirements call for the Map Pins to be tappable.  Unfortunately .onTapGesture is broken on iOS 14.
see https://developer.apple.com/forums/thread/659748

I could rewrite the code to not use Pins by doing a custom annotation.  I opted not too, since if we were doing an actual card in a sprint, and we encountered this it would be brought up and discussed before we moved forward.

