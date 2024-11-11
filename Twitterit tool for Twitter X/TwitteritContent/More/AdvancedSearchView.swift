
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    var url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct AdvancedSearchView: View {
    
    @Environment(\.presentationMode) var presMode
    
    @State var nicknameSearchEnabled = false
    @State var fromSearchEnabled = false
    @State var sinceSearchEnabled = false
    @State var untilSearchEnabled = false
    @State var wordSearchEnabled = false
    @State var hashtagSearchEnabled = false
    
    @State var nicknameInput = ""
    @State var fromInput = ""
    @State var since = ""
    @State var until = ""
    @State var wordInput = ""
    @State var hashtag = ""
    
    @State var alert = false
    @State var alertSubject = ""
    
    @State var sinceFromVisibleSheet = false
    @State var untilFromVisibleSheet = false
    
    @State var sinceDatePicked: Date = Date.now
    @State var untilDatePicked: Date = Date.now
    
    @State var finalLink = ""
    @State var sheetSearchVisible = false

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                VStack {
                    Text("Advanced search")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    
                    VStack {
                        HStack {
                            Text("Nickname")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Toggle(isOn: $nicknameSearchEnabled) {
                                
                            }
                            .onChange(of: nicknameSearchEnabled) { newValue in
                                if !newValue {
                                    nicknameInput = ""
                                }
                            }
                        }
                        TextField("@", text: $nicknameInput)
                            .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                    .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                            )
                            .disabled(!nicknameSearchEnabled)
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
                    
                    VStack {
                        HStack {
                            Text("From")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Toggle(isOn: $fromSearchEnabled) {
                                
                            }
                            .onChange(of: fromSearchEnabled) { newValue in
                                if !newValue {
                                    fromInput = ""
                                }
                            }
                        }
                        TextField("from", text: $fromInput)
                            .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                    .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                            )
                            .disabled(!fromSearchEnabled)
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
                        HStack {
                            Text("Since")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Toggle(isOn: $sinceSearchEnabled) {
                                
                            }
                            .onChange(of: sinceSearchEnabled) { newValue in
                                if !newValue {
                                    since = ""
                                }
                            }
                        }
                        Button {
                            sinceFromVisibleSheet = true
                        } label: {
                            Text(since.isEmpty ? "since" : since)
                                .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                        .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                                )
                        }
                        .disabled(!sinceSearchEnabled)
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
                        HStack {
                            Text("Until")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Toggle(isOn: $untilSearchEnabled) {
                                
                            }
                            .onChange(of: untilSearchEnabled) { newValue in
                                if !newValue {
                                    until = ""
                                }
                            }
                        }
                        Button {
                            untilFromVisibleSheet = true
                        } label: {
                            Text(until.isEmpty ? "until" : until)
                                .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                        .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                                )
                        }
                        .disabled(!untilSearchEnabled)
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
                    
                    VStack {
                        HStack {
                            Text("Word")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Toggle(isOn: $wordSearchEnabled) {
                                
                            }
                            .onChange(of: wordSearchEnabled) { newValue in
                                if !newValue {
                                    wordInput = ""
                                }
                            }
                        }
                        TextField("word", text: $wordInput)
                            .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                    .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                            )
                            .disabled(!wordSearchEnabled)
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
                    
                    VStack {
                        HStack {
                            Text("Hashtag")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Toggle(isOn: $hashtagSearchEnabled) {
                                
                            }
                            .onChange(of: hashtagSearchEnabled) { newValue in
                                if !newValue {
                                    hashtag = ""
                                }
                            }
                        }
                        TextField("hashtag", text: $hashtag)
                            .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                    .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                            )
                            .disabled(!hashtagSearchEnabled)
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
                    
                    Button {
                        buildLink()
                    } label: {
                        Text("Search")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                    .fill(Color.black)
                            )
                    }
                }
                .padding(.horizontal)
                
            }
            
        }
        .alert(isPresented: $alert) {
            Alert(title: Text("Alert!"), message: Text(alertSubject))
        }
        .sheet(isPresented: $sinceFromVisibleSheet) {
            DatePicker("Picker", selection: $sinceDatePicked, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
        }
        .sheet(isPresented: $untilFromVisibleSheet) {
            DatePicker("Picker", selection: $untilDatePicked, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
        }
        .sheet(isPresented: $sheetSearchVisible) {
            if let encodedURLString = finalLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encodedURLString) {
                SafariView(url: url)
            }
        }
        .onChange(of: sinceDatePicked) { newValue in
            since = formattedDateString(from: newValue)
        }
        .onChange(of: untilDatePicked) { newValue in
            until = formattedDateString(from: newValue)
        }
    }
    
    private func buildLink() {
        var queryList: [String] = []
        if nicknameSearchEnabled {
            queryList.append("\(nicknameInput)")
        }
        if fromSearchEnabled {
            queryList.append("from:\(fromSearchEnabled)")
        }
        if sinceSearchEnabled {
            queryList.append("since:\(since)")
        }
        if untilSearchEnabled {
            queryList.append("until:\(until)")
        }
        if wordSearchEnabled {
            queryList.append("\(wordInput)")
        }
        if hashtagSearchEnabled {
            queryList.append("-he \(hashtag)")
        }
        if !queryList.isEmpty {
            finalLink = "https://x.com/search?q=\(queryList.joined(separator: " "))"
            sheetSearchVisible = true
        } else {
            alertSubject = "At least one of the fields must be non-empty!"
            alert = true
        }
    }
    
    private func formattedDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
}

#Preview {
    AdvancedSearchView()
}
