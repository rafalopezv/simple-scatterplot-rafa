<script>
  export let scaleY;
  export let width;
  console.log(scaleY);
  let ticksY = scaleY.ticks(5);
  $: console.log(ticksY);
</script>

<g>
  {#each ticksY as ticks, index}
    <g transform="translate(0, {scaleY(ticks)})">
      <text
        class="texto"
        cx={0}
        y={0}
        text-anchor="end"
        dx={-3}
        dominant-baseline="middle">{ticks} years</text
      >
      <!-- lines -->
      <line
        x1="0"
        x2={width}
        y1={0}
        y2={0}
        stroke={index === 0 ? "rgba(0,0,0, .5)" : "rgba(0,0,0,1)"}
        stroke-width={index === 0 ? ".6" : ".09"}
      ></line>
    </g>
  {/each}
</g>

<style>
  .texto {
    fill: black;
    font-size: 10px;
  }
</style>
