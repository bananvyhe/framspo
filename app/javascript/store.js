import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
 
export const useLogStore = defineStore("logStore", {

  state: () => ({
    loa: ls.get('load'),
    log: localStorage.signedIn ? true : false 
  }),

  getters: {
  	thisloa(){
  		return this.loa
  	},
  	thislog(){
  		return this.log
  	}
  },

  actions: {
    increments(loa) {
    	console.log( "-----------")
			console.log(loa)
			console.log( "-----------")
 			this.loa += loa
 			ls.set('load', this.loa) 
    },
    decrement() {
    	this.loa -= 3
    	 ls.set('load', this.loa)
    },
    logined() {
      this.log = true
    },
    logouted() {
      this.log = false
  	}
     
  }  
 
})
 