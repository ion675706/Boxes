
import SwiftUI

struct AllItemsSortScreen: View {
    enum SortBy: String, CaseIterable, Identifiable {
        case category = "Category"
        case name = "Name"
        case container = "Container"
        case room = "Room"
        var id: String { rawValue }
    }
    enum CreationTime: String, CaseIterable, Identifiable {
        case latest = "Latest"
        case oldest = "Oldest"
        var id: String { rawValue }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSortBy: SortBy = .category
    @State private var selectedCreationTime: CreationTime = .latest
    var onApply: ((SortBy, CreationTime) -> Void)? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        // Sort by section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Sort by:")
                                .font(.custom("DMSans-Bold", size: 20))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            ForEach(SortBy.allCases) { option in
                                RadioButtonRow(title: option.rawValue, isSelected: selectedSortBy == option) {
                                    selectedSortBy = option
                                }
                            }
                        }
                        // Creation time section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Creation time:")
                                .font(.custom("DMSans-Bold", size: 20))
                                .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                            ForEach(CreationTime.allCases) { option in
                                RadioButtonRow(title: option.rawValue, isSelected: selectedCreationTime == option) {
                                    selectedCreationTime = option
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
//            .navigationTitle("Sort")
            .navigationBarTitle("Sort", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onApply?(selectedSortBy, selectedCreationTime)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.custom("DMSans-Medium", size: 20))
                    .foregroundColor(Color.init(red255: 221, green255: 33, blue255: 33))
                }
            }
        }
    }
}

struct RadioButtonRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.custom("DMSans-Regular", size: 18))
                    .foregroundStyle(Color.init(red255: 35, green255: 35, blue255: 35))
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    if isSelected {
                        Circle()
                            .foregroundStyle(Color.init(red255: 221, green255: 33, blue255: 33))
                            .frame(width: 14, height: 14)
                    }
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AllItemsSortScreen()
}
