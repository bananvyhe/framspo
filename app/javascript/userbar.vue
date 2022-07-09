<template>
  <div class="d-flex ">
    <!-- {{this.logstat}} -->
<!--       <div v-if="this.logstat == true" >
        <v-btn
          x-small 
          text
          color="primary"  
          @click="signOut">выйти
        </v-btn>  
      </div>  
      <div v-if="this.logstat == false">
      <v-dialog
        transition="dialog-top-transition"
        max-width="600">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
          small
            color="primary"
            v-bind="attrs"
            v-on="on"
          >Регистрация</v-btn>
        </template>
        <template v-slot:default="dialog">
          
          <v-card class="sign">
            <signup></signup>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>

      <v-dialog
        transition="dialog-top-transition"
        max-width="600">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
          small
            color="primary"
            v-bind="attrs"
            v-on="on"
          >Войти</v-btn>
        </template>
        <template v-slot:default="dialog">
          
          <v-card class="sign">
            <signin></signin>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>

      </div> -->
    <div class="useraction d-flex"> 
      <inv class="inve" v-if="this.logstat == true"></inv>
      <div class="loa  px-2">{{ this.loastat}}</div> <div class="skull"></div>
    </div>
    
  </div>
</template>

<script>
  import Inv from './packs/components/inventory.vue';  
  import { mapState } from 'pinia'
  import { mapActions } from 'pinia'
  import { useLogStore } from 'store.js'
  import Signup from './packs/components/Signup.vue';
  import Signin from './packs/components/Signin.vue';
export default {
  components: { Signup, Signin, Inv},
  data: function () {
    return {
      loa: "",
    }
  },
  methods: {
    ...mapActions(useLogStore, ["logouted"]), 
    signOut () {
      this.logouted()
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
         })
         .catch(error => this.setError(error, 'Cannot sign out'))
    },  
  },
  mutations: {
    // increment (state) {
    //   state.loa++
    // }
  },
  mounted(){
    console.log(this.loastat)
    // this.$store.commit('increment')
 
  },
  computed: {
    // ...mapState(useLogStore, ['thislog'])
    ...mapState(useLogStore, {
      loastat: "thisloa",
    }),
    ...mapState(useLogStore, {
      logstat: "thislog",
    })
  },  
}
</script>

<style scoped>
.inve{
  /*position: relative;*/
  z-index: 100;
  margin-top: -11px;
}
.useraction{
  /*background-color: #ada;*/
  position: relative;
}
.sign{
  width: 380px;
}
 .skull{
  height: 20px;
  width: 20px;
  background-image: url('./images/skull.png');
  image-rendering: pixelated;
 }
</style>
