$.get('/stats?range=3days', function(res) {
  var graph3days = new Chart(document.getElementById('graph-3days').getContext('2d')).Pie(res.statistics)
});

$.get('/stats?range=1week', function(res) {
  var graph3days = new Chart(document.getElementById('graph-1week').getContext('2d')).Pie(res.statistics)
});

$.get('/stats?range=2weeks', function(res) {
  var graph3days = new Chart(document.getElementById('graph-2weeks').getContext('2d')).Pie(res.statistics)
});

var options = {
scaleOverlay : true,
scaleOverride : true,
scaleSteps : 10,
scaleStepWidth : 10,
scaleStartValue : 10,
scaleLineColor : "rgba(0,0,0,.1)",
scaleLineWidth : 1,
scaleShowLabels : true,
scaleLabel : "<%=value%> point",
scaleFontFamily : "'Arial'",
scaleFontSize : 12,
scaleFontStyle : "normal",
scaleFontColor : "#666",    
scaleShowGridLines : true,
scaleGridLineColor : "rgba(0,0,0,.05)",
scaleGridLineWidth : 1,    
bezierCurve : false,
pointDot : true,
pointDotRadius : 2,
pointDotStrokeWidth : 1,
datasetStroke : true,
datasetStrokeWidth : 10,
datasetFill : true,
animation : true,
animationSteps : 60,
animationEasing : "easeOutQuart",
onAnimationComplete : function(){console.log('complete');}
}

$.get('/displacement', function(res) {
  var graphasahi = new Chart(document.getElementById('graph-asahi').
  getContext('2d')).Line(res)
});