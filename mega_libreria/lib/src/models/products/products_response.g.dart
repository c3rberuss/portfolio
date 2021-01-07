// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductsResponse> _$productsResponseSerializer =
    new _$ProductsResponseSerializer();

class _$ProductsResponseSerializer
    implements StructuredSerializer<ProductsResponse> {
  @override
  final Iterable<Type> types = const [ProductsResponse, _$ProductsResponse];
  @override
  final String wireName = 'ProductsResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, ProductsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.body != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.body,
            specifiedType: const FullType(ProductsPagination)));
    }
    return result;
  }

  @override
  ProductsResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductsResponseBuilder();

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
          result.body.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ProductsPagination))
              as ProductsPagination);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductsResponse extends ProductsResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final ProductsPagination body;

  factory _$ProductsResponse(
          [void Function(ProductsResponseBuilder) updates]) =>
      (new ProductsResponseBuilder()..update(updates)).build();

  _$ProductsResponse._({this.code, this.message, this.body}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('ProductsResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('ProductsResponse', 'message');
    }
  }

  @override
  ProductsResponse rebuild(void Function(ProductsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductsResponseBuilder toBuilder() =>
      new ProductsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductsResponse &&
        code == other.code &&
        message == other.message &&
        body == other.body;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, code.hashCode), message.hashCode), body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductsResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('body', body))
        .toString();
  }
}

class ProductsResponseBuilder
    implements Builder<ProductsResponse, ProductsResponseBuilder> {
  _$ProductsResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ProductsPaginationBuilder _body;
  ProductsPaginationBuilder get body =>
      _$this._body ??= new ProductsPaginationBuilder();
  set body(ProductsPaginationBuilder body) => _$this._body = body;

  ProductsResponseBuilder();

  ProductsResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _body = _$v.body?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductsResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductsResponse;
  }

  @override
  void update(void Function(ProductsResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductsResponse build() {
    _$ProductsResponse _$result;
    try {
      _$result = _$v ??
          new _$ProductsResponse._(
              code: code, message: message, body: _body?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'body';
        _body?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProductsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
