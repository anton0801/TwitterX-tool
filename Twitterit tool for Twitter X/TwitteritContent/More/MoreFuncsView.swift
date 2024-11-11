import SwiftUI

struct MoreFuncsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("More")
                        .font(.system(size: 42))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 16) {
                    NavigationLink(destination: FontsView()) {
                        Image("fonts")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                    }
                    NavigationLink(destination: NewsView()) {
                        Image("news")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                    }
                }
                
                HStack(spacing: 16) {
                    NavigationLink(destination: AdvancedSearchView()) {
                        Image("advanced_search")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MoreFuncsView()
}
