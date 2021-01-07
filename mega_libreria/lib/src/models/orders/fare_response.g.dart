// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FareResponse> _$fareResponseSerializer =
    new _$FareResponseSerializer();

class _$FareResponseSerializer implements StructuredSerializer<FareResponse> {
  @override
  final Iterable<Type> types = const [FareResponse, _$FareResponse];
  @override
  final String wireName = 'FareResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, FareResponse object,
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
            specifiedType: const FullType(FareModel)));
    }
    return result;
  }

  @override
  FareResponse deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FareResponseBuilder();

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
              specifiedType: const FullType(FareModel)) as FareModel);
          break;
      }
    }

    return result.build();
  }
}

class _$FareResponse extends FareResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final FareModel data;

  factory _$FareResponse([void Function(FareResponseBuilder) updates]) =>
      (new FareResponseBuilder()..update(updates)).build();

  _$FareResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('FareResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('FareResponse', 'message');
    }
  }

  @override
  FareResponse rebuild(void Function(FareResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FareResponseBuilder toBuilder() => new FareResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FareResponse &&
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
    return (newBuiltValueToStringHelper('FareResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class FareResponseBuilder
    implements Builder<FareResponse, FareResponseBuilder> {
  _$FareResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  FareModelBuilder _data;
  FareModelBuilder get data => _$this._data ??= new FareModelBuilder();
  set data(FareModelBuilder data) => _$this._data = data;

  FareResponseBuilder();

  FareResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FareResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FareResponse;
  }

  @override
  void update(void Function(FareResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FareResponse build() {
    _$FareResponse _$result;
    try {
      _$result = _$v ??
          new _$FareResponse._(
              code: code, message: message, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FareResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
