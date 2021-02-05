// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ServicesResponse> _$servicesResponseSerializer =
    new _$ServicesResponseSerializer();

class _$ServicesResponseSerializer
    implements StructuredSerializer<ServicesResponse> {
  @override
  final Iterable<Type> types = const [ServicesResponse, _$ServicesResponse];
  @override
  final String wireName = 'ServicesResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, ServicesResponse object,
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
                BuiltList, const [const FullType(ServiceModel)])));
    }
    return result;
  }

  @override
  ServicesResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ServicesResponseBuilder();

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
                      BuiltList, const [const FullType(ServiceModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ServicesResponse extends ServicesResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BuiltList<ServiceModel> data;

  factory _$ServicesResponse(
          [void Function(ServicesResponseBuilder) updates]) =>
      (new ServicesResponseBuilder()..update(updates)).build();

  _$ServicesResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('ServicesResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('ServicesResponse', 'message');
    }
  }

  @override
  ServicesResponse rebuild(void Function(ServicesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ServicesResponseBuilder toBuilder() =>
      new ServicesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServicesResponse &&
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
    return (newBuiltValueToStringHelper('ServicesResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ServicesResponseBuilder
    implements Builder<ServicesResponse, ServicesResponseBuilder> {
  _$ServicesResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ListBuilder<ServiceModel> _data;
  ListBuilder<ServiceModel> get data =>
      _$this._data ??= new ListBuilder<ServiceModel>();
  set data(ListBuilder<ServiceModel> data) => _$this._data = data;

  ServicesResponseBuilder();

  ServicesResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServicesResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ServicesResponse;
  }

  @override
  void update(void Function(ServicesResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ServicesResponse build() {
    _$ServicesResponse _$result;
    try {
      _$result = _$v ??
          new _$ServicesResponse._(
              code: code, message: message, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ServicesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
