<template>
  <div id="app">
    <WeatherAppHome />
  </div>
</template>

<script>
import WeatherAppHome from "@/components/WeatherAppHome/WeatherAppHome";

export default {
  name: "App",
  components: {
    WeatherAppHome,
  },
};
</script>

<style lang="scss">
#app {
  font-family: "Roboto", sans-serif;
  font-size: 110%;
}

.wi {
  line-height: 1.4;
  font-size: 45px;
}
</style>
