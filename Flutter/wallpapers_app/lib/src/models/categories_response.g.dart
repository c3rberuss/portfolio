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
      'statusCode',
      serializers.serialize(object.statusCode,
          specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CategoryModel)])),
    ];

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
        case 'statusCode':
          result.statusCode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
  final int statusCode;
  @override
  final BuiltList<CategoryModel> data;

  factory _$CategoriesResponse(
          [void Function(CategoriesResponseBuilder) updates]) =>
      (new CategoriesResponseBuilder()..update(updates)).build();

  _$CategoriesResponse._({this.statusCode, this.data}) : super._() {
    if (statusCode == null) {
      throw new BuiltValueNullFieldError('CategoriesResponse', 'statusCode');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('CategoriesResponse', 'data');
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
        statusCode == other.statusCode &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, statusCode.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CategoriesResponse')
          ..add('statusCode', statusCode)
          ..add('data', data))
        .toString();
  }
}

class CategoriesResponseBuilder
    implements Builder<CategoriesResponse, CategoriesResponseBuilder> {
  _$CategoriesResponse _$v;

  int _statusCode;
  int get statusCode => _$this._statusCode;
  set statusCode(int statusCode) => _$this._statusCode = statusCode;

  ListBuilder<CategoryModel> _data;
  ListBuilder<CategoryModel> get data =>
      _$this._data ??= new ListBuilder<CategoryModel>();
  set data(ListBuilder<CategoryModel> data) => _$this._data = data;

  CategoriesResponseBuilder();

  CategoriesResponseBuilder get _$this {
    if (_$v != null) {
      _statusCode = _$v.statusCode;
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
              statusCode: statusCode, data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
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
