require 'nokogiri'
boss_array = []
hrefs = []
hacker_news = Nokogiri::HTML(open('https://news.ycombinator.com/'))
hacker_news.css('td .title').each do |title|
  boss_array << title.content
end
boss_array.each_with_index.map {|x,y| x if y.odd?}.compact.each do |title|
  Post.create(:title => title)
end


hacker_news.css('td .title a').each do |post|
  hrefs << post.attributes["href"].value
end

p hrefs

Post.all.each_with_index do |post,index|
  post.url = hrefs[index]
  post.save
end
