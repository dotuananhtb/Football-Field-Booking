(function ($) {
  /* "use strict" */

  var tfLineChart = (function () {

    var chartBar1 = function () {
      var options5 = {
        chart: {
          height: 500,
          type: "area",
          zoom: {
            enabled: false
          },
          toolbar: {
            show: false,
          },
        },
        dataLabels: {
          enabled: false
        },
        series: [
          {
            name: "$",
            data: [45, 52, 38, 45, 49, 43, 40, 45, 52, 38, 45, 19]
          }
        ],
        fill: {
          type: "gradient",
          gradient: {
            shadeIntensity: 1,
            opacityFrom: 0.3,
            opacityTo: 0.9,
            stops: [0, 90, 100]
          }
        },
        xaxis: {
          categories: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ]
        }
      };
      chart5 = new ApexCharts(
        document.querySelector("#line-chart-1"),
        options5
      );
      if ($("#line-chart-1").length > 0) {
        chart5.render();
      }
    };

    /* Function ============ */
    return {
      init: function () { },

      load: function () {
        chartBar1();
      },
      resize: function () { },
    };
  })();

  jQuery(document).ready(function () { });

  jQuery(window).on("load", function () {
    tfLineChart.load();
  });

  jQuery(window).on("resize", function () { });

})(jQuery);