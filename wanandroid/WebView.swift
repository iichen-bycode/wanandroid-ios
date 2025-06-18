import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var progress: Double

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        // 监听 estimatedProgress
        webView.addObserver(context.coordinator, forKeyPath: "estimatedProgress", options: .new, context: nil)

        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        override func observeValue(
            forKeyPath keyPath: String?,
            of object: Any?,
            change: [NSKeyValueChangeKey : Any]?,
            context: UnsafeMutableRawPointer?
        ) {
            if keyPath == "estimatedProgress",
               let webView = object as? WKWebView {
                DispatchQueue.main.async {
                    self.parent.progress = webView.estimatedProgress
                }
            }
        }
    }
}
