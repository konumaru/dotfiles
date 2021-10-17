winget export --output \etc\windows\winget_packages.json

# NOTE: タスクバーのレイアウトを保存
# 新規ユーザーの場合のみ適用可能なのでバックアップのみ
Export-StartLayout -Path '.\etc\windows\start_layout.xml'


