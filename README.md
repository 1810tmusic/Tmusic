【モデル(db/migrate)】
・migrationファイル2件追加
　・Cartにdestination_idカラムを追加
　・Historyにuser_idカラムを追加

【モデル(models)】
・共通
　・リレーションのhas_many,has_one側にforeign_keyを追加
・購入履歴
　・Destination:Carts = 1:多のリレーションを追加
　・User:Histories = 1:多のリレーションを追加
・ユーザー - 論理削除
　・Userモデルからparanoia関連の記述を削除
　・Userモデルに論理削除ユーザーのログイン禁止アクション(devise用)を追加

【ルーティング】
・POSTメソッド 'purchase'を追加
　★カート購入ボタンのリンク先は「purchase_path(@cart.id)」「method: :post」でお願いします！！！
・購入履歴のルーティングがresourcesとかぶるかもしれません・・・
・POSTメソッド 'soft_destroy'を追加
　★退会ボタンのリンク先は「soft_destroy_path(current_user.id)」「method: :post」「"data-confirm" => "本当に退会しますか？"」でお願いします！！！

【その他共通部分】
・bootstrap適用
　・application.css → application.scss

【購入履歴】
・histories_controller
・views
　・index, show

【ユーザー - 論理削除】
・gem 'paranoia'は削除（gemなしで実装）
・users_controller
　・leaveアクションをsoft_destroyアクションに変更
　・soft_destroyアクション（退会時の処理）
・users.scssにサンプル表示用の記述

【商品 - トップページ】
・products_controller
　・topアクションの中身追加
・views - top
　・新着順に6件まで一覧表示
　　・画像部分はbackground-colorで埋めているだけ(products.scssに記述あり)
　　・product.artist.artist_nameはリレーションがうまくいっていないと映らないかもしれません（作成時アーティスト名を商品テーブルに直接入れていたので、別テーブルの場合は未確認です）
　・（Postの多い6件は未実装）

【pushしていないもの】
★商品の価格表示、カートの総額計算のコードは現在(最新)・購入時それぞれ書いてあるので使いたい人は言ってください！！！
★ユーザーの退会しているか否かの表示のコードは書いてあるので使いたい人は言ってください！！！