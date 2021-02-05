// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_pagination.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BranchPagination> _$branchPaginationSerializer =
    new _$BranchPaginationSerializer();

class _$BranchPaginationSerializer
    implements StructuredSerializer<BranchPagination> {
  @override
  final Iterable<Type> types = const [BranchPagination, _$BranchPagination];
  @override
  final String wireName = 'BranchPagination';

  @override
  Iterable<Object> serialize(Serializers serializers, BranchPagination object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'pages',
      serializers.serialize(object.totalPages,
          specifiedType: const FullType(int)),
      'actual',
      serializers.serialize(object.page, specifiedType: const FullType(int)),
    ];
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType: const FullType(
                BuiltList, const [const FullType(BranchModel)])));
    }
    return result;
  }

  @override
  BranchPagination deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BranchPaginationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'pages':
          result.totalPages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'actual':
          result.page = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BranchModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$BranchPagination extends BranchPagination {
  @override
  final int totalPages;
  @override
  final int page;
  @override
  final BuiltList<BranchModel> data;

  factory _$BranchPagination(
          [void Function(BranchPaginationBuilder) updates]) =>
      (new BranchPaginationBuilder()..update(updates)).build();

  _$BranchPagination._({this.totalPages, this.page, this.data}) : super._() {
    if (totalPages == null) {
      throw new BuiltValueNullFieldError('BranchPagination', 'totalPages');
    }
    if (page == null) {
      throw new BuiltValueNullFieldError('BranchPagination', 'page');
    }
  }

  @override
  BranchPagination rebuild(void Function(BranchPaginationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BranchPaginationBuilder toBuilder() =>
      new BranchPaginationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BranchPagination &&
        totalPages == other.totalPages &&
        page == other.page &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, totalPages.hashCode), page.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BranchPagination')
          ..add('totalPages', totalPages)
          ..add('page', page)
          ..add('data', data))
        .toString();
  }
}

class BranchPaginationBuilder
    implements Builder<BranchPagination, BranchPaginationBuilder> {
  _$BranchPagination _$v;

  int _totalPages;
  int get totalPages => _$this._totalPages;
  set totalPages(int totalPages) => _$this._totalPages = totalPages;

  int _page;
  int get page => _$this._page;
  set page(int page) => _$this._page = page;

  ListBuilder<BranchModel> _data;
  ListBuilder<BranchModel> get data =>
      _$this._data ??= new ListBuilder<BranchModel>();
  set data(ListBuilder<BranchModel> data) => _$this._data = data;

  BranchPaginationBuilder();

  BranchPaginationBuilder get _$this {
    if (_$v != null) {
      _totalPages = _$v.totalPages;
      _page = _$v.page;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BranchPagination other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BranchPagination;
  }

  @override
  void update(void Function(BranchPaginationBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BranchPagination build() {
    _$BranchPagination _$result;
    try {
      _$result = _$v ??
          new _$BranchPagination._(
              totalPages: totalPages, page: page, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BranchPagination', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
