import SwiftUI

// ImageCache is a singleton for caching UIImage objects in memory to optimize image loading in views.
class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

// AsyncImageView displays an image from a URL asynchronously, showing loading and error states.
struct AsyncImageView: View {
    // ObservedObject view model handles image loading and state management
    @ObservedObject var viewModel: AsyncImageViewModel
    // Placeholder image shown while loading or on error
    var placeholder: Image = Image(systemName: "photo")
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width * 0.9 // Calculate height for a taller image aspect ratio
            Group {
                // Show progress indicator while image is loading
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: width, height: height)
                // Show loaded image if available
                } else if let data = viewModel.imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                // Show placeholder if image loading failed
                } else if viewModel.didFail {
                    placeholder
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .opacity(0.5)
                        .clipped()
                // Show placeholder while waiting for image data
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
        .aspectRatio(10/9, contentMode: .fit) // Use a taller aspect ratio for the image view
    }
}
