import Vue from 'vue'
import Router from 'vue-router'
import Hat from '../../hat.vue'
import Hatlog from '../../hatlog.vue'
// import Signin from '../components/Signin.vue'
// import Signup from '../components/Signup.vue'
// import List from '../components/todos/list.vue'
// import NotFound from '../components/404.vue'
Vue.use(Router)

export default new Router({
  
  routes: [
    {
      path: '/',
      name: 'Hat',
      component: Hat
    },
    {
      path: '/Join',
      name: 'Hatlog',
      component: Hatlog
    },
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