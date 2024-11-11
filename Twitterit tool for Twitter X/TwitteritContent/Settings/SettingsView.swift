import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.requestReview) var reviewRequest
    
    @StateObject var purchasesManager = PurchasesManager()
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.top)
            
            HStack {
                Text("Purchase")
                    .font(.system(size: 32))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.top)
            
            VStack(spacing: 18) {
                Button {
                    Task {
                        await purchasesManager.restorePurchases()
                    }
                } label: {
                    HStack(spacing: 14) {
                        Image("restore_purchase")
                            .resizable()
                            .frame(width: 28, height: 28)
                        Text("Restore")
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
                
                if !purchasesManager.hasActivePurchase {
                    Rectangle()
                        .fill(Color.init(red: 207/255, green: 217/255, blue: 222/255))
                        .frame(height: 0.5)
                    
                    Button {
                        Task {
                            await purchasesManager.purchase(purchasesManager.products[0])
                        }
                    } label: {
                        HStack(spacing: 14) {
                            Image("feed_lock")
                                .resizable()
                                .frame(width: 28, height: 28)
                            Text("Buy feed lock")
                                .font(.system(size: 18))
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                }
                
            }
            .padding([.vertical, .leading])
            .background(
                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
            )
            
            HStack {
                Text("App")
                    .font(.system(size: 32))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.top)
            
            VStack(spacing: 18) {
                Button {
                    reviewRequest()
                } label: {
                    HStack(spacing: 14) {
                        Image("rate_us")
                            .resizable()
                            .frame(width: 28, height: 28)
                        Text("Rate us")
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
            }
            .padding([.vertical, .leading])
            .background(
                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .fill(Color.init(red: 239/255, green: 243/255, blue: 244/255))
            )
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsView()
}
