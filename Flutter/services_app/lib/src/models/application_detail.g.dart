// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApplicationDetail> _$applicationDetailSerializer =
    new _$ApplicationDetailSerializer();

class _$ApplicationDetailSerializer
    implements StructuredSerializer<ApplicationDetail> {
  @override
  final Iterable<Type> types = const [ApplicationDetail, _$ApplicationDetail];
  @override
  final String wireName = 'ApplicationDetail';

  @override
  Iterable<Object> serialize(Serializers serializers, ApplicationDetail object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'workforce',
      serializers.serialize(object.workforce,
          specifiedType: const FullType(double)),
    ];
    if (object.serviceId != null) {
      result
        ..add('id_service')
        ..add(serializers.serialize(object.serviceId,
            specifiedType: const FullType(int)));
    }
    if (object.selected != null) {
      result
        ..add('selected')
        ..add(serializers.serialize(object.selected,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ApplicationDetail deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApplicationDetailBuilder();

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
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'workforce':
          result.workforce = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'selected':
          result.selected = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ApplicationDetail extends ApplicationDetail {
  @override
  final int serviceId;
  @override
  final String title;
  @override
  final String description;
  @override
  final double price;
  @override
  final double workforce;
  @override
  final bool selected;

  factory _$ApplicationDetail(
          [void Function(ApplicationDetailBuilder) updates]) =>
      (new ApplicationDetailBuilder()..update(updates)).build();

  _$ApplicationDetail._(
      {this.serviceId,
      this.title,
      this.description,
      this.price,
      this.workforce,
      this.selected})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('ApplicationDetail', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ApplicationDetail', 'description');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('ApplicationDetail', 'price');
    }
    if (workforce == null) {
      throw new BuiltValueNullFieldError('ApplicationDetail', 'workforce');
    }
  }

  @override
  ApplicationDetail rebuild(void Function(ApplicationDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationDetailBuilder toBuilder() =>
      new ApplicationDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationDetail &&
        serviceId == other.serviceId &&
        title == other.title &&
        description == other.description &&
        price == other.price &&
        workforce == other.workforce;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, serviceId.hashCode), title.hashCode),
                description.hashCode),
            price.hashCode),
        workforce.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ApplicationDetail')
          ..add('serviceId', serviceId)
          ..add('title', title)
          ..add('description', description)
          ..add('price', price)
          ..add('workforce', workforce)
          ..add('selected', selected))
        .toString();
  }
}

class ApplicationDetailBuilder
    implements Builder<ApplicationDetail, ApplicationDetailBuilder> {
  _$ApplicationDetail _$v;

  int _serviceId;
  int get serviceId => _$this._serviceId;
  set serviceId(int serviceId) => _$this._serviceId = serviceId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  double _workforce;
  double get workforce => _$this._workforce;
  set workforce(double workforce) => _$this._workforce = workforce;

  bool _selected;
  bool get selected => _$this._selected;
  set selected(bool selected) => _$this._selected = selected;

  ApplicationDetailBuilder();

  ApplicationDetailBuilder get _$this {
    if (_$v != null) {
      _serviceId = _$v.serviceId;
      _title = _$v.title;
      _description = _$v.description;
      _price = _$v.price;
      _workforce = _$v.workforce;
      _selected = _$v.selected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ApplicationDetail;
  }

  @override
  void update(void Function(ApplicationDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApplicationDetail build() {
    final _$result = _$v ??
        new _$ApplicationDetail._(
            serviceId: serviceId,
            title: title,
            description: description,
            price: price,
            workforce: workforce,
            selected: selected);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
