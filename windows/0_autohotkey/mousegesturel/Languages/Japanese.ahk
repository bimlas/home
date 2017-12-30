;===============================================================================
;
;		MouseGestureL.ahk - Language Definition Module
;			<< 日本語 >>
;														Created by Pyonkichi
;===============================================================================
;-------------------------------------------------------------------------------
; 共通文字列定義
;-------------------------------------------------------------------------------
; デフォルトターゲット名
MC_DefTargetName = Default

; デフォルト設定
MC_PresetItems =
(%
[ジェスチャー無効]
Icon=%A_WinDir%\system32\shell32.dll,110

[ブラウザ]
Icon=%A_WinDir%\system32\inetcpl.cpl,7
Exe=iexplore.exe
Exe=chrome.exe
Exe=firefox.exe

[エクスプローラー]
Icon=%A_WinDir%\explorer.exe,1
WClass=CabinetWClass
WClass=ExploreWClass
WClass=Progman
WClass=WorkerW

[アイコン]
Icon=%A_WinDir%\explorer.exe,1
Level=2
Custom=MG_TreeListHitTest()

[RB_]
G=RB_
Default=;アクティブ化<MG_CR>IfWinNotActive<MG_CR>{		WinActivate<MG_CR>}
エクスプローラー/アイコン=;ジェスチャーキャンセル<MG_CR>MG_Abort()

[RB_LB_]
G=RB_LB__
Default=;ウィンドウを閉じる<MG_CR>PostMessage, 0x0010

[RB_←]
G=RB_L_
Default=;戻る<MG_CR>Send, !{Left}

[RB_→]
G=RB_R_
Default=;進む<MG_CR>Send, !{Right}

[RB_↑]
G=RB_U_
Default=;先頭へジャンプ<MG_CR>Send, ^{Home}

[RB_↓]
G=RB_D_
Default=;最後へジャンプ<MG_CR>Send, ^{End}

[RB_←↑]
G=RB_LU_

[RB_←↓]
G=RB_LD_

[RB_→↑]
G=RB_RU_
Default=;直前のアクティブウィンドウを復元<MG_CR>if (MG_Defer()) {		MG_ActivatePrevWin()<MG_CR>}

[RB_→↓]
G=RB_RD_
Default=;最小化<MG_CR>PostMessage, 0x0112, 0xF020, 0

[RB_↑←]
G=RB_UL_

[RB_↑→]
G=RB_UR_

[RB_↓←]
G=RB_DL_

[RB_↓→]
G=RB_DR_
)

; ヘルプファイル
MC_HelpFile = MouseGestureL_JPN.chm

; ボタン
MC_LngButton001 = 閉じる(&C)
MC_LngButton002 = クリップボードへコピー(&O)

; メッセージ
MC_LngMessage001 = ヘルプファイルが見つかりません。
MC_LngMessage002 =
(LTrim
				設定に問題があるようです。
				下記のエラーメッセージから問題箇所を特定し、設定画面より修正を行ってください。
				エラーの原因を特定できない場合は、バックアップより設定ファイルの復旧を行ってください。
				
				----------------------------------------------------------------------`n`n
)

if (MG_IsEdit)
{
	Goto SetEdit
}
;-------------------------------------------------------------------------------
; アプリケーション用文字列定義
;-------------------------------------------------------------------------------
; メニュー
MG_LngMenu001 = ジェスチャー有効(&E)
MG_LngMenu002 = ナビ表示(&G)
MG_LngMenu003 = ジェスチャー設定(&C)...
MG_LngMenu004 = 拡張スクリプト編集(&U)
MG_LngMenu005 = 操作ログをコピー(&P)
MG_LngMenu006 = プラグインフォルダを開く(&O)
MG_LngMenu007 = プラグイン(&P)
MG_LngMenu008 = 言語(&L)...
MG_LngMenu009 = ヘルプ(&H)
MG_LngMenu010 = バージョン情報(&A)
MG_LngMenu011 = 再起動(&R)
MG_LngMenu012 = 終了(&X)
MG_LngMenu013 = マウスジェスチャー(&M)

; ツールチップ
MG_LngTooltip001 = ジェスチャー有効
MG_LngTooltip002 = ジェスチャー無効
MG_LngTooltip003 = ナビON
MG_LngTooltip004 = ナビOFF

