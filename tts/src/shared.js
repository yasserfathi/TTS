import axios from 'axios';
export default {
  check_Token: function() {
    const config = {
            headers: {
                'Authorization': 'Bearer '+localStorage.getItem("storeddata")
            }
    }
    axios.get('http://127.0.0.1/backend/api/auth/profile',config).then(response => {
           //this.result = response;
           return response.data.name
        })
        .catch(error => {
          this.result = error;
          return "error"
        })
  },
}