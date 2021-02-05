// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApplicationsResponse> _$applicationsResponseSerializer =
    new _$ApplicationsResponseSerializer();

class _$ApplicationsResponseSerializer
    implements StructuredSerializer<ApplicationsResponse> {
  @override
  final Iterable<Type> types = const [
    ApplicationsResponse,
    _$ApplicationsResponse
  ];
  @override
  final String wireName = 'ApplicationsResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ApplicationsResponse object,
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
                BuiltList, const [const FullType(ApplicationModel)])));
    }
    return result;
  }

  @override
  ApplicationsResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApplicationsResponseBuilder();

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
                      BuiltList, const [const FullType(ApplicationModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ApplicationsResponse extends ApplicationsResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BuiltList<ApplicationModel> data;

  factory _$ApplicationsResponse(
          [void Function(ApplicationsResponseBuilder) updates]) =>
      (new ApplicationsResponseBuilder()..update(updates)).build();

  _$ApplicationsResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('ApplicationsResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('ApplicationsResponse', 'message');
    }
  }

  @override
  ApplicationsResponse rebuild(
          void Function(ApplicationsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationsResponseBuilder toBuilder() =>
      new ApplicationsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationsResponse &&
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
    return (newBuiltValueToStringHelper('ApplicationsResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ApplicationsResponseBuilder
    implements Builder<ApplicationsResponse, ApplicationsResponseBuilder> {
  _$ApplicationsResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ListBuilder<ApplicationModel> _data;
  ListBuilder<ApplicationModel> get data =>
      _$this._data ??= new ListBuilder<ApplicationModel>();
  set data(ListBuilder<ApplicationModel> data) => _$this._data = data;

  ApplicationsResponseBuilder();

  ApplicationsResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationsResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ApplicationsResponse;
  }

  @override
  void update(void Function(ApplicationsResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApplicationsResponse build() {
    _$ApplicationsResponse _$result;
    try {
      _$result = _$v ??
          new _$ApplicationsResponse._(
              code: code, message: message, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ApplicationsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
