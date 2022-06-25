<template>
  <div class="d-flex ">
    {{this.logstat}}
      <div v-if="this.logstat == true" >
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


<!--         <router-link class="mx-1" to="/Signup">Регистрация</router-link>
        <router-link class="mx-2 pr-1" to="/Signin">Войти</router-link> -->
      </div>
    <div class="loa  px-2">{{ this.loastat}}</div> <div class="skull"></div>
  </div>
</template>

<script>
  import { mapState } from 'pinia'
  import { mapActions } from 'pinia'
  import { useLogStore } from 'store.js'
  import Signup from './packs/components/Signup.vue';
  import Signin from './packs/components/Signin.vue';
export default {
  components: { Signup, Signin },
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
