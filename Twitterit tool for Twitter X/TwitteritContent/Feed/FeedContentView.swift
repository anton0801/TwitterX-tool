import SwiftUI
import WebKit
import LocalAuthentication

struct FeedContentView: View {
    
    @State private var isUnlocked = false
    @State private var authError: String? = nil
    
    var body: some View {
        VStack {
            if isUnlocked {
                if let u = URL(string: "https://x.com") {
                    TwitteritXFeedView(url: u)
                }
            } else {
                if authError != nil {
                    Text(authError ?? "Some went wrong! Try again.")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                    Button {
                        authenticate()
                    } label: {
                        Text("Authenticate")
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
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            isUnlocked = !UserDefaults.standard.bool(forKey: "locked_feed")
            if !isUnlocked {
                authenticate()
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check if Face ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Set the reason string for the Face ID prompt
            let reason = "Authenticate to access your content"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        authError = "Face ID Authentication failed. Please try again."
                    }
                }
            }
        } else {
            authError = "Face ID is not available on this device."
        }
    }
}

#Preview {
    FeedContentView()
}

struct TwitteritXFeedView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        // Configure WKWebView to handle cookies
        let webView = WKWebView(frame: .zero, configuration: setupWebViewConfig())
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
        restoreCookies(for: webView)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Ensure WebView is always directed to the specified URL
        if uiView.url != url {
            uiView.load(URLRequest(url: url))
        }
    }
    
    private func setupWebViewConfig() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        config.preferences.javaScriptEnabled = true  // Enable JavaScript
        config.allowsInlineMediaPlayback = true  // Allow media playback inline
        config.defaultWebpagePreferences.allowsContentJavaScript = true  // Required for many third-party sites
        return config
    }
    
    // Restore cookies
    private func restoreCookies(for webView: WKWebView) {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.httpCookieStore.getAllCookies { cookies in
            cookies.forEach { webView.configuration.websiteDataStore.httpCookieStore.setCookie($0) }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: TwitteritXFeedView
        
        init(_ parent: TwitteritXFeedView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Ensure that pop-ups open in the same WebView
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let host = navigationAction.request.url?.host else {
                decisionHandler(.cancel)
                return
            }
            
            if host.contains("x.com") || host.contains("twitter") || host.contains("google") || host.contains("apple") {
                decisionHandler(.allow)
            } else {
                decisionHandler(.cancel)  // Cancel the navigation
                if let url = navigationAction.request.url {
                    UIApplication.shared.open(url)  // Open in Safari
                }
            }
        }
        
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            // Display an alert using SwiftUI
            completionHandler()
        }
        
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            completionHandler(true)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                cookies.forEach { cookie in
                    var cookieProperties: [HTTPCookiePropertyKey: Any] = [
                        .name: cookie.name,
                        .value: cookie.value,
                        .domain: cookie.domain,
                        .path: cookie.path,
                        .version: cookie.version,
                        .expires: cookie.expiresDate ?? Date().addingTimeInterval(31536000)
                    ]
                    if let newCookie = HTTPCookie(properties: cookieProperties) {
                        HTTPCookieStorage.shared.setCookie(newCookie)
                    }
                }
            }
        }
    }
}
