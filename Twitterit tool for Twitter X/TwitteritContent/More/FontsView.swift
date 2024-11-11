import SwiftUI

struct FontsView: View {
    
    @State var textInputed = ""
    
    var fonts = ["Academy Engraved LET", "Al Nile", "American Typewriter", "Anton SC", "Apple Color Emoji", "Apple SD Gothic Neo", "Apple Symbols", "Arial", "Arial Hebrew", "Arial Rounded MT Bold", "Avenir", "Avenir Next", "Avenir Next Condensed", "Baskerville", "Bodoni 72", "Bodoni 72 Oldstyle", "Bodoni 72 Smallcaps", "Bodoni Ornaments", "Bradley Hand", "Chalkboard SE", "Chalkduster", "Charter", "Cochin", "Copperplate", "Courier New", "Damascus", "Dancing Script", "Devanagari Sangam MN", "Didot", "DIN Alternate", "DIN Condensed", "DynaPuff", "Euphemia UCAS", "Farah", "Futura", "Galvji", "Geeza Pro", "Georgia", "Gill Sans", "Grantha Sangam MN", "Helvetica", "Helvetica Neue", "Hiragino Maru Gothic ProN", "Hiragino Mincho ProN", "Hiragino Sans", "Hoefler Text", "Impact", "Itim", "Kailasa", "Kefa", "Khmer Sangam MN", "Kohinoor Bangla", "Kohinoor Devanagari", "Kohinoor Gujarati", "Kohinoor Telugu", "Lao Sangam MN", "Malayalam Sangam MN", "Marker Felt", "Menlo", "Mishafi", "Mukta Mahee", "Myanmar Sangam MN", "Noteworthy", "Noto Nastaliq Urdu", "Noto Sans Kannada", "Noto Sans Myanmar", "Noto Sans Oriya", "Noto Sans Syriac", "Optima", "Pacifico", "Palatino", "Papyrus", "Party LET", "PingFang HK", "PingFang MO", "PingFang SC", "PingFang TC", "Poppins", "Roboto", "Rockwell", "Rubik Wet Paint", "Savoye LET", "Sinhala Sangam MN", "Snell Roundhand", "STIX Two Math", "STIX Two Text", "Symbol", "Tamil Sangam MN", "Thonburi", "Times New Roman", "Tiny5", "Trebuchet MS", "Unlock", "Verdana", "Zapf Dingbats", "Zapfino"]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Fonts")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                
                TextField("Your text", text: $textInputed, axis: .vertical)
                    .lineLimit(4...)
                    .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                    .background(
                        RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                            .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
                    )
                    .padding()
                    
                LazyVStack {
                    ForEach(fonts, id: \.self) { fontName in
                        VStack {
                            HStack {
                                Text(textInputed.isEmpty ? "Your text" : textInputed)
                                    .font(.custom(fontName, size: 16))
                                    .foregroundColor(.black)
                                Spacer()
                                Button {
//                                    let attributes: [NSAttributedString.Key: Any] = [
//                                        .font: UIFont(name: font, size: 16) ?? UIFont.systemFont(ofSize: 16)
//                                    ]
//                                    let attributedString = NSAttributedString(string: textInputed, attributes: attributes)
//
//                                    if let rtfData = try? attributedString.data(from: NSRange(location: 0, length: attributedString.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]) {
//                                        UIPasteboard.general.setData(rtfData, forPasteboardType: "public.rtf")
//                                        
//                                    }
                                    
                                    let attributes: [NSAttributedString.Key: Any] = [
                                            .font: UIFont(name: fontName, size: 16) ?? UIFont.systemFont(ofSize: 16)
                                        ]
                                        let attributedString = NSAttributedString(string: textInputed, attributes: attributes)
                                        
                                        let image = attributedStringToImage(attributedString)
                                        
                                        if let pngData = image.pngData() {
                                            UIPasteboard.general.setData(pngData, forPasteboardType: "public.png")
                                        }
                                    
                                } label: {
                                    Image("copy")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
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
    
    func attributedStringToImage(_ attributedString: NSAttributedString) -> UIImage {
        let size = attributedString.size()
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        attributedString.draw(in: CGRect(origin: .zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
}

#Preview {
    FontsView()
}
