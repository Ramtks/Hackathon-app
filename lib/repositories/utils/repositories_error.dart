///Error class for the repostries methods
class RepositoriesError {
  ///provide exception & stacktrace
  RepositoriesError({required this.exception, required this.stackTrace});

  ///Exception to check error type
  final Exception exception;

  ///Info about the sequence that triggered an exception
  final StackTrace stackTrace;
}
