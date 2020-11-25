module UsersHelper
 
# def degree(level)
#  num = level.to_i
#  case num
#  when 777..1000
#   return "覇者"
#  when 666..776
#   return "神童"
#  when 555..665
#   return "10年に1人の逸材"
#   when 444..554
#   return "スーパーエリート"
#   when 333..443
#   return "キムタク"
#   when 222..332
#   return "不撓不屈"
#   when 111..221
#   return "達人"
#   when 99..110
#   return "敏腕会社員"
#   when 77..98
#   return "勝ち組"
#   when 55..76
#   return "意思が強い人"
#   when 33..54
#   return "頑張り屋"
#   when 22..32
#   return "見習い"
#   when 11..21
#   return "修行中"
#   when 1..10
#   return "負け犬"
#   when 0..1
#   return "赤子"
#   end
#   if num < 0
#    return "怠惰"
#   end
# end

def current_user?(user)
   current_user == user
end

end
