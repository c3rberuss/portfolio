// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApplicationModel> _$applicationModelSerializer =
    new _$ApplicationModelSerializer();

class _$ApplicationModelSerializer
    implements StructuredSerializer<ApplicationModel> {
  @override
  final Iterable<Type> types = const [ApplicationModel, _$ApplicationModel];
  @override
  final String wireName = 'ApplicationModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ApplicationModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'latitude',
      serializers.serialize(object.latitude,
          specifiedType: const FullType(double)),
      'longitude',
      serializers.serialize(object.longitude,
          specifiedType: const FullType(double)),
      'total',
      serializers.serialize(object.total,
          specifiedType: const FullType(double)),
    ];
    if (object.applicationId != null) {
      result
        ..add('id_application')
        ..add(serializers.serialize(object.applicationId,
            specifiedType: const FullType(int)));
    }
    if (object.images != null) {
      result
        ..add('attachments')
        ..add(serializers.serialize(object.images,
            specifiedType:
                const FullType(BuiltList, const [const FullType(ImageModel)])));
    }
    if (object.services != null) {
      result
        ..add('detail')
        ..add(serializers.serialize(object.services,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ApplicationDetail)])));
    }
    if (object.status != null) {
      result
        ..add('state')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(ApplicationStatusModel)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.moneyPaid != null) {
      result
        ..add('money_paid')
        ..add(serializers.serialize(object.moneyPaid,
            specifiedType: const FullType(double)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ApplicationModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApplicationModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id_application':
          result.applicationId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'attachments':
          result.images.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ImageModel)]))
              as BuiltList<Object>);
          break;
        case 'detail':
          result.services.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ApplicationDetail)]))
              as BuiltList<Object>);
          break;
        case 'state':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(ApplicationStatusModel))
              as ApplicationStatusModel;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'money_paid':
          result.moneyPaid = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ApplicationModel extends ApplicationModel {
  @override
  final int applicationId;
  @override
  final BuiltList<ImageModel> images;
  @override
  final BuiltList<ApplicationDetail> services;
  @override
  final ApplicationStatusModel status;
  @override
  final String description;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double total;
  @override
  final double moneyPaid;
  @override
  final String createdAt;

  factory _$ApplicationModel(
          [void Function(ApplicationModelBuilder) updates]) =>
      (new ApplicationModelBuilder()..update(updates)).build();

  _$ApplicationModel._(
      {this.applicationId,
      this.images,
      this.services,
      this.status,
      this.description,
      this.latitude,
      this.longitude,
      this.total,
      this.moneyPaid,
      this.createdAt})
      : super._() {
    if (latitude == null) {
      throw new BuiltValueNullFieldError('ApplicationModel', 'latitude');
    }
    if (longitude == null) {
      throw new BuiltValueNullFieldError('ApplicationModel', 'longitude');
    }
    if (total == null) {
      throw new BuiltValueNullFieldError('ApplicationModel', 'total');
    }
  }

  @override
  ApplicationModel rebuild(void Function(ApplicationModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationModelBuilder toBuilder() =>
      new ApplicationModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationModel &&
        applicationId == other.applicationId &&
        images == other.images &&
        services == other.services &&
        status == other.status &&
        description == other.description &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        total == other.total &&
        moneyPaid == other.moneyPaid &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, applicationId.hashCode),
                                        images.hashCode),
                                    services.hashCode),
                                status.hashCode),
                            description.hashCode),
                        latitude.hashCode),
                    longitude.hashCode),
                total.hashCode),
            moneyPaid.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ApplicationModel')
          ..add('applicationId', applicationId)
          ..add('images', images)
          ..add('services', services)
          ..add('status', status)
          ..add('description', description)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('total', total)
          ..add('moneyPaid', moneyPaid)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ApplicationModelBuilder
    implements Builder<ApplicationModel, ApplicationModelBuilder> {
  _$ApplicationModel _$v;

  int _applicationId;
  int get applicationId => _$this._applicationId;
  set applicationId(int applicationId) => _$this._applicationId = applicationId;

  ListBuilder<ImageModel> _images;
  ListBuilder<ImageModel> get images =>
      _$this._images ??= new ListBuilder<ImageModel>();
  set images(ListBuilder<ImageModel> images) => _$this._images = images;

  ListBuilder<ApplicationDetail> _services;
  ListBuilder<ApplicationDetail> get services =>
      _$this._services ??= new ListBuilder<ApplicationDetail>();
  set services(ListBuilder<ApplicationDetail> services) =>
      _$this._services = services;

  ApplicationStatusModel _status;
  ApplicationStatusModel get status => _$this._status;
  set status(ApplicationStatusModel status) => _$this._status = status;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  double _total;
  double get total => _$this._total;
  set total(double total) => _$this._total = total;

  double _moneyPaid;
  double get moneyPaid => _$this._moneyPaid;
  set moneyPaid(double moneyPaid) => _$this._moneyPaid = moneyPaid;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  ApplicationModelBuilder();

  ApplicationModelBuilder get _$this {
    if (_$v != null) {
      _applicationId = _$v.applicationId;
      _images = _$v.images?.toBuilder();
      _services = _$v.services?.toBuilder();
      _status = _$v.status;
      _description = _$v.description;
      _latitude = _$v.latitude;
      _longitude = _$v.longitude;
      _total = _$v.total;
      _moneyPaid = _$v.moneyPaid;
      _createdAt = _$v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ApplicationModel;
  }

  @override
  void update(void Function(ApplicationModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApplicationModel build() {
    _$ApplicationModel _$result;
    try {
      _$result = _$v ??
          new _$ApplicationModel._(
              applicationId: applicationId,
              images: _images?.build(),
              services: _services?.build(),
              status: status,
              description: description,
              latitude: latitude,
              longitude: longitude,
              total: total,
              moneyPaid: moneyPaid,
              createdAt: createdAt);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();
        _$failedField = 'services';
        _services?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ApplicationModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
