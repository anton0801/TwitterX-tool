import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FeedContentView()
                .tabItem {
                    Image("home")
                }
            MediaContentDownloaderView()
                .tabItem {
                    Image("favorite_media")
                }
            SettingsView()
                .tabItem {
                    Image("settings")
                }
            MoreFuncsView()
                .tabItem {
                    Image("more")
                }
        }
        .accentColor(.blue)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
