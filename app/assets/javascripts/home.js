$.get('/stats?range=3days', function(res) {
  var graph3days = new Chart(document.getElementById('graph-3days').getContext('2d')).Pie(res.statistics)
});

$.get('/stats?range=1week', function(res) {
  var graph3days = new Chart(document.getElementById('graph-1week').getContext('2d')).Pie(res.statistics)
});

$.get('/stats?range=2weeks', function(res) {
  var graph3days = new Chart(document.getElementById('graph-2weeks').getContext('2d')).Pie(res.statistics)
});