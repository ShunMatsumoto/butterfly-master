json.array! @messages do |message|   # メッセージは複数ある可能性があるので配列形式でarray!メソッドを使用
  json.content message.content
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name message.user.name
  json.id message.id
end