; その他文字列
MG_LngOthers001 =
(LTrim
				;===============================================================================
				;
				;		MouseGestureL.ahk 拡張スクリプト
				;
				;		・起動時の初期化処理や、ジェスチャー実行時に呼び出されるサブルーチン、
				;		　関数などを定義できます。
				;		・設定画面内の各種リストのサイズなども変更できます。
				;		・内容を書き換えた場合はスクリプトをリロードしてください。
				;
				;===============================================================================

)
MG_LngOthers002 = ユーザー定義の初期化処理
MG_LngOthers003 = ユーザー定義サブルーチン
MG_LngOthers004 = MouseGestureL.ahk用
MG_LngOthers005 = MG_Edit.ahk用
MG_LngOthers006 = MouseGestureL.ahk、MG_Edit.ahk共通

Goto EndLanguage

;-------------------------------------------------------------------------------
; MG_Edit用文字列定義
;-------------------------------------------------------------------------------
SetEdit:

; トリガ操作
Button_LB	= 左ボタン押し下げ
Button_RB	= 右ボタン押し下げ
Button_MB	= 中央ボタン押し下げ
Button_X1B	= 第4ボタン押し下げ
Button_X2B	= 第5ボタン押し下げ
Button_X3B	= 第6ボタン押し下げ
Button_X4B	= 第7ボタン押し下げ
Button_X5B	= 第8ボタン押し下げ
Button_X6B	= 第9ボタン押し下げ
Button_X7B	= 第10ボタン押し下げ
Button_X8B	= 第11ボタン押し下げ
Button_X9B	= 第12ボタン押し下げ
Button_WU	= ホイール上回転
Button_WD	= ホイール下回転
Button_LT	= 左チルト押し下げ
Button_RT	= 右チルト押し下げ
Button_ET	= 画面上端に接触(全体)
Button_ETA	= 画面上端に接触(左半分)
Button_ETB	= 画面上端に接触(右半分)
Button_ET1	= 画面上端に接触(左1/3)
Button_ET2	= 画面上端に接触(中央1/3)
Button_ET3	= 画面上端に接触(右1/3)
Button_EB	= 画面下端に接触(全体)
Button_EBA	= 画面下端に接触(左半分)
Button_EBB	= 画面下端に接触(右半分)
Button_EB1	= 画面下端に接触(左1/3)
Button_EB2	= 画面下端に接触(中央1/3)
Button_EB3	= 画面下端に接触(右1/3)
Button_EL	= 画面左端に接触(全体)
Button_ELA	= 画面左端に接触(上半分)
Button_ELB	= 画面左端に接触(下半分)
Button_EL1	= 画面左端に接触(上1/3)
Button_EL2	= 画面左端に接触(中央1/3)
Button_EL3	= 画面左端に接触(下1/3)
Button_ER	= 画面右端に接触(全体)
Button_ERA	= 画面右端に接触(上半分)
Button_ERB	= 画面右端に接触(下半分)
Button_ER1	= 画面右端に接触(上1/3)
Button_ER2	= 画面右端に接触(中央1/3)
Button_ER3	= 画面右端に接触(下1/3)
Button_CRT	= 画面右上角に接触
Button_CLT	= 画面左上角に接触
Button_CRB	= 画面右下角に接触
Button_CLB	= 画面左下角に接触

; アクションの種類
ActionType001 = 全て
ActionType002 = 入力エミュレーション
ActionType003 = スクロール
ActionType004 = ウィンドウ制御
ActionType005 = プロセス制御
ActionType006 = アプリケーション制御
ActionType007 = サウンド制御
ActionType008 = スクリプト制御
ActionType009 = ナビ・軌跡
ActionType010 = その他

