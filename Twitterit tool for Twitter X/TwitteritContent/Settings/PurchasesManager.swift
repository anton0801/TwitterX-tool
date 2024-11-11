import Foundation
import StoreKit

class PurchasesManager: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var purchasedProductIDs: Set<String> = []
    @Published var isLoadingProducts = false
    @Published var hasActivePurchase = false
    
    init() {
        Task {
            await loadProducts()
            await observeTransactionUpdates()
        }
        
        Task {
            await checkPurchasedProducts()
        }
    }
    
    func loadProducts() async {
        DispatchQueue.main.async {
            self.isLoadingProducts = true
        }
        do {
            let productIDs: Set<String> = ["com.twitteritcom.Twitterit.lockFeed"]
            products = try await Product.products(for: productIDs)
            DispatchQueue.main.async {
                self.isLoadingProducts = false
            }
        } catch {
            print("Failed to load products: \(error)")
            DispatchQueue.main.async {
                self.isLoadingProducts = false
            }
        }
    }
    
    // Method to initiate a purchase for a specified product
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    // Successful purchase
                    await handle(transaction)
                    return true
                case .unverified(_, _):
                    return false
                }
            case .userCancelled, .pending:
                return false
            @unknown default:
                return false
            }
        } catch {
            print("Purchase failed: \(error)")
            return false
        }
    }
    
    // Method to listen to transaction updates
    func observeTransactionUpdates() async {
        for await verification in Transaction.updates {
            if case .verified(let transaction) = verification {
                await handle(transaction)
            }
        }
    }
    
    // Handle the transaction: mark as purchased and finish the transaction
    private func handle(_ transaction: Transaction) async {
        // Add product to purchased set
        purchasedProductIDs.insert(transaction.productID)
        UserDefaults.standard.set(true, forKey: "locked_feed")
        hasActivePurchase = true
        
        // Complete the transaction
        await transaction.finish()
    }
    
    // Method to check for previously purchased products
    func checkPurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                purchasedProductIDs.insert(transaction.productID)
                hasActivePurchase = true
            }
        }
    }
    
    // Method to restore purchases
    func restorePurchases() async {
        purchasedProductIDs.removeAll()
        await checkPurchasedProducts()
    }
    
}
