$(function(){
    var chart = $("#schoolChart");
    if(chart.length){
        var ctx = document.getElementById("schoolChart").getContext("2d");
        var data = [
            {
                    value : 30,
                    color: "green"
            },
            {
                    value : 70,
                    color: "orange"
            }
        ];
        var myNewChart = new Chart(ctx).Pie(data);
    }
});