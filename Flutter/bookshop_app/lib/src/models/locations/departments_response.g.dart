// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DepartmentsResponse> _$departmentsResponseSerializer =
    new _$DepartmentsResponseSerializer();

class _$DepartmentsResponseSerializer
    implements StructuredSerializer<DepartmentsResponse> {
  @override
  final Iterable<Type> types = const [
    DepartmentsResponse,
    _$DepartmentsResponse
  ];
  @override
  final String wireName = 'DepartmentsResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, DepartmentsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DepartmentModel)])));
    }
    return result;
  }

  @override
  DepartmentsResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DepartmentsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DepartmentModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DepartmentsResponse extends DepartmentsResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BuiltList<DepartmentModel> data;

  factory _$DepartmentsResponse(
          [void Function(DepartmentsResponseBuilder) updates]) =>
      (new DepartmentsResponseBuilder()..update(updates)).build();

  _$DepartmentsResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('DepartmentsResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('DepartmentsResponse', 'message');
    }
  }

  @override
  DepartmentsResponse rebuild(
          void Function(DepartmentsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepartmentsResponseBuilder toBuilder() =>
      new DepartmentsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepartmentsResponse &&
        code == other.code &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, code.hashCode), message.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DepartmentsResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DepartmentsResponseBuilder
    implements Builder<DepartmentsResponse, DepartmentsResponseBuilder> {
  _$DepartmentsResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ListBuilder<DepartmentModel> _data;
  ListBuilder<DepartmentModel> get data =>
      _$this._data ??= new ListBuilder<DepartmentModel>();
  set data(ListBuilder<DepartmentModel> data) => _$this._data = data;

  DepartmentsResponseBuilder();

  DepartmentsResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepartmentsResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DepartmentsResponse;
  }

  @override
  void update(void Function(DepartmentsResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DepartmentsResponse build() {
    _$DepartmentsResponse _$result;
    try {
      _$result = _$v ??
          new _$DepartmentsResponse._(
              code: code, message: message, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DepartmentsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