; アクション名
ActionName001 = キー操作を発生させる
ActionName002 = マウスクリックを発生させる
ActionName003 = ホイール回転を発生させる
ActionName004 = カーソルを移動
ActionName005 = スクロール
ActionName006 = ドラッグスクロール
ActionName007 = ウィンドウをアクティブ化
ActionName008 = ウィンドウを最小化
ActionName009 = ウィンドウを最大化
ActionName010 = ウィンドウを元の状態に戻す
ActionName011 = ウィンドウを閉じる
ActionName012 = ウィンドウを最背面に送る
ActionName013 = ウィンドウを最前面化する
ActionName014 = ウィンドウの最前面化を解除
ActionName015 = ウィンドウの最前面化／解除の切り替え
ActionName016 = ウィンドウの位置とサイズを変更
ActionName017 = ウィンドウの透明度を変更
ActionName018 = ウィンドウの半透明化を解除
ActionName019 = 直前のアクティブウィンドウを復元
ActionName020 = プログラムを起動
ActionName021 = プロセスを強制終了
ActionName022 = ツールバーボタンのコマンドを実行
ActionName023 = メニューバーのコマンドを実行
ActionName024 = ボリューム変更
ActionName025 = 音声のミュート
ActionName026 = サウンドを再生
ActionName027 = ジェスチャーの認識を打ち切る
ActionName028 = 追加ジェスチャーの入力を待つ
ActionName029 = 時間待ち
ActionName030 = 指定時間の経過後に実行
ActionName031 = 指定時間の経過後にボタンを放したら実行
ActionName032 = ボタンを放すまで繰り返す
ActionName033 = ジェスチャーの認識終了後に実行
ActionName034 = アクティブウィンドウをターゲットにする
ActionName035 = ツールチップナビに文字列を表示
ActionName036 = ナビの表示を停止する
ActionName037 = 軌跡の表示を停止する
ActionName038 = クリップボードに文字列をコピー
ActionName039 = PostMessage
ActionName040 = SendMessage

; アクションコメント
ActionComment001 = ジェスチャー入力直後の動作
ActionComment002 = 指定時間経過後の動作
ActionComment003 = ボタンを押している間繰り返す動作
ActionComment004 = ボタンを放したときの動作
ActionComment005 = 指定時間の経過後にボタンを放したときの動作
ActionComment006 = ジェスチャーの認識終了後に実行する動作

; ダイアログBOXのキャプション
ME_LngCapt001 = MouseGestureL
ME_LngCapt002 = MouseGestureL 設定
ME_LngCapt003 = 削除確認
ME_LngCapt004 = 新規ボタン作成
ME_LngCapt005 = スクリプトエディタの指定
ME_LngCapt006 = トリガ操作別の矢印色
ME_LngCapt007 = 矩形領域設定
ME_LngCapt011 = アクションの追加
ME_LngCapt012 = キー入力
ME_LngCapt013 = キーストローク直接編集
ME_LngCapt014 = マウスクリックの設定
ME_LngCapt015 = ホイール回転の設定
ME_LngCapt016 = カーソル移動の設定
ME_LngCapt017 = スクロールの設定
ME_LngCapt018 = ドラッグスクロールの設定
ME_LngCapt019 = ウィンドウ位置とサイズの設定
ME_LngCapt022 = 実行ファイルの指定
ME_LngCapt023 = サウンドファイルの指定
ME_LngCapt024 = 送信メッセージの設定
ME_LngCapt025 = アイコンファイルの選択

; タブ
ME_LngTab001 = メイン`nターゲット`nジェスチャー`n認識設定`nナビ`n軌跡・ログ`nその他

