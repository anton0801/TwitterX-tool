import SwiftUI

struct NewsView: View {
    var body: some View {
        VStack {
            Text("News")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .fontWeight(.semibold)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(newsList, id: \.id) { article in
                        VStack(alignment: .leading) {
                            Text(article.date)
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                            Text(article.text)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .fontWeight(.regular)
                            
                            HStack {
                                Spacer()
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                .stroke(Color.init(red: 207/255, green: 217/255, blue: 222/255))
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    NewsView()
}
