<template>
  <div class="WeatherAppHome w3-margin-top">
    <div v-if="weatherName === '' && !error" class="w3-center">
      <p class="info-message">
        Your Weather Information will load shortly.<br />
        If requested, approve the geolocation on your browser.
      </p>
    </div>
    <div v-if="error" class="w3-center">
      <p class="info-message">
        Oops there is an error.<br />
        Please try again later.
      </p>
    </div>
    <div v-if="weatherName" class="w3-center w3-margin-top">
      <div>
        <p class="w3-xlarge">{{ weatherName }}</p>
        <transition mode="out-in" name="fade">
          <p id="temperature" :key="weatherTemperature" style="font-size: 50px">
            {{ weatherTemperature }} {{ weatherTemperatureSymbol }}
          </p>
        </transition>
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
          <span class="w3-margin-right">
            <i :class="{ activeSymbol: !isChecked }" class="wi wi-fahrenheit"></i>
          </span>
          <label class="switch">
            <input checked type="checkbox" @click="changeTemperature" />
            <div class="slider round"></div>
          </label>
          <span class="w3-margin-left"><i :class="{ activeSymbol: isChecked }" class="wi wi-celsius"></i></span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import axios from "axios";

export default {
  name: "WeatherAppHome",
  data() {
    return {
      weatherTemperature: "",
      weatherName: "",
      weatherDescription: "",
      weatherWindSpeed: "",
      weatherHumidity: "",
      weatherPressure: "",
      isChecked: true,
      weatherTemperatureSymbol: "°C",
      error: false,
    };
  },
  async created() {
    try {
      // Request for user geolocation
      const geo = await api.getUserGeoLocation();
      const locationCoordinates = geo.data.loc.split(",");
      const coordinateLatLong = {
        latitude: locationCoordinates[0],
        longitude: locationCoordinates[1],
      };
      // End Request for user geolocation

      // Request for Weather Api
      const weather = await axios.get(
        `https://api.openweathermap.org/data/2.5/weather?lat=${coordinateLatLong.latitude}&lon=${coordinateLatLong.longitude}&units=metric&appid=${process.env.VUE_APP_OPEN_WEATHER_API}`
      );
      this.weatherTemperature = Math.round(weather.data.main.temp);
      this.weatherName = weather.data.name;
      this.weatherDescription = weather.data.weather[0].description;
      this.weatherWindSpeed = weather.data.wind.speed;
      this.weatherHumidity = weather.data.main.humidity;
      this.weatherPressure = weather.data.main.pressure;
      // End Request for Weather Api
    } catch (err) {
      // catches errors both in fetch and response.json
      this.error = true;
    }
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
