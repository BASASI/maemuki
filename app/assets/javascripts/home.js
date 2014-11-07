$(function() {
  var $graph3days = $('#graph-3days');
  var $graph1week = $('#graph-1week');
  var $graph2weeks = $('#graph-2weeks');
  var $graphDisplacement = $('#graph-displacement');

  $.each([$graph3days, $graph1week, $graph2weeks], function(i, $graph) {
    if ($graph.is('*')) {
      $.get($graph.data('url'), function(res) {
          new Chart($graph[0].getContext('2d')).Pie(res.statistics);
      });
    }
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

  if ($graphDisplacement.is('*')) {
    $.get($graphDisplacement.data('url'), function(res) {
      new Chart($graphDisplacement[0].getContext('2d')).Line(res)
    });
  }
});
