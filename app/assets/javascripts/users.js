var MouseoverAttribtues = function() {
  var circle = d3.select(this);
  circle.transition().duration(500)
    .attr("r", circle.attr("r") * 1 + 10 )
    .style('opacity', 1);
  }
    
var MouseoutAttribtues = function() {
  var circle = d3.select(this);
  circle.transition().duration(500)
    .attr("r", circle.attr("r") * 1 - 10 )
    .style('opacity', .5);
}