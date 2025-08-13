// Generic API Response wrapper (same as before)
class ApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? errorMessage;

  ApiResponse._({required this.isSuccess, this.data, this.errorMessage});

  factory ApiResponse.success(T data) {
    return ApiResponse._(isSuccess: true, data: data);
  }

  factory ApiResponse.error(String message) {
    return ApiResponse._(isSuccess: false, errorMessage: message);
  }
}
