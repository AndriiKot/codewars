﻿require 'net/http'
require 'json'

url = URI.parse('https://www.codewars.com/api/v1/users/AndriiKot')
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = (url.scheme == 'https')

request = Net::HTTP::Get.new(url.request_uri)

response = http.request(request)

if response.code == '200'
  res = response.body

  data = JSON.parse(res)
  
  user_name = data['username']
  overall_kyu = data['ranks']['overall']['name']
  honor = data['honor']
  position = data['leaderboardPosition']
  score = data['ranks']['overall']['score']
  total = data['codeChallenges']['totalCompleted']
  
  template = "# #{user_name}\n"

  hash_languages = data["ranks"]["languages"]
  hash_convert = { 'sql' => 'SQL', 'javascript' => 'JavaScript', }

  kyu_7, kyu_8 = "./kyu-7/", "./kyu-8/"
  folders_count_7 = Dir.glob("#{kyu_7}/*").count
  folders_count_8 = Dir.glob("#{kyu_8}/*").count

  hash_languages.each do |key, value|
    if key == 'sql'
    template += <<~EOF  
    ## #{hash_convert[key]}
    #### SQL rank: #{value['name']}
    #### SQL score: #{value['score']}
    ##### 7-kyu: #{folders_count_7}
    ##### 8-kyu: #{folders_count_8}
    EOF
    end
  end

end

  File.open('./README.md', 'w+') do |f|
    f.puts(template)
  end


