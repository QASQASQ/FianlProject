'use strict';
const now = new Date();
let month = [];
for(let i=0; i<12; i++){
	month[i] = ((now.getMonth() - i + 12) % 12) + 1 + "월";
}

$(document).ready(function () {
	
$.ajax({
	url : "/hrms/admin/getChartsData",
	type : "post",
	success : function(res)	{
		console.log(res);
		let late = res.lateMap;
		let emplCount = res.emplCount;
		let deptSal = res.deptSal;
		let recruitCount = res.recruitCount;
		let appCount = res.appCount;
		let yearsOfService = res.yearsOfService;
		let vacation = res.vacation;
		
		function generateData(baseval, count, yrange) {
		  var i = 0;
		  var series = [];
		  while (i < count) {
		    var x = Math.floor(Math.random() * (750 - 1 + 1)) + 1;;
		    var y = Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;
		    var z = Math.floor(Math.random() * (75 - 15 + 1)) + 15;
		
		    series.push([x, y, z]);
		    baseval += 86400000;
		    i++;
		  }
		  return series;
		}

	// 미사용 연차
	if ($('#radial-chart').length > 0) {
	    var radialChart = {
	      chart: {
	        height: 350,
	        type: 'radialBar',
	        toolbar: {
	          show: false,
	        }
	      },
	      // colors: ['#4361ee', '#888ea8', '#e3e4eb', '#d3d3d3'],
	      plotOptions: {
	        radialBar: {
	          dataLabels: {
	            name: {
	              fontSize: '22px',
	            },
	            value: {
	              fontSize: '16px',
	            },
	            total: {
	              show: true,
	              label: '합계',
	              formatter: function (w) {
	                return vacation['TOTAL'] + '%';
	              }
	            }
	          }
	        }
	      },
	      series: [vacation['USAGE'], vacation['REMAIN'], vacation['TOTAL']],
	      labels: ['사용 연차', '미사용 연차', '합계'],
	    }
	
	    var chart = new ApexCharts(
	      document.querySelector("#radial-chart"),
	      radialChart
	    );
	
	    chart.render();
	  }
		
		
  // 지난1년동안의 월별지각횟수
  if ($('#s-line').length > 0) {
    var sline = {
      chart: {
        height: 350,
        type: 'line',
        zoom: {
          enabled: false
        },
        toolbar: {
          show: false,
        }
      },
      colors: ['#F26522'],
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'straight'
      },
      series: [{
        name: "지각횟수",
        data: [late['LATE11'], late['LATE10'], late['LATE9'], late['LATE8'], late['LATE7'], late['LATE6'], late['LATE5'], late['LATE4'], late['LATE3'], late['LATE2'], late['LATE1'], late['LATE0']]
      }],
      grid: {
        row: {
          colors: ['#f1f2f3', 'transparent'], // takes an array which will be repeated on columns
          opacity: 0.5
        },
      },
      xaxis: {
        categories: [month[11], month[10], month[9], month[8], month[7], month[6], month[5], month[4], month[3], month[2], month[1], month[0]],
      }
    }

    var chart = new ApexCharts(
      document.querySelector("#s-line"),
      sline
    );

    chart.render();
  }
  
  // 부서별 인원수
  if ($('#donut-chart').length > 0) {
    var donutChart = {
      chart: {
        height: 350,
        type: 'donut',
        toolbar: {
          show: false,
        }
      },
      // colors: ['#4361ee', '#888ea8', '#e3e4eb', '#d3d3d3'],
      series: [emplCount['01'],emplCount['02'],emplCount['03'],emplCount['04'],emplCount['05']],
	  labels: ['경영 인사', '마케팅', '연구 개발', '운영', '재무 회계'],
      responsive: [{
        breakpoint: 480,
        options: {
          chart: {
            width: 200
          },
          legend: {
            position: 'bottom'
          }
        }
      }]
    }

    var donut = new ApexCharts(
      document.querySelector("#donut-chart"),
      donutChart
    );

    donut.render();
  }
  
  // 부서별 기본급, 실수령 평균
    if ($('#s-col').length > 0) {
      var sCol = {
        chart: {
          height: 350,
          type: 'bar',
          toolbar: {
            show: false,
          }
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          },
        },
        colors: ['#F26522', '#4361ee'],
        dataLabels: {
          enabled: false
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        series: [{
          name: '기본급 평균',
          data: [deptSal['PERSONELL'], deptSal['MARKETING'], deptSal['DEVELOPE'], deptSal['OPERATION'], deptSal['ACCOUNT']]
        }],
        xaxis: {
          categories: ['경영 인사', '마케팅', '연구 개발', '운영', '재무 회계'],
        },
        yaxis: {
          title: {
            text: '\ (만원)'
          }
        },
        fill: {
          opacity: 1

        },
        tooltip: {
          y: {
            formatter: function (val) {
              return "\ " + val + " 만원"
            }
          }
        }
      }

      var chart = new ApexCharts(
        document.querySelector("#s-col"),
        sCol
      );

      chart.render();
    }
	
	// 채용공고수와 지원자 수
	if ($('#s-col2').length > 0) {
	    var sCol = {
	      chart: {
	        height: 350,
	        type: 'bar',
	        toolbar: {
	          show: false,
	        }
	      },
	      plotOptions: {
	        bar: {
	          horizontal: false,
	          columnWidth: '55%',
	          endingShape: 'rounded'
	        },
	      },
	      colors: ['#F26522', '#4361ee', '#28a745'],
	      dataLabels: {
	        enabled: false
	      },
	      stroke: {
	        show: true,
	        width: 2,
	        colors: ['transparent']
	      },
	      series: [{
	        name: '게시한 채용공고 수',
	        data: [recruitCount['PERSONELL'], recruitCount['MARKETING'], recruitCount['DEVELOPE'], recruitCount['OPERATION'], recruitCount['ACCOUNT']]
	      }, {
	        name: '지원자 수',
	        data: [appCount['PERSONELL'], appCount['MARKETING'], appCount['DEVELOPE'], appCount['OPERATION'], appCount['ACCOUNT']]
	      }, {
	        name: '채용공고 한개당 지원자 수',
	        data: [(appCount['PERSONELL']/recruitCount['PERSONELL']).toFixed(1), (appCount['MARKETING']/recruitCount['MARKETING']).toFixed(1), (appCount['DEVELOPE']/recruitCount['DEVELOPE']).toFixed(1), (appCount['OPERATION']/recruitCount['OPERATION']).toFixed(1), (appCount['ACCOUNT']/recruitCount['ACCOUNT']).toFixed(1)]
	      }],
	      xaxis: {
	        categories: ['경영 인사', '마케팅', '연구 개발', '운영', '재무 회계'],
	      },
	      yaxis: {
	        title: {
	          text: '$ (thousands)'
	        }
	      },
	      fill: {
	        opacity: 1

	      },
	      tooltip: {
	        y: {
	          formatter: function (val) {
	            return val + " 건"
	          }
	        }
	      }
	    }

	    var chart = new ApexCharts(
	      document.querySelector("#s-col2"),
	      sCol
	    );

	    chart.render();
	  }
	
  // 부서별 평균 근속연수
  if ($('#s-col3').length > 0) {
		var sCol = {
	       chart: {
	         height: 350,
	         type: 'bar',
	         toolbar: {
	           show: false,
	         }
	       },
	       plotOptions: {
	         bar: {
	           horizontal: false,
	           columnWidth: '55%',
	           endingShape: 'rounded'
	         },
	       },
	       colors: ['#F26522', '#4361ee'],
	       dataLabels: {
	         enabled: false
	       },
	       stroke: {
	         show: true,
	         width: 2,
	         colors: ['transparent']
	       },
	       series: [{
	         name: '부서별 평균 근속연수',
	         data: [yearsOfService['01'], yearsOfService['02'],yearsOfService['03'],yearsOfService['04'],yearsOfService['05']]
	       }],
	       xaxis: {
	         categories: ['경영 인사', '마케팅', '연구 개발', '운영', '재무 회계'],
	       },
	       yaxis: {
	         title: {
	           text: '\ (년)'
	         }
	       },
	       fill: {
	         opacity: 1

	       },
	       tooltip: {
	         y: {
	           formatter: function (val) {
	             return "\ " + val + " 년"
	           }
	         }
	       }
	     }

	     var chart = new ApexCharts(
	       document.querySelector("#s-col3"),
	       sCol
	     );

	     chart.render();
  }

		},
		error : function(error){
			console.log(error);
		}
	});
});
