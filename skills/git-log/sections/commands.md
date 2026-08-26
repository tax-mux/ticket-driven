# ログコマンド例

## 基本

### 直近10コミット

```
git log -10
```

### 簡易表示

```
git log --oneline -10
```

### 一覧表示

```
git log --oneline --graph --all
```

## 条件指定

### 日付指定

```
git log --since="2026-01-01" --until="2026-07-28"
```

### 変更者指定

```
git log --author="{名前}"
```

### ファイル指定

```
git log -- {ファイルパス}
```

### コミットメッセージ検索

```
git log --grep="{キーワード}"
```

## 詳細表示

### 変更内容付き

```
git log -p -5
```

### ファイル統計

```
git log --stat -5
```

### 変更量

```
git log --shortstat -5
```
