// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderModel> _$orderModelSerializer = new _$OrderModelSerializer();

class _$OrderModelSerializer implements StructuredSerializer<OrderModel> {
  @override
  final Iterable<Type> types = const [OrderModel, _$OrderModel];
  @override
  final String wireName = 'OrderModel';

  @override
  Iterable<Object> serialize(Serializers serializers, OrderModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'total',
      serializers.serialize(object.total,
          specifiedType: const FullType(double)),
      'detalles',
      serializers.serialize(object.detail,
          specifiedType: const FullType(
              BuiltList, const [const FullType(OrderDetailModel)])),
    ];
    if (object.id != null) {
      result
        ..add('id_orden')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.date != null) {
      result
        ..add('fecha')
        ..add(serializers.serialize(object.date,
            specifiedType: const FullType(String)));
    }
    if (object.time != null) {
      result
        ..add('hora')
        ..add(serializers.serialize(object.time,
            specifiedType: const FullType(String)));
    }
    if (object.orderNumber != null) {
      result
        ..add('numero_orden')
        ..add(serializers.serialize(object.orderNumber,
            specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result
        ..add('estado')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    if (object.fareDelivery != null) {
      result
        ..add('envio')
        ..add(serializers.serialize(object.fareDelivery,
            specifiedType: const FullType(double)));
    }
    if (object.paymentType != null) {
      result
        ..add('tipo_pago')
        ..add(serializers.serialize(object.paymentType,
            specifiedType: const FullType(PaymentType)));
    }
    if (object.address != null) {
      result
        ..add('dirección')
        ..add(serializers.serialize(object.address,
            specifiedType: const FullType(AddressModel)));
    }
    if (object.addressId != null) {
      result
        ..add('id_direccion')
        ..add(serializers.serialize(object.addressId,
            specifiedType: const FullType(int)));
    }
    if (object.companyId != null) {
      result
        ..add('id_empresa')
        ..add(serializers.serialize(object.companyId,
            specifiedType: const FullType(int)));
    }
    if (object.company != null) {
      result
        ..add('empresa')
        ..add(serializers.serialize(object.company,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OrderModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id_orden':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fecha':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hora':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'numero_orden':
          result.orderNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'detalles':
          result.detail.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(OrderDetailModel)]))
              as BuiltList<Object>);
          break;
        case 'estado':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'envio':
          result.fareDelivery = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tipo_pago':
          result.paymentType = serializers.deserialize(value,
              specifiedType: const FullType(PaymentType)) as PaymentType;
          break;
        case 'dirección':
          result.address.replace(serializers.deserialize(value,
              specifiedType: const FullType(AddressModel)) as AddressModel);
          break;
        case 'id_direccion':
          result.addressId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id_empresa':
          result.companyId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'empresa':
          result.company = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OrderModel extends OrderModel {
  @override
  final int id;
  @override
  final String date;
  @override
  final String time;
  @override
  final double total;
  @override
  final String orderNumber;
  @override
  final BuiltList<OrderDetailModel> detail;
  @override
  final String status;
  @override
  final double fareDelivery;
  @override
  final PaymentType paymentType;
  @override
  final AddressModel address;
  @override
  final int addressId;
  @override
  final int companyId;
  @override
  final String company;

  factory _$OrderModel([void Function(OrderModelBuilder) updates]) =>
      (new OrderModelBuilder()..update(updates)).build();

  _$OrderModel._(
      {this.id,
      this.date,
      this.time,
      this.total,
      this.orderNumber,
      this.detail,
      this.status,
      this.fareDelivery,
      this.paymentType,
      this.address,
      this.addressId,
      this.companyId,
      this.company})
      : super._() {
    if (total == null) {
      throw new BuiltValueNullFieldError('OrderModel', 'total');
    }
    if (detail == null) {
      throw new BuiltValueNullFieldError('OrderModel', 'detail');
    }
  }

  @override
  OrderModel rebuild(void Function(OrderModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderModelBuilder toBuilder() => new OrderModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderModel &&
        id == other.id &&
        date == other.date &&
        time == other.time &&
        total == other.total &&
        orderNumber == other.orderNumber &&
        detail == other.detail &&
        status == other.status &&
        fareDelivery == other.fareDelivery &&
        paymentType == other.paymentType &&
        address == other.address &&
        addressId == other.addressId &&
        companyId == other.companyId &&
        company == other.company;
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc($jc(0, id.hashCode),
                                                    date.hashCode),
                                                time.hashCode),
                                            total.hashCode),
                                        orderNumber.hashCode),
                                    detail.hashCode),
                                status.hashCode),
                            fareDelivery.hashCode),
                        paymentType.hashCode),
                    address.hashCode),
                addressId.hashCode),
            companyId.hashCode),
        company.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrderModel')
          ..add('id', id)
          ..add('date', date)
          ..add('time', time)
          ..add('total', total)
          ..add('orderNumber', orderNumber)
          ..add('detail', detail)
          ..add('status', status)
          ..add('fareDelivery', fareDelivery)
          ..add('paymentType', paymentType)
          ..add('address', address)
          ..add('addressId', addressId)
          ..add('companyId', companyId)
          ..add('company', company))
        .toString();
  }
}

