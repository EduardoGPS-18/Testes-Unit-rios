class DomainError {
  final String? message;

  DomainError({this.message});
}

class InvalidDataError extends DomainError {
  InvalidDataError({super.message});
}

class UnexpectedError extends DomainError {
  UnexpectedError({super.message});
}

class AccessDeniedError extends DomainError {
  AccessDeniedError({super.message});
}

class NoDataError extends DomainError {
  NoDataError({super.message});
}
