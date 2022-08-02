import axios from 'axios'

import { useLogStore } from 'store.js'
// const logStore = useLogStore();

const API_URL = 'http://localhost:3000'
// const API_URL = 'https://farmspot.ru'
const securedAxiosInstance = axios.create({ 
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    // 'Access-Control-Allow-Origin': '*',
    // 'Access-Control-Allow-Headers': '*',
    'Content-Type': 'application/json',
  }
})

const plainAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    // 'Access-Control-Allow-Origin': '*',
    // 'Access-Control-Allow-Headers': '*',
    'Content-Type': 'application/json',
  }
})

 
securedAxiosInstance.interceptors.request.use(config => {
  const method = config.method.toUpperCase()
  if (method !== 'OPTIONS' && method !== 'GET') { 
    console.log("interceptors.request")
    const logStore = useLogStore()
    console.log(logStore.thiscsrf)
    config.headers = {
      ...config.headers,
      'X-CSRF-TOKEN': logStore.thiscsrf
    }
  }
  return config
})

securedAxiosInstance.interceptors.response.use(null, error => {

  if (error.response && error.response.config && error.response.status === 401) {
      const logStore = useLogStore()
  console.log(logStore.thiscsrf)
    // In case 401 is caused by expired access cookie - we'll do refresh request
    return plainAxiosInstance.post('/refresh', {}, { headers: { 'X-CSRF-TOKEN': logStore.thiscsrf } })
      .then(response => {
        logStore.refresh(response.data.csrf) 
        // ...mapActions(useLogStore, ["refresh"])
        // const logStore = useLogStore();
          console.log("interceptors.response11")
        // logStore.refresh(response.data.csrf)  
        // localStorage.csrf = response.data.csrf
        // localStorage.signedIn = true
        // And after successful refresh - repeat the original request
        let retryConfig = error.response.config
        retryConfig.headers['X-CSRF-TOKEN'] = logStore.thiscsrf
        return plainAxiosInstance.request(retryConfig)
      }).catch(error => {
        const logStore = useLogStore();
        logStore.unsetCurrentUser
        // delete localStorage.csrf
        // delete localStorage.signedIn
        // redirect to signin in case refresh request fails
        // location.replace('/')
        return Promise.reject(error)
      })
  } else {
    return Promise.reject(error)
  }
})

export { securedAxiosInstance, plainAxiosInstance }