<script>
  // from JS
  import data from "$data/data.js";
  console.log("JS data:", data);

  // from JSON
  import dataJson from "$data/data.json";
  console.log("JSON data:", dataJson);

  // from csv using paparase
  // Problem: import values as strings

  import { onMount } from "svelte";
  import Papa from "papaparse";

  let dataCsv;

  onMount(() => {
    Papa.parse("/src/data/data.csv", {
      download: true,
      header: true,
      complete: function (results) {
        dataCsv = results.data;
        console.log("Paparase csv data:", dataCsv);
      },
      error: function (error) {
        console.error(error);
      },
    });
  });

  // from csv using d3
  import { csv } from "d3-fetch";
  import { autoType } from "d3-dsv";

  let CsvD3;

  onMount(async () => {
    CsvD3 = await csv("/src/data/data.csv", autoType);
    console.log("D3 csv data:", CsvD3);
  });
</script>
