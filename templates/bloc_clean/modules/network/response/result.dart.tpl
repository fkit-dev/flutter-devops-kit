class Result<T> {
  const Result({
    this.data,
    this.message,
  });

  final T? data;
  final String? message;
}