; メニュー
ME_LngMenu001 = ウィンドウの部位
ME_LngMenu002 = タイトルバー
ME_LngMenu003 = タイトルバーのアイコン
ME_LngMenu004 = 最小化ボタン
ME_LngMenu005 = 最大化ボタン
ME_LngMenu006 = 閉じるボタン
ME_LngMenu007 = ヘルプボタン
ME_LngMenu008 = メニューバー
ME_LngMenu009 = 縦スクロールバー
ME_LngMenu010 = 横スクロールバー
ME_LngMenu011 = 枠
ME_LngMenu012 = リサイズ可能な枠
ME_LngMenu013 = その他の領域
ME_LngMenu014 = ツリー/リストの項目上
ME_LngMenu015 = マウスカーソル
ME_LngMenu016 = 通常(矢印)
ME_LngMenu017 = 縦線(テキスト欄など)
ME_LngMenu018 = 指(リンクなど)
ME_LngMenu019 = 砂時計
ME_LngMenu020 = 十字
ME_LngMenu021 = 禁止
ME_LngMenu022 = 矢印+砂時計
ME_LngMenu023 = 矢印+疑問符
ME_LngMenu024 = 4方向矢印
ME_LngMenu025 = 上下矢印
ME_LngMenu026 = 左右矢印
ME_LngMenu027 = ＼矢印
ME_LngMenu028 = ／矢印
ME_LngMenu029 = 垂直矢印
ME_LngMenu030 = 上記標準カーソルのどれか
ME_LngMenu031 = 不明(ソフト固有など)
ME_LngMenu032 = ウィンドウ状態
ME_LngMenu033 = 最大化
ME_LngMenu034 = 通常
ME_LngMenu035 = 半透明
ME_LngMenu036 = 不透明
ME_LngMenu037 = 最前面
ME_LngMenu038 = 非最前面
ME_LngMenu039 = キーボード状態
ME_LngMenu040 = Shiftキー押し下げ
ME_LngMenu041 = Shiftキー非押し下げ
ME_LngMenu042 = Ctrlキー押し下げ
ME_LngMenu043 = Ctrlキー非押し下げ
ME_LngMenu044 = Altキー押し下げ
ME_LngMenu045 = Altキー非押し下げ
ME_LngMenu046 = 矩形領域判定
ME_LngMenu047 = ウィンドウ相対座標
ME_LngMenu048 = スクリーン絶対座標
ME_LngMenu049 = 画面端接触認識
ME_LngMenu050 = 新しいボタンを作成
ME_LngMenu102 = (なし)
ME_LngMenu105 = ターゲットの設定(&T)
ME_LngMenu103 = 新規ターゲット(&N)	Ctrl+N
ME_LngMenu104 = サブターゲットを追加(&S)
ME_LngMenu106 = 削除(&D)	Delete
ME_LngMenu107 = 複製(&P)
ME_LngMenu108 = クリップボードへコピー(&C)	Ctrl+C
ME_LngMenu109 = クリップボードからインポート(&I)	Ctrl+V
ME_LngMenu110 = 上へ移動(&U)	Shift+↑
ME_LngMenu111 = 下へ移動(&O)	Shift+↓
ME_LngMenu112 = 名前順で並べ替え(&R)
ME_LngMenu113 = サブターゲットを折りたたむ(&F)	Ctrl+F
ME_LngMenu114 = ジェスチャーの設定(&G)
ME_LngMenu115 = ジェスチャーを追加(&A)
ME_LngMenu116 = 新規ジェスチャーを定義(&N)
ME_LngMenu121 = 新規ジェスチャー(&N)	Ctrl+N
ME_LngMenu131 = ターゲットの変更(&T)

