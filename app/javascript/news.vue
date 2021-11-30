<template>
  <div class=" py-1 px-0"> 
    <v-card v-for="(item, index) in alld " :key= "item.id" 
      class=" py-1 my-1">
      <v-row class="d-flex">
       
        <v-col>
           <div 
          class="d-flex align-top  float-left mx-3  ">
         <!--   -->
          <div class ="pic px-0  align-center my-2" v-bind:style="{backgroundImage: 'url('+ item.pic}">
          </div>
        </div>
          <v-card-title
            class="text-h6 px-0 py-2"
            v-text="item.head">
          </v-card-title>
          <div class="px-2">
            {{item.desc}}… 
          </div>
 
          <v-card-subtitle
          class="px-2 py-0 float-left">
          {{item.date}} 
          </v-card-subtitle>

          <v-btn  
            target="_blank" 
            v-bind:href="'https://www.pocketgamer.biz'+item.link"
            class="px-1 py-0 float-left"
            color="orange lighten-2"
            text x-small>
            источник
          </v-btn>  
           
          <v-btn
          class="px-2 py-0 mx-4 but"
          @click="clickhandler(item.id, $event)"
          color="primary"
          small>
            открыть
          </v-btn>   
<!--             <v-btn
              class="float-right "
              icon
              @click="clickhandler(item.id, $event)">
              <v-icon>{{ dialogVisible&&item.id == empid  ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
            </v-btn> -->

            <div v-if="item.id == empid">

              <v-dialog
                v-model="dialogVisible"
                max-width="960px"
                width="95%">
                <v-card class="px-2">
                  <v-card-title class="px-1">
                    <span class="text-h5 px-1">{{item.desc}}</span>
                  </v-card-title>
                  <v-card-text class="px-1">
<div v-if="!fullnews"><v-progress-circular 
                      indeterminate 
                      color="green">
                    </v-progress-circular>  </div>
                    
<!--                     <v-img
                  class=" mr-4 float-left"
                  height="225px"
                  width="225px"
                  :src = "bigimage"></v-img> -->
                    <span v-html="fullnews"></span> 
                  </v-card-text>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn
                    color="green darken-1 "
                    text
                    @click="dialogVisible = false">
                    Закрыть
                    </v-btn>
 
                  </v-card-actions>
                </v-card>
              </v-dialog>
             </div>


        </v-col>
      </v-row>
    </v-card>

       

<!--           <v-expand-transition>
            <div v-show="dialogVisible">
              <v-divider></v-divider>
              <v-card-text>
                <v-img
                  class=" mr-4 float-left"
                  height="225px"
                  width="225px"
                  :src = "bigimage"></v-img>
                  <span v-html="fullnews"></span>
              </v-card-text>
            </div>
          </v-expand-transition> -->
    <v-progress-circular  
    indeterminate 
    color="green" v-if="this.bottom == true && alld.length != 0"></v-progress-circular>   
 

   
  </div>
</template>
<script>
  import axios from 'axios'
  export default {
 
    data: function (){
      return {
        bottom: false,
        bigimage: '',
        fullnews: '',
        dialogVisible: false,
        empid: '',
        alld: ''
      }
    },
    created(){
      window.addEventListener('scroll', () => {
        this.bottom = this.bottomVisible()
        // this.bganim.backgroundPosition = "center"
      })
    },
    watch: {
      bottom(bottom) {
        if (bottom)  {
          this.addBeer()
        }
      } 
    },
    mounted(){
        this.addBeer()
    },
    methods: {
    bottomVisible() {
      const scrollY = window.scrollY
      const visible = document.documentElement.clientHeight 
      const pageHeight = document.documentElement.scrollHeight
      const bottomOfPage = visible + scrollY+1000 > pageHeight
      return bottomOfPage || pageHeight < visible 
    },
    popemploy: function(data) {
      if (this.empid != ''){
      var self = this;  
      return data.filter(function (elem) {
 
        return elem.id == self.empid;
        })
      }
    },
    clickhandler( event) {
      if (event == this.empid){
        this.dialogVisible = !this.dialogVisible;
      }else{
        this.bigimage = ''
        this.fullnews = '' 
        this.dialogVisible = true;
        this.empid = event;
       axios({
          method: 'post',
          url: '/fullnews',
          data: {
            id: event
          },
        }).then((response) => { 
          if (response.data){
            console.log(response.data)
            this.fullnews = response.data.fullarticle
            // this.bigimage = response.data.biglink
          }
        }); 
      }
    },
      addBeer() {
        axios({
          method: 'get',
          url: '/news',
        }).then((response) => { 
          if (response.data){
            console.log(response.data)
            this.alld = response.data
          }
        });
      }
    },
  }
</script>
<style scoped>
.but{
  position: absolute;
  bottom: 2em;
  right: 1em;

}
.row { position: relative;
  
}
.pic {
  /*background-color: #dad;*/
  width: 100px;
  height: 100px;
 
}
</style>
