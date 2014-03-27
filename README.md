# Gipo

GipoはHaxeでのゲーム制作を想定したデザインパターンとそのためのライブラリです。
MVCを参考に、名称や関係の変更や、Haxeの機能の利用をし、画面遷移などのコーディングを助けます。

他プロジェクト[flatomo](https://github.com/tmskst/flatomo)との連携を予定しています。

## 以下の特徴を持ちます

### 木構造を持ちます

木構造は、複雑な構造を表現できないという欠点がある反面、人間にとって理解しやすいものでもあります。

GipoではGearHolderというノードが木構造を作ります。

### 消去システムを持ちます

GearHolderは親要素からremoveされるとそれ以下の要素を全て消去しようとします。再利用はできません。

GearHolderとは関係ない要素も、それぞれのノードに紐づけて消去処理を予約することができます。生成時に必ず消去処理を予約することで、インスタンスの消し忘れが無くなります。

### DIコンテナを持ちます

Diffuserという名前のDIコンテナが用意されています。共有するインスタンスを登録し、必要とする場所で取り出すことができます。

一箇所に集中させるのではなく、木構造のノードに関連付いてそれ以下からのみ取り出すように、範囲を調節でき、対象ノードの削除時には一緒に消去されます。

引数のバケツリレーや、間違ったSingletonを防ぐことができます。

### 他のライブラリやフレームワークと連携しやすいです

なるべく制限やクラスの自動生成を排するように作られています。Gipoはあなたの問題の一部のみを解決します。

### クライアントレベルの再現性を持ちます（実装中）

ゲームではしばしば複雑で再現性の低いバグが発生し、開発や運営を妨げます。

GipoではSection（後述）からのイベントを記録することで、ゲームの動作を再現することができ、バグを何度も再生し、解決に役立てることができます。

これを実現するためには、Logic内部の動作の再現性のない部分をSectionに切り出す必要があります。一般的にはユーザーの入力、パーサーなどの非同期処理、ランダム、通信、日付の利用などです。

## 以下の特徴を持ちません

### 物理エンジンや、便利なマッパーツールは持ちません

ゲームごとに最適な、もっと優秀なライブラリを使用するべきです。

### 簡単にゲームを作ることはできません。

バグの少なさや、機能の拡張性を重要視しています。

簡単にゲームを作るなら、RPGツクールを使うのが良いと思います。

## MVCとの関係

完全にMVCと対応するものではないですが、以下のように関係します。

### View→Section

MVCはViewの要素を切り出すことが出来ますが、Gipoでは切り出すものはViewに限らないと考えます。
切りだされた要素はSectionと呼び、そのうち１種類がViewです。

View以外には、Service（通信の管理）や、あるいはViewをHud要素と3D要素の２つに分離してそれぞれSectionとするというデザインも考えられます。

### Controller→Hook

Controllerは和製英語の関係上、日本人に大きな誤解を与えてきました。

HookはSectionのイベントをLogicに伝える役目をし、またイベントを記録することでゲームの再現性を担保します。

### Model→Top＋Logic

ModelはTopとLogicに対応します。

Topは各要素の関連性を定義します。

Logicはゲームの処理そのものを担当します。

ゲームの開発中にLogicから新しいSectionが切りだされることがあります。
