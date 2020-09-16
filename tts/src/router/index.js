import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import About from '../views/About.vue'
import Ticket from '../views/Ticket.vue'
import AgentTicket from '../views/AgentTicket.vue'
import Dashboard from '../views/Dashboard.vue'
import Category from '../views/Category.vue'
import Filters from '../views/Filters.vue'
import Apps from '../views/Apps.vue'
import Users from '../views/Users.vue'
import ResetPassword from '../views/ResetPassword.vue'
//import PageNotFound from '../views/PageNotFound.vue'

Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    component: About,
    meta: { requiresAuth: true }
  },
  {
    path: '/category',
    name: 'Category',
    component: Category,
    meta: { requiresAuth: true }
  },
  {
    path: '/filters',
    name: 'Filters',
    component: Filters,
    meta: { requiresAuth: true }
  },
  {
    path: '/apps',
    name: 'Apps',
    component: Apps,
    meta: { requiresAuth: true }
  },
  {
    path: '/ticket',
    name: 'Ticket',
    component: Ticket,
    meta: { requiresAuth: true }
  },
  {
    path: '/agentticket',
    name: 'AgentTicket',
    component: AgentTicket,
    meta: { requiresAuth: true }
  },
  {
    path: '/users',
    name: 'Users',
    component: Users,
    meta: { requiresAuth: true }
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
    meta: { requiresAuth: true }
  },
  {
    path: '/resetpassword',
    name: 'ResetPassword',
    component: ResetPassword,
    meta: { requiresAuth: true }
  },
  {
    path: '*',
    component: Home,
  },
]

const router = new VueRouter({
  mode: 'history',
  base : '/dist/',
  routes
})

//router.replace({ path: '*', redirect: '/' })

/*router.beforeEach((to, from, next) => {
  let storedemail = localStorage.getItem('storedemail');
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if (storedemail !=null) {
      next()
      return
    }
    next('/')
  } else {
    next()
  }
})*/

export default router
