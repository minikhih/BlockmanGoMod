import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.11, blue: 0.11)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("BLOCKMAN GO MOD")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                Spacer()

                VStack(spacing: 4) {
                    Text("Made by iOSViet.Co")
                        .font(.system(size: 17))
                        .foregroundColor(.white)

                    Text("cre: @minikshaha12")
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.75))
                }
                .padding(.bottom, 45)
            }
        }
    }
}