; スタティックテキスト
ME_LngText001 = ターゲット(&T):
ME_LngText002 = ジェスチャー(&G):
ME_LngText003 = ターゲットの優先順位(&T):
ME_LngText004 = アクションスクリプト(&S):
ME_LngText005 = カテゴリ(&E):
ME_LngText021 = トリガ操作:
ME_LngText022 = カーソル移動:
ME_LngText023 = ボタンの名前:
ME_LngText024 = キー文字列:
ME_LngText025 = デフォルトアクション:
ME_LngText051 = 名称(&N):
ME_LngText052 = 種別(&T):
ME_LngText053 = 値(&V):
ME_LngText054 = 判定方法(&R):
ME_LngText100 = ジェスチャー認識処理の間隔 (ms):
ME_LngText101 = 通常ストローク:
ME_LngText102 = 4方向モードの「LL」「RR」:
ME_LngText103 = 4方向モードの「UU」「DD」:
ME_LngText104 = 8方向モードの長距離ストローク:
ME_LngText105 = 第1ストローク:
ME_LngText106 = 縦横移動の後:
ME_LngText107 = 斜め移動の後:
ME_LngText108 = ジェスチャーのタイムアウト判定を開始するカーソル移動量:
ME_LngText109 = ボタンを押している間に認識が打ち切られるまでの時間 (ms):
ME_LngText110 = ボタンを放した後に追加ジェスチャーの入力を許容する時間 (ms):
ME_LngText111 = 接触認識処理の間隔 (ms):
ME_LngText112 = コーナーの認識範囲:
ME_LngText113 = 横:
ME_LngText114 = 縦:
ME_LngText200 = ナビの種類:
ME_LngText201 = 表示更新間隔 (ms):
ME_LngText202 = ナビが消えるまでの時間 (ms):
ME_LngText203 = 矢印の色 (RRGGBB):
ME_LngText204 = 背景色 (RRGGBB):
ME_LngText205 = 矢印の透明度 (0～255):
ME_LngText206 = 矢印のサイズ:
ME_LngText207 = 矢印の間隔:
ME_LngText208 = 縁から矢印までの余白:
ME_LngText209 = カーソルからの距離:`n( -1 で開始位置に固定)
ME_LngText210 = 矢印の色:
ME_LngText300 = 文字の色 (RRGGBB):
ME_LngText301 = 未確定文字の色 (RRGGBB):
ME_LngText302 = ウィンドウの背景色 (RRGGBB):
ME_LngText303 = ウィンドウの透明度 (0～255):
ME_LngText304 = 文字のサイズ:
ME_LngText305 = フォント名:
ME_LngText306 = 表示位置:
ME_LngText307 = 左側余白:
ME_LngText308 = 右側余白:
ME_LngText309 = 上側余白:
ME_LngText310 = 下側余白:
ME_LngText311 = ウィンドウの角の丸み:
ME_LngText312 = カーソルからの距離:`n( -1 で開始位置に固定)
ME_LngText313 = 画面端からの距離X:
ME_LngText314 = 画面端からの距離Y:
ME_LngText400 = 軌跡の色 (RRGGBB):
ME_LngText401 = 軌跡の透明度 (0～255):
ME_LngText402 = 軌跡の太さ:
ME_LngText403 = 軌跡の描画を開始するカーソル移動量:
ME_LngText404 = 表示更新間隔 (ms):
ME_LngText421 = X座標:
ME_LngText422 = Y座標:
ME_LngText423 = ログの表示行数:
ME_LngText424 = ログウィンドウの横幅:
ME_LngText451 = ジェスチャー有効/無効の切り替え:
ME_LngText452 = ナビON/OFFの切り替え:
ME_LngText455 = 高さの制限 (0で無制限):
ME_LngText501 = 横幅:
ME_LngText502 = 高さ:
ME_LngText503 = ※横幅と高さは「 0 」でウィンドウ全体の横幅、高さになります。
ME_LngText504 = 対象:
ME_LngText505 = 基準コーナー:
ME_LngText506 = 判定座標:
ME_LngText521 = キーを入力してください:
ME_LngText522 = マウスボタン:
ME_LngText523 = 操作状態:
ME_LngText524 = 入力回数:
ME_LngText525 = 操作状態:
ME_LngText526 = クリック回数:
ME_LngText527 = ホイールの回転量:
ME_LngText528 = 基点:
ME_LngText529 = スクロール方向:
ME_LngText530 = スクロール量:
ME_LngText531 = ボタンを押したままカーソルを移動させるとスクロールする機能です。
ME_LngText532 = ※この機能はボタンが押されている状態のジェスチャーへ割り当ててください。
ME_LngText533 = 垂直方向のマウス感度:
ME_LngText534 = 水平方向のマウス感度:
ME_LngText535 = (値が小さいほど高感度)
ME_LngText536 = スクロール方向:
ME_LngText537 = スクロール操作:
ME_LngText541 = ウィンドウの左上座標とサイズを指定してください。
ME_LngText542 = ・ 空白のままにした項目は変更されません。
ME_LngText543 = ・「相対値指定」をチェックすると、現在のウィンドウ位置、および`n　ウィンドウサイズに対する増減値の指定となります。
ME_LngText544 = ・「相対値指定」をチェックして分数を指定すると、現在のウィンドウ`n　位置、およびウィンドウサイズに対する比率指定となります。
ME_LngText545 = ・「相対値指定」のチェックを外して分数を指定すると、デスクトップ`n　のサイズに対する比率指定となります。`n　(横幅と高さを「1/1」にしたい場合は、「 0 」を指定してください)
ME_LngText546 = 左座標:
ME_LngText547 = 上座標:
ME_LngText548 = 横幅:
ME_LngText549 = 高さ:
ME_LngText551 = コマンドライン:
ME_LngText552 = 作業フォルダ:
ME_LngText553 = 実行時の大きさ:
ME_LngText554 = 特権レベル:
ME_LngText556 = プログラム (*.exe)
ME_LngText557 = サウンドファイル (*.wav;*.mid)
ME_LngText558 = アイコンファイル (*.ico;*.exe;*.dll;*.cpl;*.icl)
ME_LngText561 = メッセージ:
ME_LngText562 = wParam:
ME_LngText563 = lParam:

