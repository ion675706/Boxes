
import SwiftUI

struct TabBarButton: View {
    var title: String
    var image: String
    var tag: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = tag
            }
        } label: {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(selected == tag
                                     ? Color.init(red: 231/255, green: 33/255, blue: 33/255)
                                     : Color.init(red: 144/255, green: 144/255, blue: 144/255)
                    )
                Text(title)
                    .font(.custom("DMSans-Regular", size: 12))
                    .foregroundStyle(selected == tag
                                     ? Color.init(red: 231/255, green: 33/255, blue: 33/255)
                                     : Color.init(red: 144/255, green: 144/255, blue: 144/255)
                    )
            }
        }
        .padding(10)
    }
}

#Preview {
    TabBarButton(title: "Dashboard", image: "dashboard", tag: "dashboard", selected: .init(get: {
        "dashboard"
    }, set: { _ in
        
    }))
}
