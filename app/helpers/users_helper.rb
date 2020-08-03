module UsersHelper
  def gender_view(type)
  case type
  when 1
      "男"
    when 2
      "女"
    when 3
      "その他"
    else
      puts "非表示"
  end
  end
end
