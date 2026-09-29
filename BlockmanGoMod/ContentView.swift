import SwiftUI

struct ContentView: View {
    @State private var showKeySheet = false
    @State private var showSuccess = false
    @State private var inputKey = ""
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.05)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Button(action: { showKeySheet = true }) {
                    Text("STARS")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                }

                Spacer()

                Text("Mod by Lâm Lỏ")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.55))
                    .padding(.bottom, 45)
            }
        }
        .sheet(isPresented: $showKeySheet) {
            KeySheet(
                inputKey: $inputKey,
                errorMessage: $errorMessage,
                isPresented: $showKeySheet,
                onSuccess: {
                    showKeySheet = false
                    showSuccess = true
                }
            )
        }
        .overlay {
            if showSuccess {
                SuccessOverlay(isPresented: $showSuccess)
            }
        }
    }
}

// MARK: - Bảng nhập key
struct KeySheet: View {
    @Binding var inputKey: String
    @Binding var errorMessage: String
    @Binding var isPresented: Bool
    var onSuccess: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.05).ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Nhập Key")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                TextField("Nhập key tại đây", text: $inputKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 30)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }

                Button(action: {
                    if inputKey == "MiniKS" {
                        errorMessage = ""
                        onSuccess()
                    } else {
                        errorMessage = "Key không đúng"
                    }
                }) {
                    Text("Xác nhận")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }

                Button("Đóng") { isPresented = false }
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

// MARK: - Popup Thành Công
struct SuccessOverlay: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Thành Công")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)

                Text("[VNMOD_IOS] VIP của bạn còn:\n9999 giờ và 0 phút\nVui lòng không:\n[Chia sẻ key cho người khác]\n[Sử dụng trên 2 thiết bị trở lên]\n[Gỡ game cài lại nếu không cần thiết]")
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)

                Button(action: { isPresented = false }) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.95, green: 0.35, blue: 0.3))
                            .frame(width: 60, height: 60)
                        Image(systemName: "xmark")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 4)
            }
            .padding(28)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 40)
        }
    }
}
