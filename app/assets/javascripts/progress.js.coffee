bar = document.getElementById("myProgress")

setProgress = (percent) ->
  bar.style.width = percent + "%"
  if percent > 90
    bar.className = ".bar.bar-danger"
  else if percent > 60
    bar.className = ".bar.bar-warning"
  else bar.className = ".bar.bar-success"  

