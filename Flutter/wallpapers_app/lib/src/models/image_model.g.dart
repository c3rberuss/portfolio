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
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
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
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ImageModel extends ImageModel {
  @override
  final String url;
  @override
  final String category;
  @override
  final String name;

  factory _$ImageModel([void Function(ImageModelBuilder) updates]) =>
      (new ImageModelBuilder()..update(updates)).build();

  _$ImageModel._({this.url, this.category, this.name}) : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('ImageModel', 'url');
    }
    if (category == null) {
      throw new BuiltValueNullFieldError('ImageModel', 'category');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ImageModel', 'name');
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
    return other is ImageModel &&
        url == other.url &&
        category == other.category &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, url.hashCode), category.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ImageModel')
          ..add('url', url)
          ..add('category', category)
          ..add('name', name))
        .toString();
  }
}

class ImageModelBuilder implements Builder<ImageModel, ImageModelBuilder> {
  _$ImageModel _$v;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ImageModelBuilder();

  ImageModelBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _category = _$v.category;
      _name = _$v.name;
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
    final _$result =
        _$v ?? new _$ImageModel._(url: url, category: category, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
