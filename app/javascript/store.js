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
    logined() {
      this.log = true
    },
    logouted() {
      this.log = false
    }
  }  
 
})
 