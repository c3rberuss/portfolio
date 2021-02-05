// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CardModel extends CardModel {
  @override
  final String number;
  @override
  final String cvc;
  @override
  final String name;
  @override
  final int expMonth;
  @override
  final int expYear;

  factory _$CardModel([void Function(CardModelBuilder) updates]) =>
      (new CardModelBuilder()..update(updates)).build();

  _$CardModel._({this.number, this.cvc, this.name, this.expMonth, this.expYear})
      : super._() {
    if (number == null) {
      throw new BuiltValueNullFieldError('CardModel', 'number');
    }
    if (cvc == null) {
      throw new BuiltValueNullFieldError('CardModel', 'cvc');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('CardModel', 'name');
    }
    if (expMonth == null) {
      throw new BuiltValueNullFieldError('CardModel', 'expMonth');
    }
    if (expYear == null) {
      throw new BuiltValueNullFieldError('CardModel', 'expYear');
    }
  }

  @override
  CardModel rebuild(void Function(CardModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardModelBuilder toBuilder() => new CardModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardModel &&
        number == other.number &&
        cvc == other.cvc &&
        name == other.name &&
        expMonth == other.expMonth &&
        expYear == other.expYear;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, number.hashCode), cvc.hashCode), name.hashCode),
            expMonth.hashCode),
        expYear.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CardModel')
          ..add('number', number)
          ..add('cvc', cvc)
          ..add('name', name)
          ..add('expMonth', expMonth)
          ..add('expYear', expYear))
        .toString();
  }
}

class CardModelBuilder implements Builder<CardModel, CardModelBuilder> {
  _$CardModel _$v;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  String _cvc;
  String get cvc => _$this._cvc;
  set cvc(String cvc) => _$this._cvc = cvc;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _expMonth;
  int get expMonth => _$this._expMonth;
  set expMonth(int expMonth) => _$this._expMonth = expMonth;

  int _expYear;
  int get expYear => _$this._expYear;
  set expYear(int expYear) => _$this._expYear = expYear;

  CardModelBuilder();

  CardModelBuilder get _$this {
    if (_$v != null) {
      _number = _$v.number;
      _cvc = _$v.cvc;
      _name = _$v.name;
      _expMonth = _$v.expMonth;
      _expYear = _$v.expYear;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CardModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CardModel;
  }

  @override
  void update(void Function(CardModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CardModel build() {
    final _$result = _$v ??
        new _$CardModel._(
            number: number,
            cvc: cvc,
            name: name,
            expMonth: expMonth,
            expYear: expYear);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
