## Combine + UIKit + MVVM-C + POP Network Layer

Sample project with Combine, UIKit and MVVM-C architecture. Clean and testable network layer with protocol oriented programming.

+ Architecture: *MVVM-Coordinator*
+ Network layer: *Alamofire* 
+ Local persistence: *Realm*
+ FRP framework: *Combine*
+ Swift Package Manager + Carthage (no Cocoapods allowed)


### Tool: Xcode Build Time

Article: `https://www.onswiftwings.com/posts/build-time-optimization-part1/`

1) Install `[sudo] gem install xcode-build-times`
2) Install  XCLogParser  `git clone https://github.com/spotify/XCLogParser && rake install`  (https://github.com/spotify/XCLogParser)

From project folder:
```
#1 Instal run script phases
xcode-build-times install ./

#2 Make a build on Xcode 

#3 Generate build-times report
xcode-build-times generate

#3 Generate build report
xclogparser parse --project TryNetworkLayer --reporter html --output build/reports
```