; ボタン
ME_LngButton001 = &OK
ME_LngButton002 = キャンセル(&C)
ME_LngButton003 = ヘルプ(&H)
ME_LngButton004 = クリップボードからインポート(&I)
ME_LngButton005 = +
ME_LngButton006 = -
ME_LngButton007 = ↑
ME_LngButton008 = ↓
ME_LngButton009 = S
ME_LngButton010 = C
ME_LngButton011 = F
ME_LngButton012 = ×
ME_LngButton013 = 変更
ME_LngButton014 = 追加
ME_LngButton015 = 更新
ME_LngButton016 = E
ME_LngButton017 = 入力補助
ME_LngButton019 = トリガ操作の追加
ME_LngButton020 = ボタンをどれか一つ放す
ME_LngButton021 = ジェスチャー末尾の`n１ステップを削除
ME_LngButton022 = スタートアップに登録
ME_LngButton023 = スタートアップから削除
ME_LngButton024 = トリガ操作別の矢印色の設定
ME_LngButton025 = 直接編集
ME_LngButton026 = 特殊キー
ME_LngButton027 = 参照...
ME_LngButton028 = アイコン適用

; ドロップダウンリスト
ME_LngDropDown001 = どれかに一致`n全てに一致
ME_LngDropDown002 = ウィンドウクラス`nコントロールクラス`n実行ファイル名`nタイトル`nカスタム条件式`n他のターゲットと一致
ME_LngDropDown003 = 完全一致`n部分一致`n前方一致`n後方一致`n正規表現
ME_LngDropDown004 = ツールチップ`n矢印ナビ1`n矢印ナビ2`nアドバンスドナビ`nリアルナビ
ME_LngDropDown005 = カーソル位置`nスクリーン左上`nスクリーン右上`nスクリーン左下`nスクリーン右下
ME_LngDropDown006 = スクリーン左上`nスクリーン右上`nスクリーン左下`nスクリーン右下`n座標指定
ME_LngDropDown101 = ターゲットウィンドウ内の相対座標`nターゲットコントロール内の相対座標`nスクリーン絶対座標
ME_LngDropDown102 = 左上`n右上`n左下`n右下
ME_LngDropDown103 = ジェスチャー開始座標`nジェスチャー終了座標
ME_LngDropDown201 = 左ボタン`n右ボタン`n中央ボタン`n第4ボタン`n第5ボタン
ME_LngDropDown202 = 通常ストローク`n押し下げ`n押し上げ
ME_LngDropDown203 = クリック`n押し下げ`n押し上げ
ME_LngDropDown204 = ジェスチャー開始座標`nアクション開始座標`n現在のカーソル位置
ME_LngDropDown205 = 上スクロール`n下スクロール`n左スクロール`n右スクロール
ME_LngDropDown206 = カーソルの移動方向へスクロール`nカーソルの移動方向と逆へスクロール
ME_LngDropDown207 = カーソルを移動させた分だけスクロール`nボタンを放すまで自動スクロール
ME_LngDropDown208 = 通常のウィンドウ`n最小化`n最大化`n非表示
ME_LngDropDown209 = ユーザー権限で実行`n管理者権限で実行

; リストビューのカラムタイトル
ME_LngListView001 = 種別`n値
ME_LngListView002 = ジェスチャー`nアクション
ME_LngListView003 = ターゲット`nアクション
ME_LngListView004 = トリガ操作`n矢印の色

; グループBOX
ME_LngGroupBox001 = 認識処理の基本設定
ME_LngGroupBox002 = ジェスチャーの入力とみなされるカーソル移動量
ME_LngGroupBox003 = 斜め移動の認識範囲(角度)
ME_LngGroupBox004 = タイムアウト
ME_LngGroupBox005 = 画面端接触認識
ME_LngGroupBox006 = 拡張マウスボタンの動作
ME_LngGroupBox007 = 共通設定
ME_LngGroupBox008 = 矢印ナビ
ME_LngGroupBox009 = アドバンスドナビ
ME_LngGroupBox010 = 軌跡
ME_LngGroupBox011 = 操作ログ
ME_LngGroupBox012 = ホットキー
ME_LngGroupBox013 = スクリプトの編集に使用するエディタ
ME_LngGroupBox014 = スタートアップ
ME_LngGroupBox016 = その他
ME_LngGroupBox017 = アイコン(&I)
ME_LngGroupBox101 = ホイールの回転方向

