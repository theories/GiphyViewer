# GiphyViewer

Search the Giphy API in iOS

##### Features

* Search Giphy.com using Giphy API
* Support for Giphy Trending data

##### Requirements

* Cocoapods v 1.5.0+
* XCode 9.2+
* Giphy API Key (see https://developers.giphy.com)

##### Installation & Configuration

1. Clone the repository 
2. Run `pod install` at command line
3. Open **GiphyViewer.xcworkspace** in XCode
4. In XCode, select Product->Scheme->Manage Schemes
5. Double click on the **GiphyViewer** scheme
6. Under **Build Settings** for the **GiphyViewer** target, find the __GIPHY_API_KEY__ setting in the User-Defined section 
7. Modify the value of the variable. Replace `YOUR_GIPHY_API_KEY` with your Giphy API Key (see developers.giphy.com)  

