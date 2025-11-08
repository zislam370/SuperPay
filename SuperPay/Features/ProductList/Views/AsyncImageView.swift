import SwiftUI

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

struct AsyncImageView: View {
    let url: URL?
    var placeholder: Image = Image(systemName: "photo")
    @StateObject private var viewModel: AsyncImageViewModel

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
        _viewModel = StateObject(wrappedValue: AsyncImageViewModel(url: url))
    }

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width * 0.9 // Increase height ratio for a taller image
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: width, height: height)
                } else if let data = viewModel.imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                } else if viewModel.didFail {
                    placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .opacity(0.5)
                        .clipped()
                } else {
                    placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .opacity(0.5)
                        .clipped()
                }
            }
        }
        .aspectRatio(10/9, contentMode: .fit) // Use a taller aspect ratio
    }
}
