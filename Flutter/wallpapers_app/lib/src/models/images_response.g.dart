// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ImagesResponse> _$imagesResponseSerializer =
    new _$ImagesResponseSerializer();

class _$ImagesResponseSerializer
    implements StructuredSerializer<ImagesResponse> {
  @override
  final Iterable<Type> types = const [ImagesResponse, _$ImagesResponse];
  @override
  final String wireName = 'ImagesResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, ImagesResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'statusCode',
      serializers.serialize(object.statusCode,
          specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ImageModel)])),
    ];
    if (object.current != null) {
      result
        ..add('current')
        ..add(serializers.serialize(object.current,
            specifiedType: const FullType(int)));
    }
    if (object.pages != null) {
      result
        ..add('pages')
        ..add(serializers.serialize(object.pages,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ImagesResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImagesResponseBuilder();

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
        case 'current':
          result.current = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pages':
          result.pages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ImageModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ImagesResponse extends ImagesResponse {
  @override
  final int statusCode;
  @override
  final int current;
  @override
  final int pages;
  @override
  final BuiltList<ImageModel> data;

  factory _$ImagesResponse([void Function(ImagesResponseBuilder) updates]) =>
      (new ImagesResponseBuilder()..update(updates)).build();

  _$ImagesResponse._({this.statusCode, this.current, this.pages, this.data})
      : super._() {
    if (statusCode == null) {
      throw new BuiltValueNullFieldError('ImagesResponse', 'statusCode');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('ImagesResponse', 'data');
    }
  }

  @override
  ImagesResponse rebuild(void Function(ImagesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImagesResponseBuilder toBuilder() =>
      new ImagesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImagesResponse &&
        statusCode == other.statusCode &&
        current == other.current &&
        pages == other.pages &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, statusCode.hashCode), current.hashCode), pages.hashCode),
        data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ImagesResponse')
          ..add('statusCode', statusCode)
          ..add('current', current)
          ..add('pages', pages)
          ..add('data', data))
        .toString();
  }
}

class ImagesResponseBuilder
    implements Builder<ImagesResponse, ImagesResponseBuilder> {
  _$ImagesResponse _$v;

  int _statusCode;
  int get statusCode => _$this._statusCode;
  set statusCode(int statusCode) => _$this._statusCode = statusCode;

  int _current;
  int get current => _$this._current;
  set current(int current) => _$this._current = current;

  int _pages;
  int get pages => _$this._pages;
  set pages(int pages) => _$this._pages = pages;

  ListBuilder<ImageModel> _data;
  ListBuilder<ImageModel> get data =>
      _$this._data ??= new ListBuilder<ImageModel>();
  set data(ListBuilder<ImageModel> data) => _$this._data = data;

  ImagesResponseBuilder();

  ImagesResponseBuilder get _$this {
    if (_$v != null) {
      _statusCode = _$v.statusCode;
      _current = _$v.current;
      _pages = _$v.pages;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImagesResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ImagesResponse;
  }

  @override
  void update(void Function(ImagesResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ImagesResponse build() {
    _$ImagesResponse _$result;
    try {
      _$result = _$v ??
          new _$ImagesResponse._(
              statusCode: statusCode,
              current: current,
              pages: pages,
              data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ImagesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
