/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'

// import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/dist/vuetify.min.css'
import App from '../app.vue'
import Hat from '../hat.vue'
import Vuex from 'vuex'
import 'es6-promise/auto'
Vue.use(Vuex)
// import Vuetify from 'vuetify'
// Vue.use(Vuetify)

Vue.use(Vuetify, {
	components: {
		// VRadio,
		// VRadioGroup,
		// VTextField,
		VCol,
		VRow,
		VContainer,
		// VForm,
		// VIcon,
		// VSpacer,
		// VToolbarTitle,
		// VAppBarNavIcon,
		VAppBar,
		VMain,
		VApp,
		// VAlert,
		VCard,
		VCardTitle,
		VCardActions,
		VBtn,
		VListItem,
		VListItemContent,
		VListItemTitle,
		VListItemSubtitle,
		VListItemAvatar,
		VList,
		VImg,
		VCardSubtitle,
		VSpacer,
		VIcon,
		VExpandTransition,
		VDivider,
		VCardText,
		VDialog,
		VProgressCircular,
		VProgressLinear,
		VTooltip,
	}
}) 
import Vuetify, {
	// VRadio,
	// VRadioGroup,
	// VTextField,
	VList,
	VCol,
	VRow,
	VContainer,
	// VForm,
	// VIcon,
	// VSpacer,
	// VToolbarTitle,
	// VAppBarNavIcon,
	VAppBar,
	VMain,
	VApp,
	// VAlert,
	VCard,
	VCardTitle,
	VCardActions,
	VBtn,
	VListItem,
	VListItemContent,
	VListItemTitle,
	VListItemSubtitle,
	VListItemAvatar,
	VImg,
	VCardSubtitle,
	VSpacer,
	VIcon,
	VExpandTransition,
	VDivider,
	VCardText,
	VDialog,
	VProgressCircular,
	VProgressLinear,
	VTooltip,
} from 'vuetify/lib'
import colors from 'vuetify/lib/util/colors'
 	if (!localStorage.loa){
		localStorage.loa = 0
		console.log("0")
  }
const store = new Vuex.Store({

  state: {
    loa: localStorage.loa
  },
  mutations: {
    increment (state, n) {
    	var loasend = Number(n)
    	var n = Number(localStorage.loa)
    	var fin = loasend + n
      state.loa = fin
      localStorage.loa = fin

    },
    decrement (state) {
    	var n = Number(localStorage.loa)
    	var b = n-3
      state.loa = b
      localStorage.loa = b

    }
  }
})
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
  	vuetify: new Vuetify({
		  theme: { 
		  	dark: {
		  		primary: '#3b8839',
		  	},
		  },
  	}),
  	store: store,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
  var hat = document.getElementById("hat") 
  if (hat != null) {
	  new Vue({
	    el: '#hat',
	    store: store,
	    render: h => h(Hat) 
	  })
	}
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
