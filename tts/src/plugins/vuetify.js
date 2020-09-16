import '@mdi/font/css/materialdesignicons.css'
import Vue from 'vue';
import Vuetify from 'vuetify/lib';

Vue.use(Vuetify);

export default new Vuetify({
    theme: {
        themes: {
            light: {
                primary: '#f05623',
                secondary: '#43484a',
                accent: '#8c9eff',
                error: '#b71c1c',
            },
        },
    },
});