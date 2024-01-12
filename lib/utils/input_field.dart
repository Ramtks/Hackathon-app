enum FieldStatus {
  initial,
  valid,
  invalid,
}

class InputField<T> {
  InputField({required this.validate}) : _status = FieldStatus.initial;

  T? _value;
  String? _errorText;
  FieldStatus _status;
  ({bool isValid, String? message}) Function(T value) validate;

  T? get getValue {
    return this._value;
  }

  String? get getErrorMessage {
    return this._errorText;
  }

  bool get getIsValid {
    return _status != FieldStatus.invalid;
  }

  FieldStatus get getState {
    return this._status;
  }

  void setValueWithValidation(T value) {
    this._value = value;
    ({bool isValid, String? message}) validation = validate(value);
    validation.isValid == true ? valid() : invalidate(validation.message ?? '');
  }

  void invalidate(String errorMessage) {
    this._status = FieldStatus.invalid;
    this._errorText = errorMessage;
  }

  void valid() {
    this._status = FieldStatus.valid;
  }

  void changeStatusToInitial() {
    this._status = FieldStatus.initial;
  }
}
