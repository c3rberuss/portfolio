// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ImageResponse> _$imageResponseSerializer =
    new _$ImageResponseSerializer();

class _$ImageResponseSerializer implements StructuredSerializer<ImageResponse> {
  @override
  final Iterable<Type> types = const [ImageResponse, _$ImageResponse];
  @override
  final String wireName = 'ImageResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, ImageResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'statusCode',
      serializers.serialize(object.statusCode,
          specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ImageModel)),
    ];

    return result;
  }

  @override
  ImageResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImageResponseBuilder();

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
              specifiedType: const FullType(ImageModel)) as ImageModel);
          break;
      }
    }

    return result.build();
  }
}

class _$ImageResponse extends ImageResponse {
  @override
  final int statusCode;
  @override
  final ImageModel data;

  factory _$ImageResponse([void Function(ImageResponseBuilder) updates]) =>
      (new ImageResponseBuilder()..update(updates)).build();

  _$ImageResponse._({this.statusCode, this.data}) : super._() {
    if (statusCode == null) {
      throw new BuiltValueNullFieldError('ImageResponse', 'statusCode');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('ImageResponse', 'data');
    }
  }

  @override
  ImageResponse rebuild(void Function(ImageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageResponseBuilder toBuilder() => new ImageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageResponse &&
        statusCode == other.statusCode &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, statusCode.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ImageResponse')
          ..add('statusCode', statusCode)
          ..add('data', data))
        .toString();
  }
}

class ImageResponseBuilder
    implements Builder<ImageResponse, ImageResponseBuilder> {
  _$ImageResponse _$v;

  int _statusCode;
  int get statusCode => _$this._statusCode;
  set statusCode(int statusCode) => _$this._statusCode = statusCode;

  ImageModelBuilder _data;
  ImageModelBuilder get data => _$this._data ??= new ImageModelBuilder();
  set data(ImageModelBuilder data) => _$this._data = data;

  ImageResponseBuilder();

  ImageResponseBuilder get _$this {
    if (_$v != null) {
      _statusCode = _$v.statusCode;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ImageResponse;
  }

  @override
  void update(void Function(ImageResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ImageResponse build() {
    _$ImageResponse _$result;
    try {
      _$result = _$v ??
          new _$ImageResponse._(statusCode: statusCode, data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ImageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
