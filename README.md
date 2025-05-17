# typespec-practice

TypeSpec を使ってみる

- namespace, interface, model を用いて書く
- ルートの main.tsp は namespace + models + routes に分割するのがやりやすそう

以下のようなディレクトリ構成が扱いやすそう

```
- api-spec(typespec を扱うルートディレクトリ)
  - models(各ドメインの components を記載)
    - pet.tsp
    - common.tsp
    - main.tsp(各 model の import)
  - routes(models を用いて、ディレクトリごとにエンドポイントの requestBodies, response, path の定義を行う)
    - pet
      - request-body.tsp
      - response.tsp
      - main.tsp(request-body と response を用いて/pets の定義)
    - common
      - request.tsp(共通 header や securitySchemes)
      - response.tsp(共通のレスポンス)
      - main.tsp(request.tsp と response の import)
  - namespace.tsp(routes で用いる共通の namespace)
  - main.tsp(namespace, routes, models の import)
```

### 【良かった点】

- components, path の定義をリソースごとに分割できるので定義の可読性と保守性が良さそう
- 元ファイル(tsp ファイル)の変更時に YAML を自動更新できるので(watch オプションがあるので)、開発体験も良い
  - ただ、YAML 出力後にパッチスクリプトを適用するときは何らか自動化するには工夫が要る
- CI で tsp ファイルと YAML のズレがないかチェックもできる
- 既存の YAML から tsp ファイルへ変換もできる
  - (ただしファイル分割は自分たちで行う必要はある)

### 【少し weak point と感じた点】

- 既存の YAML → tsp ファイルへの変換時にもし定義に誤りがあっても通ってしまう点
  - unknown 型に変換される
- YAML から型や API クライアントのコードを自動生成で欲しいものが得られない場合は少し工夫が要る
  - 例えば、ファイル入力で type string(format binary)で欲しいけど、Typespec では requestBody の content-type で出力され、components では{}で出力される等
- キャッチアップコストは一定ありそう
  - 定義の書き方

## 参考

- Docs

  - https://typespec.io/docs/

- OpenAPI から Typespec への移行

  - https://zenn.dev/yuta_takahashi/articles/migrate-to-typespec
  - `npx tsp-openapi3 <openapi yaml path> --output-dir <output-dir>`

- tsp の分割

  - https://speakerdeck.com/euxn23/use-up-typespec
  - https://blog.nnn.dev/entry/2024/12/01/210000
  - https://zenn.dev/kitamago/articles/b71399388965c0#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E5%88%86%E5%89%B2
  - https://zenn.dev/yuta_takahashi/articles/migrate-to-typespec#%E3%83%A2%E3%83%87%E3%83%AB%E3%81%A8%E3%83%AB%E3%83%BC%E3%83%88%E5%AE%9A%E7%BE%A9%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%88%86%E5%89%B2

- --watch による自動再コンパイル
  - https://sat0b.dev/posts/20240630
