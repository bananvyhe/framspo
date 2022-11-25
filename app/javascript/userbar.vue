<template>
  <div class="d-flex "> 

    <router-link  to="/admin/all" v-if="this.currentUser.role == 'admin'">
      Admin
    </router-link>
    <div v-if="this.signedIn == true">
      <v-btn
        x-small 
        text
        color="primary"  
        @click="signOut">выйти
      </v-btn>  
    </div>  
    <div v-if="this.signedIn == false">
<!--       <v-dialog
        transition="dialog-top-transition"
        max-width="600">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
          small
            color="secondary"
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
          >Войти
          </v-btn>
        </template>
        <template v-slot:default="dialog">
          
          <v-card class="sign">
            <signin></signin>
            </v-card-actions>
          </v-card>
        </template>
      </v-dialog>
 -->
    </div>
    <div  v-else class="loa  ">
      <!-- {{loa}} -->
    </div>
    <div class="useraction d-flex">  
      <inv  v-if="this.signedIn == true">666</inv>
      <div class="loa  px-2" v-else>{{ this.loastat}}</div>
      
      <div class="skull"></div>
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
  created() {
    
  },  
  methods: {
    ...mapActions(useLogStore, ["unsetLoa"]),     
    ...mapActions(useLogStore, ["unsetCurrentUser"]), 
    // ...mapActions(useLogStore, ["logouted"]), 
    signOut () {
      // this.logouted()
      this.$http.secured.delete('/signin')
      .then(response => {
        // delete localStorage.csrf
        // delete localStorage.signedIn

        this.unsetLoa()
        this.unsetCurrentUser()
        this.$router.replace('/')
      })
      .catch(error => this.setError(error, 'Cannot sign out'))
    },  
  },
 
  mounted(){
    // console.log(this.loastat)
    // console.log(this.csrfstat)
    // this.$store.commit('increment')
 
  },
  computed: {
    ...mapState(useLogStore, {
      currentUser: "thiscurrentUser",
    }),     
    ...mapState(useLogStore, {
      csrfstat: "thiscsrf",
    }),    
    // ...mapState(useLogStore, ['thislog'])
    ...mapState(useLogStore, {
      loastat: "thisloa",
    }),
    ...mapState(useLogStore, {
      signedIn: "thissignedIn",
    }),  
  },  
}
</script>

<style scoped>
.inve{
  background-color: #dad;
  /*position: relative;*/
  z-index: 100;
  margin-top: -11px;
}
.useraction{
  z-index: 100;
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
