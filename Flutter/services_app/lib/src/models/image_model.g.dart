// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ImageModel> _$imageModelSerializer = new _$ImageModelSerializer();

class _$ImageModelSerializer implements StructuredSerializer<ImageModel> {
  @override
  final Iterable<Type> types = const [ImageModel, _$ImageModel];
  @override
  final String wireName = 'ImageModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ImageModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'path',
      serializers.serialize(object.path, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ImageModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImageModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'path':
          result.path = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ImageModel extends ImageModel {
  @override
  final String path;

  factory _$ImageModel([void Function(ImageModelBuilder) updates]) =>
      (new ImageModelBuilder()..update(updates)).build();

  _$ImageModel._({this.path}) : super._() {
    if (path == null) {
      throw new BuiltValueNullFieldError('ImageModel', 'path');
    }
  }

  @override
  ImageModel rebuild(void Function(ImageModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageModelBuilder toBuilder() => new ImageModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageModel && path == other.path;
  }

  @override
  int get hashCode {
    return $jf($jc(0, path.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ImageModel')..add('path', path))
        .toString();
  }
}

class ImageModelBuilder implements Builder<ImageModel, ImageModelBuilder> {
  _$ImageModel _$v;

  String _path;
  String get path => _$this._path;
  set path(String path) => _$this._path = path;

  ImageModelBuilder();

  ImageModelBuilder get _$this {
    if (_$v != null) {
      _path = _$v.path;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ImageModel;
  }

  @override
  void update(void Function(ImageModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ImageModel build() {
    final _$result = _$v ?? new _$ImageModel._(path: path);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
