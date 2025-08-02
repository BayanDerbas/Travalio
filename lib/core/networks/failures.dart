import 'dart:developer';
import 'package:dio/dio.dart';

abstract class Failures {
  final String err_message;

  Failures(this.err_message);
}

class serverFailure extends Failures {
  final int? statusCode;
  final dynamic exception;

  serverFailure(String message, {this.statusCode, this.exception})
      : super(message) {
    log('..........');
    log('Error: $message${statusCode != null ? ' (Status Code: $statusCode)' : ''}');
  }

  factory serverFailure.fromDioError(DioException dioException) {
    log('..........');
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return serverFailure("Connection Timeout with API Server");
      case DioExceptionType.sendTimeout:
        return serverFailure("Send Timeout with API Server");
      case DioExceptionType.receiveTimeout:
        return serverFailure("Receive Timeout with API Server");
      case DioExceptionType.badCertificate:
        return serverFailure("Bad Certificate Exception");
      case DioExceptionType.cancel:
        return serverFailure("Operation Cancelled");
      case DioExceptionType.connectionError:
        return serverFailure("Error in the connection");
      case DioExceptionType.unknown:
        if (dioException.message?.contains("SocketException") ?? false) {
          return serverFailure("No Internet Connection");
        }
        return serverFailure(
          dioException.message ?? 'Unknown Error',
          exception: dioException.error,
        );
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        final data = dioException.response?.data;
        log("Status code: $statusCode");
        return serverFailure.fromResponse(
          statusCode ?? 0,
          data,
          exception: dioException,
        );
      default:
        return serverFailure("Unknown error", exception: dioException);
    }
  }

  factory serverFailure.fromResponse(
      int statusCode,
      dynamic response, {
        dynamic exception,
      }) {
    log('..........');
    String message;

    if (statusCode == 400) {
      message = "Bad request. Please check your input.";
    } else if (statusCode == 401) {
      message = "Unauthorized. Please log in again.";
    } else if (statusCode == 403) {
      message = "Forbidden. You don't have permission.";
    } else if (statusCode == 404) {
      message = "Resource not found.";
    } else if (statusCode == 500) {
      message = "Internal server error. Please try again later.$response";
    } else {
      message = "Unexpected error (code $statusCode)";
    }

    return serverFailure(message, statusCode: statusCode, exception: exception);
  }
}