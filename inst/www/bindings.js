(function() {

google.setOnLoadCallback(function() {
  window.isGoogleLoaded = true;
  $(document).trigger('googleLoaded');
});

function toDataTable(data) {
  if (data === null)
    return null;

  var cols = data.cols;
  var df = data.data;
  
  var colnames = [];
  for (var i = 0; i < cols.length; i++) {
    colnames.push(cols[i].id);

    if (cols[i].type === "date" || cols[i].type === "datetime") {
      df[cols[i].id] = $.map(df[cols[i].id], function(datum, i) {
        return new Date(datum);
      });
    } else if (cols[i].type === "timeofday") {
      df[cols[i].id] = $.map(df[cols[i].id], function(datum, i) {
        return toTimeOfDay(datum);
      });
    }
  }
  
  return new google.visualization.DataTable({
    cols: cols,
    rows: dataFrameToRows(df, colnames)
  });
}

function toTimeOfDay(timeStr) {
  var match = /^(\d{2}):(\d{2}):(\d{2})(\.(\d{1,3}))?$/.exec(timeStr);
  if (!match) {
    console.log("Invalid timeofday value (hh:mm:ss.fff expected): " + timeStr);
    return null;
  }
  var hours = parseInt(match[1]);
  var mins = parseInt(match[2]);
  var secs = parseInt(match[3]);
  var millis = parseInt(match[5] || 0);
  return [hours, mins, secs, millis];
}

// Google Charts always require data to be in their DataTable class.
// (This will need to become much more customizable.)
function dataFrameToRows(data, columns) {
  if (columns.length == 0)
    return [];
  var rows = [];
  for (var i = 0; i < data[columns[0]].length; i++) {
    var row = {};
    row.c = [];
    for (var j = 0; j < columns.length; j++) {
      row.c.push({v: data[columns[j]][i]});
    }
    rows.push(row);
  }
  return rows;
}

// Execute the given function, but wait for Google to load first if
// it hasn't already.
function waitForGoogleLoad(func) {
  if (window.isGoogleLoaded) {
    setTimeout(func, 1);
  } else {
    $(document).one('googleLoaded', func);
  }
}

var pendingSelection = {};

// Create or update the Google chart on the el, as directed by
// the dataObj.
function constructGoogleChart(el, name, data, options, Chart) {
  var $el = $(el);
  var chart = $el.data('googleChart');
  if (!chart) {
    if (!data)
      return;
    chart = new Chart(el);
    $el.data('googleChart', chart);
    chart.options = JSON.parse($el.children('script').text());
    google.visualization.events.addListener(chart, 'select', function() {
      var value = null;
      var selection = chart.getSelection();
      if (selection && selection.length > 0) {
        value = selection;
      }
      var update = {};
      update[name + '_selection'] = value;
      Shiny.onInputChange(name + '_selection', value);
    });
  }
  
  if (data) {
    var currentOptions = $.extend(true, chart.options, options);
    chart.draw(data, currentOptions);
    if (pendingSelection[name]) {
      chart.setSelection(pendingSelection[name]);
    }
  } else {
    chart.clearChart();
  }
  delete pendingSelection[name];
  chart.data = data;
}

function createBinding(chartName, chartType) {
  var binding = new Shiny.OutputBinding();
  $.extend(binding, {
    find: function(scope) {
      return $(scope).find('.shiny-google-' + chartName + '-output');
    },
    renderValue: function(el, dataObj) {
      if (dataObj === null) {
        dataObj = {data: null, options: null};
      }

      var self = this;
      waitForGoogleLoad(function() {
        constructGoogleChart(el, self.getId(el),
          toDataTable(dataObj.data), dataObj.options,
          google.visualization[chartType]);
      });
    }
  });
  Shiny.outputBindings.register(binding, 'google-' + chartType);
}

// [0]: String to be used in chart class
// [1]: Name of constructor in google.visualization namespace
// [2]: Library name
var chartTypes = [
  ['annontatedtimeline', 'AnnotatedTimeLine', 'annotatedtimeline'],
  ['area', 'AreaChart', 'corechart'],
  ['bar', 'BarChart', 'corechart'],
  ['bubble', 'BubbleChart', 'corechart'],
  ['calendar', 'Calendar', 'calendar'],
  ['candlestick', 'CandlestickChart', 'corechart'],
  ['column', 'ColumnChart', 'corechart'],
  ['combo', 'ComboChart', 'corechart'],
  ['gauge', 'Gauge', 'gauge'],
  ['geo', 'GeoChart', 'geochart'],
  ['geomap', 'GeoMap', 'geomap'],
  ['histogram', 'Histogram', 'corechart'],
  ['intensitymap', 'IntensityMap', 'intensitymap'],
  ['line', 'LineChart', 'corechart'],
  ['map', 'Map', 'map'],
  ['motion', 'MotionChart', 'motionchart'],
  ['org', 'OrgChart', 'orgchart'],
  ['pie', 'PieChart', 'corechart'],
  ['scatter', 'ScatterChart', 'corechart'],
  ['steppedarea', 'SteppedAreaChart', 'corechart'],
  ['table', 'Table', 'table'],
  ['timeline', 'Timeline', 'timeline'],
  ['treemap', 'TreeMap', 'treemap'],
  ['sankey', 'Sankey', 'sankey']
];

for (var i = 0; i < chartTypes.length; i++) {
  createBinding(
    chartTypes[i][0],
    chartTypes[i][1]
  );
}

Shiny.addCustomMessageHandler(
  'googleCharts.setSelection',
  function(data) {
    var $chart = $('#' + data.id);
    if ($chart.length === 0 || !$chart.data('googleChart')) {
      pendingSelection[data.id] = data.selection;
    } else {
      $chart.data('googleChart').setSelection(data.selection);
    }
  }
);

})();