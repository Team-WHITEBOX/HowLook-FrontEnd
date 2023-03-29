import 'package:howlook/feed/model/feed_model.dart';
import 'package:howlook/feed/model/page_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cursor_pagination_model.g.dart';

// 클래스로 상태를 구분할때는 Base 클래스를 abstract로 선언해서 instance로 만들지 못하게 한다.
// 그리하여 Base 클래스를 상속하는 하위 클래스로 상태를 표현하는 다양한 클래스를 선언하여 사용할 수 있다.
// 해당 클래스의 인스턴스가 들어왔다는 사실만으로도 지금 상태가 어떤 상태인지를 구분할 수 있다.
// Ex) CursorPagination, Error, Loading etc...
abstract class CursorPaginationBase {}

// Error 상태를 의미하는 CursorPaginationError Class
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// Data Loading 상태를 의미하는 CursorPaginationLoading Class
class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
// Pagination 상태를 의미하는 CursorPagination Class
class CursorPagination<T> extends CursorPaginationBase {
  // 여긴 페이지네이션 관련해서 데이터 더 있는지에 대한 정보가 있으면 좋을 것 같음
  // final metaData~~~
  // 이건 페이지네이션 해서 들고온 데이터
  // final List<T> data;
  final PageModel data;

  // ** 1차원적으로 생각했을 때 CursorPagination에 isLoading라는 bool 타입의 변수를 추가하면
  // 그 값에 따라 데이터 로딩 중인지 아닌지 구별 가능 하지만, 맨 처음엔 데이터가 없지만 속성을 유지하려고
  // True로 처리되면, 실제 data 및 metadata는 ?을 붙여서 null이 가능한 상태로 만들어야 하는데
  // 이렇게 되면 CursorPagination은 완전 다른 종류의 클래스가 된다.

  // ** 그렇기 떄문에 isLoading을 추가하는 것이 아니라 클래스로 상태를 구분하는 방법을 사용한다.

  CursorPagination({
    required this.data,
  });

  CursorPagination copyWith({
    PageModel? data,
  }) {
    return CursorPagination(
      data: data ?? this.data,
    );
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

// 데이터 새로고침을 위한 클래스,
// CursorPagination 클래스를 상속함 <- MetaData 및 Data가 필요하기 때문
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.data,
  });
}

// 맨 아래로 내려서 추가 데이터를 요청을 위한 클래스,
// CursorPagination 클래스를 상속함 <- MetaData 및 Data가 필요하기 때문
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.data,
  });
}
