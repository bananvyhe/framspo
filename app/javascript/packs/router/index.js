import Vue from 'vue'
import Router from 'vue-router'
// import Content from '../../content.vue'
// import Signin from '../components/Signin.vue'
// import Signup from '../components/Signup.vue'
// import List from '../components/todos/list.vue'
// import NotFound from '../components/404.vue'
Vue.use(Router)

export default new Router({
  
  routes: [
    // {
    //   path: '/',
    //   name: 'Content',
    //   component: Content
    // },
    // {
    //   path: '/Signup',
    //   name: 'Signup',
    //   component: Signup
    // },
    // {
    //   path: '/Signin',
    //   name: 'Signin',
    //   component: Signin
    // },    
    // {
    //   path: '/todos',
    //   name: 'List',
    //   component: List
    // },
    // {
    //   path: '*',
    //   name: 'NotFound',
    //   component: NotFound
    // },
  ],
  mode: 'history'
})