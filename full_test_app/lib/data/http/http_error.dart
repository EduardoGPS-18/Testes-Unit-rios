import '../../domain/errors/errors.dart';

abstract class HttpError implements Exception {
  final int? statusCode;
  final String? message;

  HttpError({this.message, this.statusCode});

  DomainError toDomainError();
}

class BadRequestError extends HttpError {
  BadRequestError({required super.message}) : super(statusCode: 400);
  @override
  DomainError toDomainError() => InvalidDataError(message: message);
}

class UnauthorizedError extends HttpError {
  UnauthorizedError({required super.message}) : super(statusCode: 401);
  @override
  DomainError toDomainError() => AccessDeniedError(message: message);
}

class ForbiddenError extends HttpError {
  ForbiddenError({required super.message}) : super(statusCode: 403);
  @override
  DomainError toDomainError() => AccessDeniedError(message: message);
}

class NotFoundError extends HttpError {
  NotFoundError({required super.message}) : super(statusCode: 404);
  @override
  DomainError toDomainError() => NoDataError(message: message);
}

class ServerError extends HttpError {
  ServerError({required super.message}) : super(statusCode: 500);

  @override
  DomainError toDomainError() => UnexpectedError(message: message);
}

class MissmatchReceivedType extends HttpError {
  MissmatchReceivedType({super.message});

  @override
  DomainError toDomainError() => UnexpectedError();
}
