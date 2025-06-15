// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiHttpResponse<T> {
  int? statusCode;
  T? responseData;
  String? message;
  Status? status;
  bool? isLoading;
  ApiHttpResponse({
    this.statusCode,
    this.responseData,
    this.message,
    this.status,
    this.isLoading = false,
  });

  ApiHttpResponse.completed(this.responseData)
      : status = Status.completed,
        isLoading = false;

  ApiHttpResponse.error(this.message)
      : status = Status.error,
        isLoading = false;

  ApiHttpResponse.init()
      : status = null,
        message = null,
        responseData = null,
        isLoading = false;
}

enum Status { idle, loading, completed, error }
