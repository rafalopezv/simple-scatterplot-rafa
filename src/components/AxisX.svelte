<script>
  import { format } from "d3-format";
  let tickFormat = format(",.0f");
  export let scaleX;
  export let height;
  export let width;
  console.log(scaleX);
  let ticksX = scaleX.ticks(5);
  console.log(ticksX);
</script>

<!-- this pushes down the entire axis at the bottom -->
<g transform="translate(0, {height})">
  {#each ticksX as tick, index}
    <!-- this aligns both text and ticks -->
    <g transform="translate({scaleX(tick)}, 0)">
      <!-- ticks -->
      <line
        x1="0"
        x2="0"
        y={height}
        y2="6"
        stroke="rgba(0,0,0,.8)"
        stroke-width=".5"
      >
      </line>
      <!-- vertical gridline -->
      <line
        x1="0"
        x2="0"
        y1="0"
        y2="-{height}"
        stroke={index === 0 ? "rgba(0,0,0, .5)" : "rgba(0,0,0,1)"}
        stroke-width={index === 0 ? ".6" : ".05"}
      ></line>

      <text
        class="texto"
        x={0}
        y={6}
        dy={9}
        dominant-baseline="middle"
        text-anchor={index === 0 ? "start" : "middle"}
        >$ {tickFormat(tick)}
      </text>
    </g>
  {/each}
  <text
    class="texto"
    x={width}
    y={0}
    dy={-3}
    dominant-baseline="start"
    text-anchor="end">GDP per capita in US dollars</text
  >
</g>

<style>
  .texto {
    fill: black;
    font-size: 10px;
  }
</style>
