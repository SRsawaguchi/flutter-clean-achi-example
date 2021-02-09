# flutter_clean_achi_example
Flutterによる、Clean ArchitectureとBlocパターンのサンプル。  
このサンプルを通じてフロントエンドでのClean Architectureの実装と、Blocパターンを試す。  
また、フロントエンドでもClean ArchitectureとBlocを使うことで、ユニットテストが書きやすくなることを試してみる。  

Blocのハンズオン
- https://github.com/SRsawaguchi/bloc-hanson
- https://github.com/SRsawaguchi/bloc-cubit-hanson

## アプリの内容
RANDOM USER GENERATORのAPIを利用し、架空のユーザ情報を取得して一覧に表示する。  
https://randomuser.me/  

また、リフレッシュボタンをタップすることで、一覧の更新を実装する。  
APIの通信を通じて`flutter_bloc`で利用するBlocProvider、BlocListener、BlocBuilderなどのユーティリティも使ってみる。  

<img src="./docs/app_movie.gif" width="250">

## 利用したライブラリ
※flutter, Bloc系は省略。  

- dartz: Dartで関数型プログラミングを行うユーティリティ（`Either`のみ使った） https://pub.dev/packages/dartz
- equatable: オブジェクトを比較するためのライブラリ(ポインタの比較ではなく) https://pub.dev/packages/equatable
- mockito: ユニットテストの際、Mock化を行う https://pub.dev/packages/mockito
- bloc_test: Blocパターンのテストを行うユーティリティ https://pub.dev/packages/bloc_test

## ディレクトリ構造
`lib`にはアプリのソースコード、`test`にはユニットテストが格納されている。  

### lib
```
.
├── core
│   ├── exceptions.dart
│   ├── failures.dart
│   └── usecase.dart
├── data
│   ├── datasources
│   │   └── random_user_generator_api.dart
│   ├── models
│   │   └── user_model.dart
│   └── repositories
│       └── user_repository_impl.dart
├── domain
│   ├── entities
│   │   └── user.dart
│   ├── repositories
│   │   └── user_repository.dart
│   └── usecases
│       └── fetch_users_usecase.dart
├── main.dart
└── presentation
    ├── bloc
    │   ├── users_cubit.dart
    │   └── users_state.dart
    ├── users_page.dart
    └── widgets
        ├── user_list.dart
        ├── user_list_empty.dart
        ├── user_list_error.dart
        ├── user_list_item.dart
        └── user_list_loading.dart

```

- `core`: 全体で利用するライブラリなど
- `data`: データレイヤ
- `domain`: ドメインレイヤ（ビジネスロジック）
- `presentation`: UIレイヤ。Blocに関する実装を含む
- `main.dart`: flutterのエントリポイント

### test
こちらのディレクトリには、`lib`と同じディレクトリ構造でユニットテストを実装している。  
※`flutter test`で実行できる。IDEのプラグインで実行する方が楽。  

```
.
├── data
│   ├── datasources
│   │   ├── random_user_generator_api_test.dart
│   │   └── random_user_generator_sample_response.dart.dart
│   ├── models
│   │   └── user_model_test.dart
│   └── repositories
│       └── user_repository_impl_test.dart
├── domain
│   └── usecases
│       └── fetch_user_usercase_test.dart
└── presentation
    └── bloc
        └── users_cubit_test.dart
```
