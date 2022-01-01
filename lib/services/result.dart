class Result<T> {
  Result._();

  factory Result.idle() = IdleState<T>;

  factory Result.loading() = LoadingState<T>;

  factory Result.success(T value) = SuccessState<T>;

  factory Result.error(T msg) = ErrorState<T>;
}

class IdleState<T> extends Result<T> {
  IdleState() : super._();
}

class LoadingState<T> extends Result<T> {
  LoadingState() : super._();
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value) : super._();
  final T value;
}
