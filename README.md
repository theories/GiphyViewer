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
6. In the GiphyViewer scheme, select the **Arguments** tab
7. Under **Environment Variables**, find the variable named `GiphyViewer_API_KEY`
8. Modify the value of the variable. Replace `Enter_Your_Giphy_API_Key_Here` with your Giphy API Key (see developers.giphy.com)  

