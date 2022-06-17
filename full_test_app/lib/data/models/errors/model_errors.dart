import '../../../domain/errors/errors.dart';

abstract class ModelError {
  DomainError toDomainError();
}

class UnMatchObjectError extends ModelError {
  @override
  DomainError toDomainError() => UnexpectedError();
}

class InvalidConversionError extends ModelError {
  @override
  DomainError toDomainError() => UnexpectedError();
}
