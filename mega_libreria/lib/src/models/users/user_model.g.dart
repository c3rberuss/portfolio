// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserModel> _$userModelSerializer = new _$UserModelSerializer();

class _$UserModelSerializer implements StructuredSerializer<UserModel> {
  @override
  final Iterable<Type> types = const [UserModel, _$UserModel];
  @override
  final String wireName = 'UserModel';

  @override
  Iterable<Object> serialize(Serializers serializers, UserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('nombre')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.lastName != null) {
      result
        ..add('apellido')
        ..add(serializers.serialize(object.lastName,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    if (object.phone != null) {
      result
        ..add('telefono')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.address != null) {
      result
        ..add('direccion')
        ..add(serializers.serialize(object.address,
            specifiedType: const FullType(String)));
    }
    if (object.reference != null) {
      result
        ..add('referencia')
        ..add(serializers.serialize(object.reference,
            specifiedType: const FullType(String)));
    }
    if (object.department != null) {
      result
        ..add('departamento')
        ..add(serializers.serialize(object.department,
            specifiedType: const FullType(DepartmentModel)));
    }
    if (object.city != null) {
      result
        ..add('municipio')
        ..add(serializers.serialize(object.city,
            specifiedType: const FullType(CityModel)));
    }
    if (object.longitude != null) {
      result
        ..add('longitud')
        ..add(serializers.serialize(object.longitude,
            specifiedType: const FullType(double)));
    }
    if (object.latitude != null) {
      result
        ..add('latitud')
        ..add(serializers.serialize(object.latitude,
            specifiedType: const FullType(double)));
    }
    if (object.token != null) {
      result
        ..add('token')
        ..add(serializers.serialize(object.token,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'nombre':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'apellido':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'telefono':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'direccion':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'referencia':
          result.reference = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'departamento':
          result.department.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DepartmentModel))
              as DepartmentModel);
          break;
        case 'municipio':
          result.city.replace(serializers.deserialize(value,
              specifiedType: const FullType(CityModel)) as CityModel);
          break;
        case 'longitud':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'latitud':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserModel extends UserModel {
  @override
  final String name;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String reference;
  @override
  final DepartmentModel department;
  @override
  final CityModel city;
  @override
  final double longitude;
  @override
  final double latitude;
  @override
  final String token;

  factory _$UserModel([void Function(UserModelBuilder) updates]) =>
      (new UserModelBuilder()..update(updates)).build();

  _$UserModel._(
      {this.name,
      this.lastName,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.reference,
      this.department,
      this.city,
      this.longitude,
      this.latitude,
      this.token})
      : super._();

  @override
  UserModel rebuild(void Function(UserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        name == other.name &&
        lastName == other.lastName &&
        email == other.email &&
        password == other.password &&
        phone == other.phone &&
        address == other.address &&
        reference == other.reference &&
        department == other.department &&
        city == other.city &&
        longitude == other.longitude &&
        latitude == other.latitude &&
        token == other.token;
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
                                            $jc($jc(0, name.hashCode),
                                                lastName.hashCode),
                                            email.hashCode),
                                        password.hashCode),
                                    phone.hashCode),
                                address.hashCode),
                            reference.hashCode),
                        department.hashCode),
                    city.hashCode),
                longitude.hashCode),
            latitude.hashCode),
        token.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserModel')
          ..add('name', name)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('password', password)
          ..add('phone', phone)
          ..add('address', address)
          ..add('reference', reference)
          ..add('department', department)
          ..add('city', city)
          ..add('longitude', longitude)
          ..add('latitude', latitude)
          ..add('token', token))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _reference;
  String get reference => _$this._reference;
  set reference(String reference) => _$this._reference = reference;

  DepartmentModelBuilder _department;
  DepartmentModelBuilder get department =>
      _$this._department ??= new DepartmentModelBuilder();
  set department(DepartmentModelBuilder department) =>
      _$this._department = department;

  CityModelBuilder _city;
  CityModelBuilder get city => _$this._city ??= new CityModelBuilder();
  set city(CityModelBuilder city) => _$this._city = city;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  UserModelBuilder();

  UserModelBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _password = _$v.password;
      _phone = _$v.phone;
      _address = _$v.address;
      _reference = _$v.reference;
      _department = _$v.department?.toBuilder();
      _city = _$v.city?.toBuilder();
      _longitude = _$v.longitude;
      _latitude = _$v.latitude;
      _token = _$v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserModel;
  }

  @override
  void update(void Function(UserModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserModel build() {
    _$UserModel _$result;
    try {
      _$result = _$v ??
          new _$UserModel._(
              name: name,
              lastName: lastName,
              email: email,
              password: password,
              phone: phone,
              address: address,
              reference: reference,
              department: _department?.build(),
              city: _city?.build(),
              longitude: longitude,
              latitude: latitude,
              token: token);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'department';
        _department?.build();
        _$failedField = 'city';
        _city?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
