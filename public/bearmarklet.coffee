h = "https://dev-engelbaerchen.parseapp.com/add_bearmark?url=#{encodeURIComponent location.href}&title=#{encodeURIComponent document.title}"
#Hack: ladezeit für javascript + ziel laden zu lang, durch confirm 2 kürzere loads
if confirm """
    Bookmark hinzufügen? ziel "dev-engelbaerchen" title "#{document.title}" url "#{location.href}" 
    """
    location.href= h

