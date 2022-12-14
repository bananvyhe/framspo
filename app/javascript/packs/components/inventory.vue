<template>
  <div class=""> 
     <v-menu
      v-model="menu"
      :close-on-content-click="false"
      :nudge-width="200"
      offset-y>
      <template v-slot:activator="{ on, attrs }">
        <div
          class="inventory d-flex "
          color="indigo"
          dark
          v-bind="attrs"
          v-on="on">
        </div>
        <div class="px-2">
          {{loareg}}
        </div>


      </template>
      <v-card
        elevation="2"
        min-height="200">
        <div v-if="items == 0" ><h4>пустой инвентарь</h4></div>
        <draggable 
          class="inv" 
          v-model="Array.from(items)"  
          @end="itemMoved">
          <div v-for="(item, index) in items" class="one-item" v-on:click="oneClick(item.item_name, item.id)"> 

            <v-tooltip  top>
               <template v-slot:activator="{ on, attrs}">
                <div v-on="on" v-bind="attrs" class="item-inv" v-bind:style="{backgroundImage: 'url(/images/'+item.image+'.png'}">
<!--                   <span  v-bind="attrs" v-on="on" v-bind:style="{backgroundImage: `url('${item.image}')`}">
                  </span>    -->                
                </div>
              </template>
                <span><span style="color:#ffe79f;">{{item.item_name}}</span> <br><span class="caption">{{item.desc}}</span></span>

           <!--    <div slot="content">
                <h5 style="padding-left: 0.5em;">{{item.item_name}}</h5><p>{{item.description}}</p>
              </div>
              <div v-bind:style="{backgroundImage: `url('items${item.image}')`}" class="item-inv"><div v-if="item.qty != 0">{{item.qty}}</div>
              </div> -->
            </v-tooltip>
          </div>          
        </draggable>


      </v-card>
    </v-menu>

  </div>
</template>
<script>
import { mapState, mapActions } from 'pinia' 
import { useLogStore } from 'store.js'
// import { mapGetters } from 'vuex';
import axios from 'axios'  
import draggable from "vuedraggable"
export default {
  components: { draggable },
  // props:['isOpen'],
  
  data() {
    return {
      fav: true,
      menu: false,
      message: false,
      hints: true,

      dis: false,
      responseClan: false,
      
      dialogBuildClan: false,
      //doubleClick realise     
      result: [],
      delay: 500,
      clicks: 0,
      timer: null,  
          
      items: [{id: 1, position: 1, item_name: 'Золотой самородок', qty: 25, image: 'gold', desc: 'ценный ресурс для оплаты ключевых действий'},{id: 2, position: 2, item_name: 'Золотой самородок', qty: 12, image: 'gold', desc: 'ценный ресурс для оплаты ключевых действий'}],
      isOpen: false,
    }
  },
  watch: {
    isOpen(){
      if (this.isOpen == true) {
        this.ItemsGet()
      }
    }
  },
  computed: {
    ...mapState(useLogStore, {
      loareg: "thisloareg",
    }),    
  },
  created() {
    this.getloareg()
    this.menuget()
  },
  methods: {
    ...mapActions(useLogStore, ["setLoareg"]),     
    getloareg(){
       this.$http.secured.get('/my_items')
      .then(response => { 
        console.log(response.data)
        // this.loareg = response.data
        this.setLoareg(response.data)
      })
      .catch(error => { this.setError(error, 'Something went wrong') })
    }, 
    menuget(){
      console.log("menuget")
   this.$http.secured.get('/my_items/menuget')
      .then(response => { 
        console.log(response.data)
 

        // this.loareg = response.data
        
      })
      .catch(error => { this.setError(error, 'Something went wrong') })            
    },   
    oneClick: function(event, id) {
      this.clicks++
        if (this.clicks === 1) {
          var self = this
          this.timer = setTimeout(function() {
            self.result.push(event.type);
            self.clicks = 0
          }, this.delay);
        } else {
          // console.log(event)
          clearTimeout(this.timer);
          this.result.push('dblclick');
          this.clicks = 0;
          this.itemUse(event, id)
        }
    },  
    itemUse(name, id){
      // console.log(name)
      // console.log(id)
      if (name == 'Права лидера'){
        this.dialogBuildClan = true;
        // console.log('123')
      }
      axios({
        method: 'post',
        url: `/my_items/${id}/use_item`,
        data: {
          name: name
        },
        headers: {
          'Authorization': 'bearer '+this.token.access
        } 
      }).then((response) => { 
         
      })
    },
    ItemsGet(){
      console.log('ItemsGet')
      axios({
        method: 'get',
        url: '/my_items',
        headers: {
          'Authorization': 'bearer '+this.token.access
        } 
        })
        .then((response) => { 
           // console.log(response)
          this.items= ''
          var total = response.data
          this.items = total
        });      
    },
    itemMoved: function(event) {
      // this.$http.secured.path(`/my_items/${this.items[event.newIndex].id}/move`)
      var data = new FormData
 
      data.append("my_item[position]", event.newIndex + 1)
      axios({
        method: 'PATCH',
        url: `/my_items/${this.items[event.newIndex].id}/move`,
        data: data,
        headers: {
          'Authorization': 'bearer '+this.token.access
        }
      }).then((response) => { 
        this.items= ''
        this.ItemsGet()
      }) 
    },            
  }
}
</script>
<style scoped>
.item-inv {
  border: 1px solid color( $screenbg shade(56%));; 
  text-shadow: 0px 1px #222, 1px 0px #222;
  height: 44px; 
  width: 44px; 
  /*background: url(../../images/goldenore.png);*/
  /*background-color: #dad;*/
  /*display: flex;*/
   
  background-size: contain;
  padding: 0.3em 0 0 0.5em;

}
 .inventory{
  /*background-color: #ada;*/
  width: 50px;
  height: 40px;
  /*background-color: #dad;*/
  position: absolute;
  right: 0;

 }
.uiframe{
  padding-top: 0.25em;
}
.cash {
  display: flex;
}

.one-item {
  padding: 0.1em;
}
.inv {
  /*background-color: #dad;*/
  padding: 0.3em 0 0;
  display: flex;
  flex-direction: row;
}
.rock{
  display: flex;
  flex-direction: row;
  align-items: center;
}
/*.cry {
  border: 1px solid color( $screenbg shade(56%));; 
  text-shadow: 0px 1px #222, 1px 0px #222;
  height: 18px; 
  width: 18px; 
  background-image: url('../images/cry.jpg');
  background-size: contain;
  padding: 0.3em 0 0 0.5em;
  margin-right: 0.3em;
} */
.tooldrop{
  text-align: left;
  width: 15em;
  margin: -0.3em -0.1em;
  font-size: 0.9em;
  h5{
    padding-left: 0.5em;
  }
  p{
    text-align: center;
  }
}
.slots{
  box-shadow: inset 0px 0px 8px rgba(0,0,0,0.3);
  padding: 0.5em 0.5em;
  /*background-color: #dad;*/
  margin: -0.8em -1em;
  display: flex;
  flex-direction: column;
}
</style>