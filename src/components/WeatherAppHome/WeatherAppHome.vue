<template>
  <div class="WeatherAppHome w3-margin-top">
    <div v-if="weatherName === ''" class="w3-center">
      <p id="info">
        Your Weather Information will load shortly.<br />
        If requested, approve the geolocation on your browser.
      </p>
    </div>
    <div v-else class="w3-center">
      <p class="w3-xlarge">{{ weatherName }}</p>
      <p id="temperature" style="font-size: 50px">{{ weatherTemperature }} {{ weatherTemperatureSymbol }}</p>
      <i class="wi wi-owm-804"></i>
      <p class="capitalize">{{ weatherDescription }}</p>

      <div class="w3-content w3-row" style="width: 75%">
        <div class="w3-col s6 l6 m6 w3-container w3-center">
          <i class="wi wi-humidity"></i>
          <br /><br />
          <p>Humidity: {{ weatherHumidity }}%</p>
        </div>

        <div class="w3-col s6 l6 m6 w3-container w3-center">
          <i class="wi wi-forecast-io-wind"></i>
          <br /><br />
          <p>Wind: {{ weatherWindSpeed }} m/s</p>
        </div>
      </div>

      <div class="w3-col l12 w3-container w3-center w3-margin-bottom">
        <i class="wi wi-barometer"></i>
        <br /><br />
        <p>Pressure: {{ weatherPressure }}hPa</p>
      </div>

      <div class="w3-margin-top">
        <span class="w3-margin-right"><i class="wi wi-fahrenheit"></i></span>
        <label class="switch">
          <input checked type="checkbox" @click="changeTemperature" />
          <div class="slider round"></div>
        </label>
        <span class="w3-margin-left"><i class="wi wi-celsius"></i></span>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "WeatherAppHome",
  data() {
    return {
      geoTokenApi: "dec14651009b0f",
      OpenWeatherApi: "749a75bb456c097a2535c0631a2b7973",
      weatherTemperature: "",
      weatherName: "",
      weatherDescription: "",
      weatherWindSpeed: "",
      weatherHumidity: "",
      weatherPressure: "",
      isChecked: true,
      weatherTemperatureSymbol: "°C",
    };
  },
  async created() {
    // Request for user geolocation
    const geo = await axios.get(`https://ipinfo.io?token=${this.geoTokenApi}`);
    const locationCoordinates = geo.data.loc.split(",");
    const coordinateLatLong = {
      latitude: locationCoordinates[0],
      longitude: locationCoordinates[1],
    };
    // End Request for user geolocation

    // Request for Weather Api
    const weather = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?lat=${coordinateLatLong.latitude}&lon=${coordinateLatLong.longitude}&units=metric&appid=${this.OpenWeatherApi}`
    );
    this.weatherTemperature = Math.round(weather.data.main.temp);
    this.weatherName = weather.data.name;
    this.weatherDescription = weather.data.weather[0].description;
    this.weatherWindSpeed = weather.data.wind.speed;
    this.weatherHumidity = weather.data.main.humidity;
    this.weatherPressure = weather.data.main.pressure;
    // End Request for Weather Api
  },
  methods: {
    changeTemperature() {
      this.isChecked = !this.isChecked;

      if (!this.isChecked) {
        this.weatherTemperature = Math.floor(this.weatherTemperature * (9 / 5) + 32);
        this.weatherTemperatureSymbol = "°F";
      } else {
        this.weatherTemperature = Math.floor((this.weatherTemperature - 32) * (5 / 9));
        this.weatherTemperatureSymbol = "°C";
      }
    },
  },
};
</script>

<style lang="scss">
@import "WeatherAppHome";
</style>
