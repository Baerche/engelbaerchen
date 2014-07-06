Parse.Cloud.define "debug", (req, res) ->
  res.success req

Parse.Cloud.define "debugFail", (req, res) ->
  res.error "Ok. Also nicht :-)"
