import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @State private var inputText = ""

    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.11, blue: 0.11)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Button(action: { showSheet = true }) {
                    Text("STARS")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                }

                Spacer()

                Text("@minikshaha12 IOSviet fake")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.75))
                    .padding(.bottom, 45)
            }
        }
        .sheet(isPresented: $showSheet) {
            InputSheet(text: $inputText, isPresented: $showSheet)
        }
    }
}

struct InputSheet: View {
    @Binding var text: String
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Nhập text", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Text("Bạn đã nhập: \(text)")
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding()
            .navigationTitle("Input")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Đóng") { isPresented = false }
                }
            }
        }
    }
}
