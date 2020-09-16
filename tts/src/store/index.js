import Vuex from 'vuex'
import Vue from 'vue'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    email: ''
  },

  getters: {
    getEmail: state => {
      return state.email
    },
  },

  mutations: {
    set_token: (state, payload) => {
      state.email = payload;
    },
  },
  actions: {
    setToken({
      commit
    }, payload) {
      commit('set_token', payload)
    }
  }

});