; チェックBOX
ME_LngCheckBox001 = 不一致
ME_LngCheckBox002 = 親ターゲットの条件を継承しない
ME_LngCheckBox003 = 8方向モード
ME_LngCheckBox004 = アクティブウィンドウをターゲットにする
ME_LngCheckBox005 = ディスプレイごとに領域を分割する
ME_LngCheckBox006 = 中央ボタンのデフォルト動作を無効化する
ME_LngCheckBox007 = 第4ボタンのデフォルト動作を無効化する
ME_LngCheckBox008 = 第5ボタンのデフォルト動作を無効化する
ME_LngCheckBox009 = 起動時からナビを有効化する
ME_LngCheckBox010 = 背景を透過させる
ME_LngCheckBox011 = トリガボタンの押下時からナビを表示
ME_LngCheckBox012 = ジェスチャーの軌跡を表示する
ME_LngCheckBox013 = ジェスチャー操作のログを表示する
ME_LngCheckBox014 = 軌跡をオーバーラップウィンドウに描画する
ME_LngCheckBox015 = トレイメニューをサブメニュー化する
ME_LngCheckBox016 = ダイアログBOXの高さをアイテムの登録数に合わせて調節する
ME_LngCheckBox101 = Shift
ME_LngCheckBox102 = Ctrl
ME_LngCheckBox103 = Alt
ME_LngCheckBox110 = 絶対座標
ME_LngCheckBox111 = ページスクロール
ME_LngCheckBox112 = 相対値指定

; ラジオボタン
ME_LngRadioBtn001 = ↑回転
ME_LngRadioBtn002 = ↓回転

