<template>
  <div>
     {{ this.$store.state.loa}} loa
  </div>
</template>

<script>

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
    // this.$store.commit('increment')
 
  },
  computed: {

  }  
}
</script>

<style scoped>
 
</style>
