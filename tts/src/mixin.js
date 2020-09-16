import axios from "axios";
export default {
  data() {
    return {
      /*kolor: false,
      nokolor: true,*/
    }
  },
  methods : {
    async check_Token() {
      const config = {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("storeddata"),
        },
      };
      axios
        .get("http://127.0.0.1/backend/api/auth/profile", config)
        .then((response) => {
          /*this.username = response.data.name;
          if(response.data.role == 'agent')
          {
            this.isAgent = true
          }
          this.kolor = true;
          this.nokolor = false;*/
          return this.username+'@'+response.data.role
        })
        .catch((error) => {
          /*this.username = "";
          this.kolor = false;
          this.nokolor = true;*/
          console.warn(error);
        });
    },
  }
}