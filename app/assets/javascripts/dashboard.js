$(document).ready(function(){
    
    var data = [
    {
        value: 300,
        color:"#4d46f7",
        highlight: "#4431d6",
        label: "Loterias Sin Ganador"
    },
    {
        value: 50,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Loterias Con Ganador"
    }
   
];
    var ctx = document.getElementById("myChart").getContext("2d");
    var myPieChart = new Chart(ctx).Pie(data);
});