import { defineStore } from "pinia";
import ls from 'localstorage-slim'; 
 
export const useLogStore = defineStore("logStore", {

  state: () => ({

    valueReuse: 0,   
    reuse: false,
    signedIn: false,
    ctsrf: null,  
    currentUser: {},
  	rock: 3,
    loa: ls.get('load'),
    loareg: '',
    pumpkdead: false,
    // log: localStorage.signedIn ? true : false 
  }),

  getters: {
    thisvalue(){
      return this.valueReuse
    },      
    thisreuse(){
      return this.reuse
    },    
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
    thispumpkdead(){
      return this.pumpkdead
    },    
  	// thislog(){
  	// 	return this.log
  	// }
  },

  actions: {
    reuseCalc(){
      this.reuse = true
      this.interval = setInterval(() => {
        console.log(this.reuse)
        if (this.valueReuse === 100) {
          this.reuse = false
          console.log(this.reuse)
          clearInterval(this.interval);
          return (this.valueReuse = 0)

        }
        this.valueReuse += 10
      }, 50)  

    },
    setPumpkDead () {
      this.pumpkdead = true
    },
    setPumpkAlive () {
      this.pumpkdead = false
    },            
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
 