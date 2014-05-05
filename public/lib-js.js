// http://stackoverflow.com/a/16862272
lib.isContentEditable = function () {
    var canEditContent = 'contentEditable' in document.body;
    if (canEditContent) {
        var webkit = navigator.userAgent.match(/(?:iPad|iPhone|Android).* AppleWebKit\/([^ ]+)/);
        if (webkit && parseInt(webkit[1]) < 534) {
            return false;
        }
    }
    return canEditContent;
}
