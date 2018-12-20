// from data.js
var tableData = data;
// console.log(data);

// var tableBody = d3.select("tablebody");
var tbody = d3.select("tbody");

function createTable(tableData) {

  tableData.forEach((report_sight) => {
    // console.log(report_sight)
    var row = tbody.append("tr");

    Object.entries(report_sight).forEach(([key, value]) => {
      var cells = row.append("td");
        cells.text(value);
    });
  });
}

var filterButton = d3.select("#filter-btn");

filterButton.on("click", function() {
  d3.event.preventDefault();

  var inputDateTime = d3.select("#datetime");
  var inputValue = inputDateTime.property("value");
    // console.log(inputValue);

  if (inputValue == "") {
    createTable(tableData);
  } 

    else {
    var DataFilter = tableData.filter(rowData => rowData.datetime === inputValue);
    createTable(DataFilter);
  }
});

createTable(tableData);


