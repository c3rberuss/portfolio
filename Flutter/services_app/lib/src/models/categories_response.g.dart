// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CategoriesResponse> _$categoriesResponseSerializer =
    new _$CategoriesResponseSerializer();

class _$CategoriesResponseSerializer
    implements StructuredSerializer<CategoriesResponse> {
  @override
  final Iterable<Type> types = const [CategoriesResponse, _$CategoriesResponse];
  @override
  final String wireName = 'CategoriesResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, CategoriesResponse object,
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
                BuiltList, const [const FullType(CategoryModel)])));
    }
    return result;
  }

  @override
  CategoriesResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CategoriesResponseBuilder();

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
                      BuiltList, const [const FullType(CategoryModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CategoriesResponse extends CategoriesResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BuiltList<CategoryModel> data;

  factory _$CategoriesResponse(
          [void Function(CategoriesResponseBuilder) updates]) =>
      (new CategoriesResponseBuilder()..update(updates)).build();

  _$CategoriesResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('CategoriesResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('CategoriesResponse', 'message');
    }
  }

  @override
  CategoriesResponse rebuild(
          void Function(CategoriesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoriesResponseBuilder toBuilder() =>
      new CategoriesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoriesResponse &&
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
    return (newBuiltValueToStringHelper('CategoriesResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CategoriesResponseBuilder
    implements Builder<CategoriesResponse, CategoriesResponseBuilder> {
  _$CategoriesResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ListBuilder<CategoryModel> _data;
  ListBuilder<CategoryModel> get data =>
      _$this._data ??= new ListBuilder<CategoryModel>();
  set data(ListBuilder<CategoryModel> data) => _$this._data = data;

  CategoriesResponseBuilder();

  CategoriesResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoriesResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CategoriesResponse;
  }

  @override
  void update(void Function(CategoriesResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CategoriesResponse build() {
    _$CategoriesResponse _$result;
    try {
      _$result = _$v ??
          new _$CategoriesResponse._(
              code: code, message: message, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CategoriesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
