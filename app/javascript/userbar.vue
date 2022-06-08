<template>
  <div>
     {{ this.$store.state.loa}} loa <br>fsf{{this.logstat}}
  </div>
</template>

<script>
 import { mapState } from 'pinia'
 import { useLogStore } from 'store.js'
export default {

  data: function () {
    return {
      loa: "",
    }
  },
  mutations: {
    // increment (state) {
    //   state.loa++
    // }
  },
  mounted(){
    console.log(this.logstat)
    // this.$store.commit('increment')
 
  },
  computed: {
    // ...mapState(useLogStore, ['thislog'])
    ...mapState(useLogStore, {
      logstat: "thislog",
    })
  },  
}
</script>

<style scoped>
 
</style>
