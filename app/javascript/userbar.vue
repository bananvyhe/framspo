<template>
  <div class="d-flex align-right">
     <!-- {{ this.$store.state.loa}} loa  -->
     <div class="loa  px-2">{{ this.logstat}}</div> <div class="skull"></div>
     
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
 .skull{
  height: 20px;
  width: 20px;
  background-image: url('./images/skull.png');
 }
</style>
