// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddressResponse> _$addressResponseSerializer =
    new _$AddressResponseSerializer();

class _$AddressResponseSerializer
    implements StructuredSerializer<AddressResponse> {
  @override
  final Iterable<Type> types = const [AddressResponse, _$AddressResponse];
  @override
  final String wireName = 'AddressResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, AddressResponse object,
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
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  AddressResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddressResponseBuilder();

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
          result.data = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$AddressResponse extends AddressResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final int data;

  factory _$AddressResponse([void Function(AddressResponseBuilder) updates]) =>
      (new AddressResponseBuilder()..update(updates)).build();

  _$AddressResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('AddressResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('AddressResponse', 'message');
    }
  }

  @override
  AddressResponse rebuild(void Function(AddressResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddressResponseBuilder toBuilder() =>
      new AddressResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddressResponse &&
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
    return (newBuiltValueToStringHelper('AddressResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class AddressResponseBuilder
    implements Builder<AddressResponse, AddressResponseBuilder> {
  _$AddressResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  int _data;
  int get data => _$this._data;
  set data(int data) => _$this._data = data;

  AddressResponseBuilder();

  AddressResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddressResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AddressResponse;
  }

  @override
  void update(void Function(AddressResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AddressResponse build() {
    final _$result = _$v ??
        new _$AddressResponse._(code: code, message: message, data: data);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
