// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BranchResponse> _$branchResponseSerializer =
    new _$BranchResponseSerializer();

class _$BranchResponseSerializer
    implements StructuredSerializer<BranchResponse> {
  @override
  final Iterable<Type> types = const [BranchResponse, _$BranchResponse];
  @override
  final String wireName = 'BranchResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, BranchResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.body != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.body,
            specifiedType: const FullType(BranchPagination)));
    }
    return result;
  }

  @override
  BranchResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BranchResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'data':
          result.body.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BranchPagination))
              as BranchPagination);
          break;
      }
    }

    return result.build();
  }
}

class _$BranchResponse extends BranchResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BranchPagination body;

  factory _$BranchResponse([void Function(BranchResponseBuilder) updates]) =>
      (new BranchResponseBuilder()..update(updates)).build();

  _$BranchResponse._({this.code, this.message, this.body}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('BranchResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('BranchResponse', 'message');
    }
  }

  @override
  BranchResponse rebuild(void Function(BranchResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BranchResponseBuilder toBuilder() =>
      new BranchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BranchResponse &&
        code == other.code &&
        message == other.message &&
        body == other.body;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, code.hashCode), message.hashCode), body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BranchResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('body', body))
        .toString();
  }
}

class BranchResponseBuilder
    implements Builder<BranchResponse, BranchResponseBuilder> {
  _$BranchResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  BranchPaginationBuilder _body;
  BranchPaginationBuilder get body =>
      _$this._body ??= new BranchPaginationBuilder();
  set body(BranchPaginationBuilder body) => _$this._body = body;

  BranchResponseBuilder();

  BranchResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _body = _$v.body?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BranchResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BranchResponse;
  }

  @override
  void update(void Function(BranchResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BranchResponse build() {
    _$BranchResponse _$result;
    try {
      _$result = _$v ??
          new _$BranchResponse._(
              code: code, message: message, body: _body?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'body';
        _body?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BranchResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
