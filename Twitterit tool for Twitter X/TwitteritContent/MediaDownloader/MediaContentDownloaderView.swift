import SwiftUI
import WebKit
import Photos

protocol WebDownloadable: WKDownloadDelegate {
    func downloadDidFinish(fileResultPath: URL)
    func downloadDidFail(error: Error, resumeData: Data?)
}

class WebContentDownloader: NSObject {
    
    private var filePathDestination: URL?
    
    weak var downloadDelegate: WebDownloadable?
    
    func generateTempFile(with suggestedFileName: String?) -> URL {
        let temporaryDirectoryFolder = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        return temporaryDirectoryFolder.appendingPathComponent(suggestedFileName ?? ProcessInfo().globallyUniqueString)
    }
    
    func downloadFileOldWay(fileURL: URL, optionSessionCookies: [HTTPCookie]?) {
        // Your classic URL Session Data Task
    }
    
    private func cleanUp() {
        filePathDestination = nil
    }
}

struct MediaContentDownloaderView: View {
    
    @State var isDownloadViewVisible = false
    @State var tweetURL = ""
    @State var error: String? = nil
    @State var htmlContent = ""
    @State var loading = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Favorites media")
                        .font(.system(size: 42))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top)
                
                VStack {
                    TextField("Twitter video/Photo/GIf URL", text: $tweetURL)
                        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                        .background(
                            RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                        )
                    
                    if let error = error {
                        Text(error)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    Button {
                        fetchMedia()
                    } label: {
                        Text("Get media")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                    .fill(Color.init(red: 29/255, green: 155/255, blue: 240/255))
                            )
                    }
                    .padding(.top, 4)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                        .fill(.white)
                )
                .background(
                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                        .stroke(Color.init(red: 207/255, green: 217/255, blue: 222/255))
                )
                
                VStack(alignment: .leading) {
                    Text("How it works?")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    HStack {
                        Text("1")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.init(red: 29/255, green: 155/255, blue: 240/255))
                            )
                        
                        Text("Open “Twitter (X)” and find post.")
                    }
                    
                    HStack {
                        Text("2")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.init(red: 29/255, green: 155/255, blue: 240/255))
                            )
                        
                        Text("Click the share.")
                    }
                    
                    HStack {
                        Text("3")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.init(red: 29/255, green: 155/255, blue: 240/255))
                            )
                        
                        Text("Click “Copy link”.")
                    }
                    
                    HStack {
                        Text("4")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.init(red: 29/255, green: 155/255, blue: 240/255))
                            )
                        
                        // MARK: set up application name
                        Text("Open Writter X.")
                    }
                    
                    HStack {
                        Text("5")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.init(red: 29/255, green: 155/255, blue: 240/255))
                            )
                        
                        Text("Paste the URL and click the “Get media” button.")
                    }
                    
                    HStack {
                        Spacer()
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                        .fill(.white)
                )
                .background(
                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                        .stroke(Color.init(red: 207/255, green: 217/255, blue: 222/255))
                )
                .padding(.top)
                
                Spacer()
            }
            .padding(.horizontal)
            
            if isDownloadViewVisible {
                DownloaderView(htmlContent: htmlContent)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    withAnimation {
                                        isDownloadViewVisible = false
                                    }
                                }
                            }
                    )
            }
            
            if loading {
                VStack {
                    ProgressView()
                }
                .background(
                    Color.white
                )
                .ignoresSafeArea()
            }
        }
        .preferredColorScheme(.light)
    }
    
    private func fetchMedia() {
        if !verifyUrl(urlString: tweetURL) || !tweetURL.contains("x.com") {
            withAnimation(.easeInOut) {
                self.error = "URL tweet is invalid!\nURL must be from x.com website."
            }
            return
        }
        
        guard let url = URL(string: "https://twdown.net/download.php") else {
            withAnimation(.easeInOut) {
                self.error = "Something went wrong!\nTry again later."
            }
            return
        }
        
        if self.error != nil {
            withAnimation(.easeInOut) {
                self.error = nil
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let formData = "URL=\(tweetURL)"
        request.httpBody = formData.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let html = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        self.isDownloadViewVisible = true
                        self.htmlContent = html
                        self.loading = false
                    }
                }
            } else {
                self.error = "Failed to fetch data:" + (error?.localizedDescription ?? "Unknown error")
                print("Failed to fetch data:", error?.localizedDescription ?? "Unknown error")
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        self.loading = false
                    }
                }
            }
        }.resume()
    }
    
    private func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
}

#Preview {
    MediaContentDownloaderView()
}


struct DownloaderView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: setupWebViewConfig())
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
         
        webView.loadHTMLString(htmlContent, baseURL: URL(string: "https://twdown.net"))
        return webView
    }

    private func setupWebViewConfig() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        config.preferences.javaScriptEnabled = true  // Enable JavaScript
        config.allowsInlineMediaPlayback = true  // Allow media playback inline
        config.defaultWebpagePreferences.allowsContentJavaScript = true  // Required for many third-party sites
        return config
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(htmlContent, baseURL: URL(string: "https://twdown.net"))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKDownloadDelegate {
        var parent: DownloaderView
        
        init(_ parent: DownloaderView) {
            self.parent = parent
        }
        
        func download(_ download: WKDownload, decideDestinationUsing
                      response: URLResponse, suggestedFilename: String,
                      completionHandler: @escaping (URL?) -> Void) {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
            let name = suggestedFilename.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "cannotencode"
            completionHandler(URL(string: name, relativeTo: urls[0]))
        }
        
        func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
            download.delegate = self
        }
        
        // OPTIONAL
        func downloadDidFinish(_ download: WKDownload) {
            // OPTIONAL. When download is terminated
            print("terminated download \(download)")
        }
        
        func download(_ download: WKDownload, didFailWithError error: Error, resumeData: Data?) {
            // OPTIONAL: In case on Error
            print("error download \(error.localizedDescription)")
        }
        
        //        func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String) async -> URL? {
        //            let urls = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
        //            let name = suggestedFilename.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "cannotencode"
        //            return URL(string: name, relativeTo: urls[0])
        //        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Ensure that pop-ups open in the same WebView
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
            if navigationAction.shouldPerformDownload {
                decisionHandler(.download, preferences)
            } else {
                decisionHandler(.allow, preferences)
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if navigationResponse.canShowMIMEType {
                decisionHandler(.allow)
            } else {
                decisionHandler(.download)
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, isMediaURL(url) {
                // Download the media
                // downloadMedia(from: url)
                decisionHandler(.download)
            } else {
                decisionHandler(.allow)
            }
        }
        
        // Check if the URL points to media content
        func isMediaURL(_ url: URL) -> Bool {
            let mediaExtensions = ["mp4", "jpg", "jpeg", "png", "gif"]
            return mediaExtensions.contains(url.pathExtension.lowercased())
        }
        
    }
}
