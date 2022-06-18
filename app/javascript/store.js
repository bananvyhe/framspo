import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
 
export const useLogStore = defineStore("logStore", {

  state: () => ({
    loa: ls.get('load')
  }),

  getters: {
  	thislog(){
  	return this.loa
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
    	// var n = Number(ls.get('load'))
    	// var b = n-3
     //  state.loa = b
     //  ls.set('load', b)
    }
  }  
 
})
 