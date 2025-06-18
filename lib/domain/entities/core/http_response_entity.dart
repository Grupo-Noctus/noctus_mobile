final class HttpResponseEntity<T> {
  const HttpResponseEntity({
    this.data,
    this.statusCode,
  });

  final T? data;

  final int? statusCode;
}

final class HttpResponsePaginatedEntity {
  final int currentPage;
  final int totalItems;
  final int totalPages;
  final List data;

  const HttpResponsePaginatedEntity({
    required this.currentPage,
    required this.totalItems,
    required this.totalPages,
    required this.data,
  });

  factory HttpResponsePaginatedEntity.fromMap(Map<String, dynamic> map) {
    return HttpResponsePaginatedEntity(
      currentPage: map[kKeyCurrentPage] ?? 1,
      totalItems: map[kKeyTotalItems] ?? (map['courses'] as List).length,
      totalPages: map[kKeyTotalPages] ?? 1,
      data: map[kKeyData] ?? map['courses'] ?? [],
    );
  }

  static const String kKeyCurrentPage = 'currentPage';
  static const String kKeyTotalItems = 'totalItems';
  static const String kKeyTotalPages = 'totalPages';
  static const String kKeyData = 'data';
}