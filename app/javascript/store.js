import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
 
export const useLogStore = defineStore("logStore", {

  state: () => ({
    signedIn: false,
    ctsrf: null,  
    currentUser: {},
  	rock: 3,
    loa: ls.get('load'),
    loareg: ''
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
    thisloareg(){
      return this.loareg
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
    setLoareg (val) {
      this.loareg = val
    },      
    refresh (csrf) {
      this.signedIn = true
      this.ctsrf = csrf
    },
    increments(loa) {
    	console.log( "-----------")
			console.log(loa)
			console.log( "-----------")
      if (this.signedIn == true){
        this.loareg += loa
      }else{
        this.loa += loa
        ls.set('load', this.loa)         
      }
    },
    decrement(val) {
      if (this.signedIn == true){
        this.loareg -= val
      }else{
        this.loa -= val
        ls.set('load', this.loa)     
      }
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
 