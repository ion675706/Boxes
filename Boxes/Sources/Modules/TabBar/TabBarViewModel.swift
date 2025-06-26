
import Foundation

class TabBarViewModel: ObservableObject {
    @Published var current = "dashboard"
    @Published var isTabBarShown = true
    
    enum Tab: String, CaseIterable {
        case dashboard = "dashboard"
        case containers = "containers"
        case categories = "categories"
        case allItems = "allItems"
        
        var title: String {
            switch self {
            case .dashboard: return "Dashboard"
            case .containers: return "Containers"
            case .categories: return "Categories"
            case .allItems: return "All Items"
            }
        }
        
        var image: String {
            switch self {
            case .dashboard: return "dashboard"
            case .containers: return "containers"
            case .categories: return "category"
            case .allItems: return "allItems"
            }
        }
    }
}
