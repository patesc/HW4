// from SQL
// Samples_Metadata = Base.classes.sample_metadata
// Samples = Base.classes.samples

function buildMetadata(sample) {

  //Build the metadata panel
  var url= `/metadata/${sample}`;
  d3.json(url).then(function(sample){

    var sampleMetadata = d3.select("#sample-metadata");

  //clear any existing metadata

    sampleMetadata.html("");

    //`Object.entries` to add each key and value pair to the panel
    // **use d3 to append new
    Object.entries(sample).forEach(([key, value]) => {
      sampleMetadata.append("p");
      sampleMetadata.text(`${key} :${value}`);
    }
  });
}

function buildCharts(sample) {

// @app.route("/samples/<sample>")

  var url = `/samples/${sample}`;
  d3.json(url).then(function(data){

// Bubble chart
// app.py - Return `otu_ids`, `otu_labels`,and `sample_values

    var otu_ids = data.otu_ids;
    var otu_labels = data.otu_labels;
    var sample_values = data.sample_values;


  })



    // @TODO: Build a Bubble Chart using the sample data

    // @TODO: Build a Pie Chart
    // HINT: You will need to use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).
}

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
