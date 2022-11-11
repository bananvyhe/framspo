import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
 
export const useLogStore = defineStore("logStore", {

  state: () => ({
    signedIn: false,
    ctsrf: null,  
    currentUser: {},
  	rock: 3,
    loa: ls.get('load'),
    // log: localStorage.signedIn ? true : false 
  }),

  getters: {
    thiscurrentUser(){
      return this.currentUser
    },
    thissignedIn(){
      return this.signedIn
    },
    thiscsrf(){
      return this.ctsrf
    },    
  	thisrock(){
  		return this.rock
  	},
  	thisloa(){
  		return this.loa
  	},
  	// thislog(){
  	// 	return this.log
  	// }
  },

  actions: {
    setCurrentUser (currentUser, csrf) {
      this.currentUser = currentUser
      this.signedIn = true
      this.ctsrf = csrf
    },
    unsetCurrentUser () {
      this.currentUser = {}
      this.signedIn = false
      this.ctsrf = null
    },
    unsetLoa () {
      this.loa = null
      ls.set('load', "") 
 
    },    
    refresh (csrf) {
      this.signedIn = true
      this.ctsrf = csrf
    },
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
   //  logined() {
   //    this.log = true
   //  },
   //  logouted() {
   //    this.log = false
  	// }
     
  },
  persist: true,  
 
})
 