class OrderModelBuilder implements Builder<OrderModel, OrderModelBuilder> {
  _$OrderModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  double _total;
  double get total => _$this._total;
  set total(double total) => _$this._total = total;

  String _orderNumber;
  String get orderNumber => _$this._orderNumber;
  set orderNumber(String orderNumber) => _$this._orderNumber = orderNumber;

  ListBuilder<OrderDetailModel> _detail;
  ListBuilder<OrderDetailModel> get detail =>
      _$this._detail ??= new ListBuilder<OrderDetailModel>();
  set detail(ListBuilder<OrderDetailModel> detail) => _$this._detail = detail;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  double _fareDelivery;
  double get fareDelivery => _$this._fareDelivery;
  set fareDelivery(double fareDelivery) => _$this._fareDelivery = fareDelivery;

  PaymentType _paymentType;
  PaymentType get paymentType => _$this._paymentType;
  set paymentType(PaymentType paymentType) => _$this._paymentType = paymentType;

  AddressModelBuilder _address;
  AddressModelBuilder get address =>
      _$this._address ??= new AddressModelBuilder();
  set address(AddressModelBuilder address) => _$this._address = address;

  int _addressId;
  int get addressId => _$this._addressId;
  set addressId(int addressId) => _$this._addressId = addressId;

  int _companyId;
  int get companyId => _$this._companyId;
  set companyId(int companyId) => _$this._companyId = companyId;

  String _company;
  String get company => _$this._company;
  set company(String company) => _$this._company = company;

  OrderModelBuilder();

  OrderModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _date = _$v.date;
      _time = _$v.time;
      _total = _$v.total;
      _orderNumber = _$v.orderNumber;
      _detail = _$v.detail?.toBuilder();
      _status = _$v.status;
      _fareDelivery = _$v.fareDelivery;
      _paymentType = _$v.paymentType;
      _address = _$v.address?.toBuilder();
      _addressId = _$v.addressId;
      _companyId = _$v.companyId;
      _company = _$v.company;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrderModel;
  }

  @override
  void update(void Function(OrderModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrderModel build() {
    _$OrderModel _$result;
    try {
      _$result = _$v ??
          new _$OrderModel._(
              id: id,
              date: date,
              time: time,
              total: total,
              orderNumber: orderNumber,
              detail: detail.build(),
              status: status,
              fareDelivery: fareDelivery,
              paymentType: paymentType,
              address: _address?.build(),
              addressId: addressId,
              companyId: companyId,
              company: company);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'detail';
        detail.build();

        _$failedField = 'address';
        _address?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrderModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
