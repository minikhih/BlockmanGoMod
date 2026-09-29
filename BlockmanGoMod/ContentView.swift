import SwiftUI

struct ContentView: View {
    @State private var showKeySheet = false
    @State private var showSuccess = false
    @State private var inputKey = ""
    @State private var errorMessage = ""
    @State private var isActivated = false

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.05)
                .ignoresSafeArea()

            if isActivated {
                MenuView()
            } else {
                VStack {
                    Spacer()

                    Button(action: { showKeySheet = true }) {
                        Text("STARS")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Mod by MiniKS💤")
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.55))
                        .padding(.bottom, 45)
                }
            }
        }
        .sheet(isPresented: $showKeySheet) {
            KeySheet(
                inputKey: $inputKey,
                errorMessage: $errorMessage,
                isPresented: $showKeySheet,
                onSuccess: {
                    isActivated = true
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
            Color.black.opacity(0.6).ignoresSafeArea()

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

// MARK: - Menu chính
struct MenuView: View {
    @State private var aimbotOn = false
    @State private var dauOn = false
    @State private var coOn = false
    @State private var espLineOn = false
    @State private var espBoxOn = false
    @State private var aimRadius: Double = 20
    @State private var showCircle = true

    // Toggle Hub
    @State private var showMenu = true

    var allOn: Bool {
        aimbotOn && dauOn && coOn && espLineOn && espBoxOn
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Vòng tròn xanh giữa màn hình
            if showCircle && showMenu {
                Circle()
                    .stroke(Color.green, lineWidth: 3)
                    .frame(width: aimRadius * 2, height: aimRadius * 2)
                    .allowsHitTesting(false)
            }

            if showMenu {
                // MENU ĐẦY ĐỦ
                VStack(spacing: 8) {
                    // Header
                    Text("FREE FIRE")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.red)

                    // Toggle Hub
                    Button(action: {}) {
                        Text("TOGGLE HUB")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(allOn ? Color.green : Color.orange)
                    }
                    .onTapGesture(count: 2) {
                        // Nhấn đúp → ẩn menu
                        withAnimation { showMenu = false }
                    }
                    .simultaneousGesture(
                        TapGesture(count: 1).onEnded {
                            // Nhấn đơn → bật/tắt tất cả
                            let newValue = !allOn
                            aimbotOn = newValue
                            dauOn = newValue
                            coOn = newValue
                            espLineOn = newValue
                            espBoxOn = newValue
                        }
                    )

                    // Toggle buttons
                    MenuButton(title: "Aimbot", isOn: $aimbotOn)
                    MenuButton(title: "Đầu", isOn: $dauOn)
                    MenuButton(title: "Cổ", isOn: $coOn)

                    // Aim Radius slider
                    VStack(spacing: 6) {
                        Text("Aim Radius \(aimRadius, specifier: "%.2f")")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)

                        HStack(spacing: 14) {
                            Button(action: {
                                aimRadius = max(10, aimRadius - 5)
                            }) {
                                Text("−")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.red)
                                    .cornerRadius(6)
                            }

                            Slider(value: $aimRadius, in: 10...300)
                                .accentColor(.green)

                            Button(action: {
                                aimRadius = min(300, aimRadius + 5)
                            }) {
                                Text("+")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.red)
                                    .cornerRadius(6)
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.blue)

                    MenuButton(title: "ESP Line", isOn: $espLineOn)
                    MenuButton(title: "ESP Box", isOn: $espBoxOn)

                    Spacer()

                    Toggle("Hiện vòng tròn", isOn: $showCircle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                }
                .transition(.opacity)
            } else {
                // CHẾ ĐỘ THU NHỎ — chỉ còn nút tròn
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation { showMenu = true }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 56, height: 56)
                                    .shadow(radius: 6)
                                Image(systemName: "circle.grid.2x2.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 50)
                            .padding(.trailing, 20)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Nút menu
struct MenuButton: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Button(action: { isOn.toggle() }) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(isOn ? Color.green : Color.blue)
        }
    }
}
