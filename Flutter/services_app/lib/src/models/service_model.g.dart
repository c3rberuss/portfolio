// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ServiceModel> _$serviceModelSerializer =
    new _$ServiceModelSerializer();

class _$ServiceModelSerializer implements StructuredSerializer<ServiceModel> {
  @override
  final Iterable<Type> types = const [ServiceModel, _$ServiceModel];
  @override
  final String wireName = 'ServiceModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ServiceModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id_service',
      serializers.serialize(object.serviceId,
          specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'workforce',
      serializers.serialize(object.workforce,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  ServiceModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ServiceModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id_service':
          result.serviceId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'workforce':
          result.workforce = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$ServiceModel extends ServiceModel {
  @override
  final int serviceId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String image;
  @override
  final double price;
  @override
  final double workforce;

  factory _$ServiceModel([void Function(ServiceModelBuilder) updates]) =>
      (new ServiceModelBuilder()..update(updates)).build();

  _$ServiceModel._(
      {this.serviceId,
      this.title,
      this.description,
      this.image,
      this.price,
      this.workforce})
      : super._() {
    if (serviceId == null) {
      throw new BuiltValueNullFieldError('ServiceModel', 'serviceId');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ServiceModel', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ServiceModel', 'description');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('ServiceModel', 'image');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('ServiceModel', 'price');
    }
    if (workforce == null) {
      throw new BuiltValueNullFieldError('ServiceModel', 'workforce');
    }
  }

  @override
  ServiceModel rebuild(void Function(ServiceModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ServiceModelBuilder toBuilder() => new ServiceModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceModel &&
        serviceId == other.serviceId &&
        title == other.title &&
        description == other.description &&
        image == other.image &&
        price == other.price &&
        workforce == other.workforce;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, serviceId.hashCode), title.hashCode),
                    description.hashCode),
                image.hashCode),
            price.hashCode),
        workforce.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ServiceModel')
          ..add('serviceId', serviceId)
          ..add('title', title)
          ..add('description', description)
          ..add('image', image)
          ..add('price', price)
          ..add('workforce', workforce))
        .toString();
  }
}

class ServiceModelBuilder
    implements Builder<ServiceModel, ServiceModelBuilder> {
  _$ServiceModel _$v;

  int _serviceId;
  int get serviceId => _$this._serviceId;
  set serviceId(int serviceId) => _$this._serviceId = serviceId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  double _workforce;
  double get workforce => _$this._workforce;
  set workforce(double workforce) => _$this._workforce = workforce;

  ServiceModelBuilder();

  ServiceModelBuilder get _$this {
    if (_$v != null) {
      _serviceId = _$v.serviceId;
      _title = _$v.title;
      _description = _$v.description;
      _image = _$v.image;
      _price = _$v.price;
      _workforce = _$v.workforce;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServiceModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ServiceModel;
  }

  @override
  void update(void Function(ServiceModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ServiceModel build() {
    final _$result = _$v ??
        new _$ServiceModel._(
            serviceId: serviceId,
            title: title,
            description: description,
            image: image,
            price: price,
            workforce: workforce);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
