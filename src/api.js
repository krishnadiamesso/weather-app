import axios from "axios";

export default {
  getUserGeoLocation() {
    return axios.get(`https://ipinfo.io?token=${process.env.VUE_APP_GEO_TOKEN_API}`);
  },
};
