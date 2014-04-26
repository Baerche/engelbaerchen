s = "https://engelbaerchen.parseapp.com/add_bearmark?url=#{encodeURIComponent location.href}&title=#{encodeURIComponent document.title}"
console.log s
location.href=s

