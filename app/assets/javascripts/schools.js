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
                    value : verb,
                    color: "burlywood"
            },
            {
                    value : online,
                    color: "green"
            },
            {
                    value : oth,
                    color: "grey"
            }
        ];
        var myNewChart = new Chart(ctx).Pie(data);
    }
});