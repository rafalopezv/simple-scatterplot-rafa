<script>
  import { onMount } from "svelte";
  import { csv } from "d3-fetch";
  import { autoType } from "d3-dsv";
  import { scaleLinear, scaleSqrt, scaleOrdinal } from "d3-scale";
  import { max, min } from "d3-array";

  import AxisX from "$components/AxisX.svelte";
  import AxisY from "$components/AxisY.svelte";

  const margin = {
    top: 20,
    right: 25,
    bottom: 20,
    left: 45,
  };

  let data = [];
  let maxValueX;
  let maxValueY;
  let minValueY;
  let scaleX;
  // $: innerWidth = width - margin.left - margin.right;
  let scaleY;
  let scaleRadius;
  let height = 700;
  let width = 700;
  $: innerWidth = width - margin.left - margin.right;
  let innerHeight = height - margin.top - margin.bottom;
  let uniqueContinents;
  let colorScale;

  onMount(async () => {
    data = await csv("src/data/data.csv", autoType);
    console.log(data);
    maxValueX = max(data, (d) => d.gdpPercap);
    maxValueY = max(data, (d) => d.lifeExp);
    minValueY = min(data, (d) => d.lifeExp);
    console.log(maxValueX);
    console.log(maxValueY);
    console.log(minValueY);
    scaleX = scaleLinear().domain([0, maxValueX]).range([0, innerWidth]);
    scaleY = scaleLinear().domain([40, maxValueY]).range([innerHeight, 0]);
    let maxPopulation = max(data, (d) => d.pop);
    scaleRadius = scaleSqrt().domain([0, maxPopulation]).range([4, 40]);
    uniqueContinents = Array.from(new Set(data.map((d) => d.continent)));
    console.log(uniqueContinents);
    colorScale = scaleOrdinal()
      .domain(uniqueContinents)
      .range(["#2e3a4c", "#009ae4", "#ff6b31", "#f3c748", "#a5aab0"]);
  });
</script>

<div bind:clientWidth={width}>
  <main>
    <svg width={width} height={height}>
      <g transform="translate({margin.left} {margin.top})">
        {#if scaleX}
          <AxisX scaleX={scaleX} height={innerHeight} width={innerWidth} />
        {/if}
        {#if scaleY}
          <AxisY scaleY={scaleY} width={innerWidth} />
        {/if}
        {#each data as { gdpPercap, lifeExp, pop, continent }}
          <circle
            cx={scaleX(gdpPercap)}
            cy={scaleY(lifeExp)}
            r={scaleRadius(pop)}
            fill={colorScale(continent)}
            stroke="white"
            stroke-width=".3"
          />
        {/each}
      </g>
    </svg>
  </main>
</div>

<style>
  svg {
    fill: transparent;
    border-color: none;
  }
</style>
