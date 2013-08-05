@TitleHelper =
  updateCount: (count) ->
    titleParts = $('title').text().split ' | '
    lastTitle = titleParts.pop().replace(/\s*\(.*\)\s*/, '')
    lastTitle = "(#{count}) #{lastTitle}" if count > 0

    titleParts.push lastTitle

    $('title').text titleParts.join(' | ')

