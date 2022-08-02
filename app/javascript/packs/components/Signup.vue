<template>
  <v-form class="form-signup" @submit.prevent="signup">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group">
      <label for="email">Зарегистрироваться</label>
      <v-text-field v-model="email" :rules="emailRules"   id="email" placeholder="email@example.com"></v-text-field>
    </div>
    <div class="form-group">
      <!-- <label for="password">Придумайте пароль</label> -->
      <v-text-field v-model="password" type="password" id="password" placeholder="Придумайте пароль"></v-text-field>
    </div>
    <div class="form-group">
      <!-- <label for="password">Повторите пароль</label> -->
      <v-text-field v-model="password_confirmation" :rules="confirmRules" type="password" id="password_confirmation" placeholder="Повторите пароль"></v-text-field>
    </div>
    <v-btn type="submit" class="btn btn-primary my-3">Отправить</v-btn>
    <div>

    </div>
  </v-form>
</template>

<script>
  import { mapState } from 'pinia'
  import { mapActions } from 'pinia' 
  import { useLogStore } from 'store.js'
export default {
  name: 'Signup',
  data () {
    return {
      confirmRules: [
        v => !!v || 'нужно ввести пароль',
        v => v.length >= 5 || 'Пароль должен содержать более 6 символов',
                    // v => (v || '').indexOf(' ') < 0 ||  'Пробелов не должно быть'
        v => v == this.password || "Пароли не совпадают"
      ],  
      emailRules: [
        v => !!v || 'E-mail необходим для регистрации',
        v => /.+@.+\..+/.test(v) || 'E-mail введен некорректно',
      ],      
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  computed: {  
    ...mapState(useLogStore, {
      loastat: "thisloa",
    }),
 
  },    
  methods: {
    ...mapActions(useLogStore, ["setCurrentUser"]),     
    // ...mapActions(useLogStore, ["logined"]),     
    signup () {
      // console.log()
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
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

      // this.logined()
      // localStorage.csrf = response.data.csrf
      // localStorage.signedIn = trues
      // this.$router.replace('/todos')
      this.$router.replace('/')
    },
    signupFailed (error) {
      console.log(error)
      this.error = (error.response && error.response.data && error.response.data.error) || error.data.errors
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        // this.$router.replace('/todos')
        this.$router.replace('/')
      }
    }
  }
}
</script>

<style lang="css">
.form-signup {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>