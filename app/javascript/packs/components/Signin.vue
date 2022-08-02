<template>
  <v-form class="form-signin" @submit.prevent="signin">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <div class="form-group">
        <label for="email">Войти на сайт</label>
        <v-text-field v-model="email" type="email" class="form-control" id="email" placeholder="email@example.com"></v-text-field>
      </div>
      <div class="form-group">
        <!-- <label for="password">Пароль</label> -->
        <v-text-field v-model="password" type="password" class="form-control" id="password" placeholder="Password"></v-text-field>
      </div>
      <v-btn type="submit" class="btn btn-primary my-3"  > Войти </v-btn>
      <div>
      
    </div>
  </v-form>
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
      email: '',
      password: '',
      error: ''
    }
  },
  computed: {
    ...mapState(useLogStore, {
      signedIn: "thissignedIn",
    }),  
  },    
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    // ...mapActions(useLogStore, ["logined"]),
    ...mapActions(useLogStore, ["setCurrentUser"]), 
    ...mapActions(useLogStore, ["unsetCurrentUser"]),    
    // ...mapActions(useLogStore, {
    //   logstat: "logined",
    // }),
    // ...mapActions(useLogStore, {
    //   logstat: "logouted",
    // }),    
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      // this.logined()
      console.log(response)
      console.log("signinSuccessful")
      // console.log(this.logstat)
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      this.$http.plain.get('/me')
        .then(meResponse => {
          // this.$store.commit('setCurrentUser', { currentUser: meResponse.data, csrf: response.data.csrf })
          this.setCurrentUser(meResponse.data, response.data.csrf)
          this.error = ''
          // this.$router.replace('/todos')
          this.$router.replace('/join')
        })
        .catch(error => this.signinFailed(error))
      // console.log(response.data.csrf)
      // localStorage.csrf = response.data.csrf
      // console.log(localStorage.csrf)
      // localStorage.signedIn = true
       
      // this.$router.replace('/todos')
      // router.push({ path: '/users/eduardo' })
      // this.$router.replace('/')
        
    },
    signinFailed (error) {
       // this.logouted()
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      // delete localStorage.csrf
      // delete localStorage.signedIn
        this.unsetCurrentUser()
      
    },
    checkSignedIn () {
      if (this.signedIn == true) {
        this.$router.replace('/join')
        // this.$router.replace('/todos')
        // this.$router.replace('/') 
        // store.thislog = true
        // uselogStore.$patch({
        //   thislog: true
        // })
      }
    }
  }
}
</script>

<style lang="css">
.form-signin {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>