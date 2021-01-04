# 習慣継続アプリ

# 概要

本アプリは継続しなければいけない環境を作るという事を主軸としています。

1. ユーザーが習慣にしたい事を週に何度実行するかを決め、登録します。
2. 登録した習慣を記録していき、決めた実行回数に至らなかった場合フォロワーに通知が飛びます。
3. 実行意欲を上げるため継続して実行するたびにユーザーのレベルが上がり、それをチャートで可視化しました。また実行できなかった場合はレベルが大幅に下がります。
4. 積み上げなどを発信する公開投稿と自分の考えを整理したり自分を鼓舞するための非公開投稿があります。

# 制作背景

私がプログラミングの勉強を始めた時、2人の友人がそれぞれ簿記の勉強、ランニングを頑張りたいと言い、3人で目標を立てました。
一ヶ月経った頃目標に向かい継続して努力していたのは私だけでした。
私と友人達との違いは意思の強さ、弱さではなく継続できる環境を作り、仕組み化したか、してないかだと考えています。
私は「周りに公言する」「1日のルーティーンを決め、記録する」「作業環境に投資する」などやらなければいけない環境を作る事に注力しました。
その仕組みの１つとして本アプリを開発しました。

# URL
https://morning-stream-52789.herokuapp.com/

* ゲストログイン機能搭載

# 使用技術

* HTML
* CSS/Sass/Bootstrap
* JavaScript/jQuery/Ajax
* Ruby 2.6.3p62
* Ruby on Rails 6.0.3.4
* RSpec
* Puma(APサーバー)
* Git/GitHub
* AWS(Cloud9)
* heroku
* vim

# 機能一覧

**ユーザー関連**

 * 新規登録機能
 * ログイン機能
 * ログアウト機能
 * プロフィール表示、編集、削除機能
 * 習慣を達成するたびにLevelが上がる機能
 * 習慣を達成出来なかった時にLevelが下がる機能
 * 達成度で上下するLevelを可視化出来るチャート機能
 * Levelの上位10人を見れるランキング機能

**習慣関連**

 * 習慣登録機能
 * 習慣の編集,ギブアップ機能
 * 習慣を実行した時チェックボックスで記録出来る機能
 * 習慣を登録してから１週間事に実行回数をリセットする機能
 
**投稿機能**

 * 投稿機能
 * 非公開投稿機能
 * 投稿の削除機能
 * みんなの投稿とフォロー中のユーザーの投稿を分けて見れる機能
 
**フォロー、フォロワー機能**

 * ユーザーをフォローする,フォローを外す機能(Ajax化)

**通知機能**

 * ユーザーのレベルが下がった時フォロワーに通知される機能(Toastを使用)
 * 通知全件削除機能
 
**その他**

 * ゲストユーザー機能(編集不可ロジック組み込み)
 * ページネーション機能(kaminariを使用)
 * 習慣の経過をモダールウィンドウで確認できる機能(jQuery)
 * チェックボックスにチェックを入れた時の✔︎をアイコン化(jQuery)
 * flashメッセージの時間指定(jQuery)
 * 使い方を動画で確認できる機能

# 簡単チュートリアル

1. 習慣を登録する
* 行いたいタスクと回数(週)を登録します

![FCDEF6DF-72B9-4C6B-AE85-03C9C672BAD2_1_105_c](https://user-images.githubusercontent.com/67776222/102442242-4ba75a00-4067-11eb-828b-937cd0f897a4.jpeg)
 
2. 記録する
* 登録した習慣を記録していきます
 
![C609D80C-67BF-4AFF-A01C-24AC19FDBBBB_1_105_c](https://user-images.githubusercontent.com/67776222/102442429-bce70d00-4067-11eb-990a-27758d776eed.jpeg)

3. 経過を確認
* 習慣の経過を確認できます(週の実行回数 終了日時など)

![2BBA90E4-A701-41DE-919B-86371A427F36_1_105_c](https://user-images.githubusercontent.com/67776222/102442719-60d0b880-4068-11eb-8a60-355eec5c1f3a.jpeg)

4. 自分のフォローしてるユーザーが目標の回数を実行できなかった時通知が来ます

![BFE624F3-01BD-4346-8817-6C723262C85D_1_105_c](https://user-images.githubusercontent.com/67776222/102443133-5e229300-4069-11eb-85b8-1f15ccc49229.jpeg)

5. 自分が目標の回数を実行できなかった時はlevelが下がり、フォロワーに通知がいきます

![8B8DA15D-2216-4C45-AB7F-EDC74D969A86_1_201_a](https://user-images.githubusercontent.com/67776222/103125257-d9212480-46cd-11eb-9764-f796a73617ab.jpeg)



# 課題

* 投稿や通知にコメントできる機能を実装予定
* コメントが来た時、フォローされた時に通知が来る機能を実装予定
* 一日何度でもチェックできてしまうためcookieを使いチェックした項目は1日非表示にする機能を実装予定
* テストが充実していない

* 実行意欲向上のため一定のレベルに達すると起こるアクションが欲しい

  * 称号を与える
  * 背景画像を変える
  * アニメーションを加える
  * 他のユーザーにアドバイスが出来る機能
 
など
