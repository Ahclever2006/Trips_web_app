/// Helper utilities for working with URLs, particularly around CORS and image loading.
class UrlUtils {
  /// Returns a CORS-safe URL for loading images by proxying through weserv.nl with CORS headers.
  ///
  /// [url] The original image URL to make CORS-safe
  /// [size] Optional size parameter for the image proxy (default: 48px)
  ///
  /// The URL is processed through weserv.nl which:
  /// - Adds CORS headers for cross-origin loading
  /// - Resizes the image to specified dimensions
  /// - Applies cover fit to maintain aspect ratio in circular crops
  static String corsSafe(String url, {int size = 48}) {
    // Strip scheme for weserv API
    final u = url.replaceFirst(RegExp(r'^https?://'), '');
    // Proxy through weserv with size and cover fit parameters
    return 'https://images.weserv.nl/?w=$size&h=$size&fit=cover&url=${Uri.encodeComponent(u)}';
  }
}
