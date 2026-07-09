import 'pagination.dart';

class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    this.pagination,
    this.message,
  });

  final List<T> items;
  final Pagination? pagination;
  final String? message;
}