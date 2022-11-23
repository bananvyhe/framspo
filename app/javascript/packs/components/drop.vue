<template>
 <div> 
  <!-- {{pumpkdead}} -->
      <div class="d-flex justify-center">
      <v-tooltip top >
        <template v-slot:activator="{ on, attrs}">
          <span  v-bind="attrs" v-on="on" class="ore">
          </span>
          <span  class="energy"></span>
        </template>
        <span><span style="color:#ffe79f;">Камень</span> <br><span >можно забрать после регистрации</span></span>
      </v-tooltip> 
    </div>
 </div>
</template>

<script>
  import { mapState } from 'pinia'
  import { mapActions } from 'pinia'
  import { useLogStore } from 'store.js'
export default {
  //  setup() {
  //   const store = uselogStore()
  //   return {
  //     // you can return the whole store instance to use it in the template
  //     store,
  //   }
 
  // },  
  name: 'Signin',
  data () {
    return {
   
    }
  },
  mounted () {

    },
  computed: {
      ...mapState(useLogStore, {
        pumpkdead: "thispumpkdead",
      }),      
  },    
  created () {
    
  },
  updated () {
    
  },
  methods: {
 
  }
}
</script>

<style lang="css">
/*.v-progress-circular {
  margin: 1rem;
}*/
.energy{
    display: none;
    opacity: 0;
  top:22px;
  position: absolute;
  width: 150px;
  height: 70px;
  background: url(../../../javascript/images/energy27.gif);
}
.ore{
  display: none;
  z-index: 1;
  position: absolute;
  
  opacity: 0;
  bottom: 0px;
  width: 38px;
  height: 38px;
  background: url(../../../javascript/images/ore.png);
  cursor: pointer;
}
</style>