$(function(){
    var chart = $("#schoolChart");
    if(chart.length){
        var ctx = document.getElementById("schoolChart").getContext("2d");
        var data = [
            {
                    value : phy,
                    color: "blue"
            },
            {
                    value : emo,
                    color: "burlywood"
            }
        ];
        var myNewChart = new Chart(ctx).Pie(data);
    }
});