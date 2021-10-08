winget export --output win\winget_packages.json

# NOTE: タスクバーのレイアウトを保存
# 新規ユーザーの場合のみ適用可能なのでバックアップのみ
Export-StartLayout -Path '.\win\start_layout.xml'


