import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import router from './router'
import store from './store'
import VueSwal from 'vue-swal'
 
Vue.use(VueSwal)

import './assets/style.css'

import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'
import vuetify from './plugins/vuetify';

Vue.use(VueRouter)

Vue.config.productionTip = false
Vue.config.devtools = false


new Vue({
  store,
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
