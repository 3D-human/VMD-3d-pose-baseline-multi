@echo off
rem --- 
rem ---  3D の 関節データから vmdデータに変換
rem --- 

rem ---  カレントディレクトリを実行先に変更
cd /d %~dp0

rem ---  3d-pose-baseline-vmd解析結果JSONディレクトリパス
echo 3d-pose-baseline-vmdの解析結果ディレクトリの絶対パスを入力して下さい。(3d_{実行日時}_idx00)
echo この設定は半角英数字のみ設定可能で、必須項目です。
set TARGET_DIR=
set /P TARGET_DIR=■3D解析結果ディレクトリパス: 
rem echo TARGET_DIR：%TARGET_DIR%

IF /I "%TARGET_DIR%" EQU "" (
    ECHO 3D解析結果ディレクトリパスが設定されていないため、処理を中断します。
    EXIT /B
)

rem ---  ボーン構造CSVファイル
echo --------------
set MODEL_BONE_CSV=born\あにまさ式ミクボーン.csv
echo トレース対象モデルのボーン構造CSVファイルの相対もしくは絶対パスを入力して下さい。
echo 何も入力せず、ENTERを押下した場合、「%MODEL_BONE_CSV%」のファイルを読み込みます。
set /P MODEL_BONE_CSV="ボーン構造CSVファイル: "

rem ---  直立姿勢フレーム番号
echo --------------
set UPRIGHT_FRAME_IDX=1
echo できるだけ人物が正面向きで直立しているフレームのINDEX(1始まり)を入力して下さい。
echo 特に首と両足付け根の三角が正面判定の基準となります。
echo 指定されたフレームの人物の位置がMMDのセンターとなります。
echo 何も入力せず、ENTERを押下した場合、%UPRIGHT_FRAME_IDX%フレーム目を直立として処理します。
set /P UPRIGHT_FRAME_IDX="直立姿勢フレームINDEX: "

rem ---  センターXY移動倍率
echo --------------
set CENTER_XY_SCALE=30
echo センターXY移動に掛ける倍率を整数で入力して下さい。
echo 値が小さいほど、センターXY移動の幅が小さくなります。
echo 何も入力せず、ENTERを押下した場合、倍率「%CENTER_XY_SCALE%」で処理します。
set /P CENTER_XY_SCALE="センターXY移動倍率: "

rem ---  センターZ移動倍率
echo --------------
set CENTER_Z_SCALE=8
echo センターZ移動に掛ける倍率を数値(小数可)で入力して下さい。
echo 値が小さいほど、センターZ移動の幅が小さくなります。
echo 目安として、カメラからの距離が近いほど、倍率を小さくした方がいいです。
echo 何も入力せず、ENTERを押下した場合、倍率「%CENTER_Z_SCALE%」で処理します。
set /P CENTER_Z_SCALE="センターZ移動倍率: "

rem ---  グローバルX軸角度補正

echo --------------
set GROBAL_X_ANGLE=16
echo 3D化した際にグローバルX軸に若干傾くのを補正します
echo 0〜360度の整数のみを入力して下さい。
echo 何も入力せず、ENTERを押下した場合、%GROBAL_X_ANGLE%度回転します。
set /P GROBAL_X_ANGLE="グローバルX軸角度補正: "

rem ---  センター移動間引き量

echo --------------
set CENTER_DECIMATION_MOVE=0.5
echo センターキーの間引きに使用する移動量を数値(小数可)で指定します
echo 指定された範囲内の移動があった場合に間引きされます。
echo 何も入力せず、ENTERを押下した場合、「%CENTER_DECIMATION_MOVE%」の移動量で間引きます。
set /P CENTER_DECIMATION_MOVE="センター移動間引き量: "

rem ---  IK移動間引き量

echo --------------
set IK_DECIMATION_MOVE=1.5
echo IKキーの間引きに使用する移動量を数値(小数可)で指定します
echo 指定された範囲内の移動があった場合に間引きされます。
echo 何も入力せず、ENTERを押下した場合、「%IK_DECIMATION_MOVE%」の移動量で間引きます。
set /P IK_DECIMATION_MOVE="IK移動間引き量: "

rem ---  同軸間引き角度

echo --------------
set SAME_DECIMATION_ANGLE=15
echo 回転キーの間引きに使用する角度を指定します
echo 同じ軸(X軸方向への回転が続く場合等)に指定された角度以内の回転があった場合に間引きされます。
echo 0〜360度の整数のみを入力して下さい。
echo 何も入力せず、ENTERを押下した場合、%SAME_DECIMATION_ANGLE%度間引きます。
set /P SAME_DECIMATION_ANGLE="同軸間引き角度: "

rem ---  異軸間引き角度

echo --------------
set DIFF_DECIMATION_ANGLE=3
echo 回転キーの間引きに使用する角度を指定します
echo 違うじ軸(X軸方向への回転からZ軸方向に回転した場合等)に指定された角度以内の回転があった場合に間引きされます。
echo 0〜360度の整数のみを入力して下さい。
echo 何も入力せず、ENTERを押下した場合、%DIFF_DECIMATION_ANGLE%度間引きます。
set /P DIFF_DECIMATION_ANGLE="異軸間引き角度: "


rem ---  詳細ログ有無

echo --------------
echo 詳細なログを出すか、yes か no を入力して下さい。
echo 何も入力せず、ENTERを押下した場合、通常ログのみ出力します。
set VERBOSE=2
set IS_DEBUG=no
set /P IS_DEBUG="詳細ログ[yes/no]: "

IF /I "%IS_DEBUG%" EQU "yes" (
    set VERBOSE=3
)



rem ---  python 実行
python applications\pos2vmd_multi.py -v %VERBOSE% -t %TARGET_DIR% -b %MODEL_BONE_CSV% -u %UPRIGHT_FRAME_IDX% -c %CENTER_XY_SCALE% -z %CENTER_Z_SCALE% -x %GROBAL_X_ANGLE% -m %CENTER_DECIMATION_MOVE% -i %IK_DECIMATION_MOVE% -s %SAME_DECIMATION_ANGLE% -d %DIFF_DECIMATION_ANGLE%