; メッセージ
ME_LngMessage001 = 「[#REPLASE#]」
ME_LngMessage002 = 、
ME_LngMessage003 = にはジェスチャー[#REPLASE#]が割り当てられています。`n
ME_LngMessage004 = はターゲット[#REPLASE#]に含まれています。`n
ME_LngMessage005 = `n削除してよろしいですか？
ME_LngMessage006 = このジェスチャーにはアクションが割り当てられています。`n削除してよろしいですか？
ME_LngMessage007 = 既に同じ名前のボタンがあります。
ME_LngMessage008 = 登録済みのジェスチャーを[#REPLASE#]方向モードに変換しますか？
ME_LngMessage009 = `n`n※斜め方向への移動操作は削除されます
ME_LngMessage010 = スタートアップ時に管理者権限で起動しますか？
ME_LngMessage011 = スタートアップに登録しました。
ME_LngMessage012 = スタートアップから削除しました。
ME_LngMessage101 = アプリケーションのメニューバー内の項目を選択します。`n`n　・メニュー項目は「 , 」区切りで、最大6階層辿った先まで指定できます。`n　・対応できないアプリケーションもあります。`n`n　　【例】編集,コピー`n`nメニューの項目名を指定してください:
ME_LngMessage102 = 起動するプログラムやファイル、URLなどを指定してください。
ME_LngMessage104 = 不透明度を指定してください。`n`n　　0(透明) ～ 255(不透明)
ME_LngMessage105 = 以下の何れかを指定してください。`n`n    0 ～ 100`t: 音量を直接指定`n   +1 ～ +100`t: 音量の増加量を指定`n   -1 ～ -100`t: 音量の減少量を指定
ME_LngMessage106 = 以下の何れかを指定してください。`n`n     1 : ミュートON`n     0 : ミュートOFF`n     + : ミュートON/OFFの切り替え
ME_LngMessage107 = 再生するサウンドファイルのパス名を指定してください。`n`n・OSがサポートしていない形式のサウンドファイルは再生できません。
ME_LngMessage108 = 一度ボタンが放された後、タイムアウトするまでは、次のボタン押し`n下げ操作を同ジェスチャーの続きとして受け付けるようにします。`n`n　・この処理はボタンを放した時のアクションに割り当ててください。`n`n　【例】右ダブルクリック`n　　1. RB__のアクションにこの処理を割り当てる`n　　2. RB__RB__のアクションに右ダブルクリック時の動作を割り当てる`n`nタイムアウト値(ミリ秒)を指定してください:
ME_LngMessage109 = 指定された時間だけスクリプトの実行を停止し、待ち時間が経過`nした後に続きを実行します。`n`n　・時間待ちの間はジェスチャーを受け付けなくなります。`n　　長い時間を待つ場合は「ジェスチャーの認識終了後に実行」`n　　を利用してください。`n`n待ち時間(ミリ秒)を指定してください:
ME_LngMessage110 = ジェスチャーの入力後、指定された時間が経過してから処理を実行します。`n`n　・ボタン押し下げ操作のアクションに割り当てることで、ボタン長押し時`n　　の動作を割り当てられます。`n　・シングルクリックのアクションを、ダブルクリックしなかったときにだけ実行`n　　させることができます。`n`n　【例】中央ボタンのダブルクリック時に、シングルクリックへの割り当て`n　　　　動作が発動しないようにする`n　　1. MB__のアクションにこの処理を割り当て、「 else { 」の下に`n　　　 シングルクリック時の動作を記述する`n　　2. MB__MB__のアクションにダブルクリック時の動作を割り当てる`n`n待ち時間(ミリ秒)を指定してください:
ME_LngMessage111 = ジェスチャーの入力後、指定された時間が経過してから`nボタンを放した時点で処理を実行します。`n`n　・この処理はボタンが押されている状態のジェスチャーへ`n　　割り当ててください。`n`n待ち時間(ミリ秒)を指定してください:
ME_LngMessage112 = ボタンが放されるまで、指定間隔で処理を繰り返します。`n`n　・この処理はボタンが押されている状態のジェスチャーへ`n　　割り当ててください。`n`n繰り返し間隔(ミリ秒)を指定してください:
ME_LngMessage113 = ジェスチャーの認識処理が完了した後で処理を実行します。`n`n　・この処理は割り当てアクションの中でメッセージBOXを`n　　表示させるなど、スクリプトの流れが長時間停止する`n　　場合に利用します。`n
ME_LngMessage114 = 指定された文字列をツールチップナビに表示します。`n`n　・この機能はボタンが押されている状態のジェスチャーへ`n　　割り当ててください。`n　・ツールチップナビが無効になっている場合は機能しません。`n　・複数行の文字列を表示する場合は、OKボタンを押して`n　　から(　)内の文字列を編集してください。`n`n表示させる文字列を入力してください:
ME_LngMessage115 = 指定された文字列をクリップボードにセットします。`n`n　・タブは``t、 改行は``nです。`n　・複数行の文字列をコピーする場合は、OKボタンを押して`n　　から(　)内の文字列を編集してください。`n`nコピーする文字列を入力してください:
ME_LngMessage116 = キー操作を表す文字列を入力してください。`n`n　　【書式】　+^!#{キー名}	+ :Shift	　^ :Ctrl`n				! :Alt	　# :Windowsキー`n`n　・単一文字のキーは{ }で囲まなくてもOKです。`n　・単一の大文字はShiftキーとの同時押しと解釈されます。`n　・{キー名 Down}でキーの押し下げのみ、{キー名 Up}で押し上げのみとなります。`n　・マウスのクリックはボタンごとにそれぞれ、{LButton}、{RButton}、{MButton}、`n　　{XButton1}、{XButton2}と記述します。`n　・複数のキーを連続指定することで、連続したキー操作を発生させることができます。

; ツールチップ
ME_LngTooltip001 = 「[#REPLASE#]」をクリップボードへコピーしました。
ME_LngTooltip002 = 設定をインポートしました。
ME_LngTooltip003 = 取得したいウィンドウを右クリック
ME_LngTooltip004 = 対象ボタンを右クリック
ME_LngTooltip005 = ドラッグして領域を選択

; フォント
ME_AdNaviFont	 = メイリオ
ME_ScriptFont	 = ＭＳ ゴシック
ME_ScriptSize	 =
ME_ArrowFont	 =
ME_ArrowSize	 =
ME_ArrowAlignUp	 =
ME_ArrowAlignDn	 =

; その他文字列
ME_LngOthers001	 = デフォルト
ME_LngOthers002	 = ターゲット
ME_LngOthers003	 = なし
ME_LngOthers004	 = 
ME_LngOthers005	 = 部分一致
ME_LngOthers006	 = 前方一致
ME_LngOthers007	 = 後方一致
ME_LngOthers008	 = 正規表現
ME_LngOthers009	 = 不一致
ME_LngOthers010	 = 部分不一致
ME_LngOthers011	 = 前方不一致
ME_LngOthers012	 = 後方不一致
ME_LngOthers013	 = 正規表現不一致

;-------------------------------------------------------------------------------
EndLanguage:
	MG_Language := RegExReplace(A_LineFile, "m)^.+\\|\.ahk$")

