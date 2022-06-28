<template>
  <div class="inv">
     <v-menu
      v-model="menu"
      :close-on-content-click="false"
      :nudge-width="200"
      offset-y>
      <template v-slot:activator="{ on, attrs }">
        <div
            class="inv d-flex"
          color="indigo"
          dark
          v-bind="attrs"
          v-on="on">
 
        </div>
      </template>

      <v-card>
       scscsc
      </v-card>
    </v-menu>




<!--     <el-popover
      placement="bottom"
      width="200"
      trigger="click"
      content="this is content, this is content, this is content">
      <div class="slots">
        <div class="cash">
          <el-tooltip  class="smalltext"  placement="bottom">
            <div slot="content">
              <div class="tooldrop">
                <h5> </h5>
                <p>камнями вы можете оплатить некоторые действия</p>
              </div>
            </div>
            <div v-if="this.rock" class="rock">
              <div class="cry"></div>{{this.rock}}
            </div>    
          </el-tooltip>          
        </div>
        <div v-if="items == 0" ><h4>пустой инвентарь</h4></div>
        <draggable class="inv" v-model="Array.from(items)"  @end="itemMoved">
          <div v-for="(item, index) in items" class="one-item" v-on:click="oneClick(item.item_name, item.id)"> 
            <el-tooltip  class="smalltext"  placement="bottom">
              <div slot="content">
                <h5 style="padding-left: 0.5em;">{{item.item_name}}</h5><p>{{item.description}}</p>
              </div>
              <div v-bind:style="{backgroundImage: `url('items${item.image.slice(9)}')`}" class="item-inv"><div v-if="item.qty != 0">{{item.qty}}</div>
              </div>
            </el-tooltip>
          </div>          
        </draggable>

      </div>
    </el-popover>   -->





<!--     <el-dialog
      :lock-scroll="false"
      title="Создать клан"
      :visible.sync="dialogBuildClan"
      width="25em"
      >
      <el-form :model="form" :rules="rules" ref="form">             
        <el-form-item  prop="clan" size="medium">
          <el-input v-model="form.clan" auto-complete="off"></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer"  class="uiframe">
        <el-button @click="dialogBuildClan = false">Отмена</el-button>
        <el-button v-if="dis == false" type="primary" @click="proceed" >Подтвердить</el-button>
        <el-button v-else type="primary" disabled >Подтвердить</el-button>
      </div>
      <div slot="footer" class="footpostshow basetext font3">
        &nbsp;
      </div> 

    </el-dialog>    -->
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
    var validateClanname = (rule, value, callback) => {
      var self = this;
      setTimeout(function(){
        if (value.trim() == self.responseClan) {
          callback(new Error('Имя занято')); 
          self.dis = true
        } else if (value.trim() == 'elder' || value.trim() == 'lead') {
          self.dis = true
          callback(new Error('недопустимое имя'));       
        } else if (value == '') {
          self.dis = false
          callback(new Error('Введите название клана'));
        } else {
          self.dis = false
          callback();
        }
      },400 );  
    };    
    return {
      fav: true,
      menu: false,
      message: false,
      hints: true,

      dis: false,
      responseClan: false,
      rules: {
        clan: [
          { required: true, validator: validateClanname, trigger: ['blur', 'change']   }
        ]
      },      
      form: {
        clan: ''
      },
      dialogBuildClan: false,
      //doubleClick realise     
      result: [],
      delay: 500,
      clicks: 0,
      timer: null,  
          
      items: '',
      isOpen: false,
    }
  },
  watch: {
    'form.clan': function(val){
      console.log(val)
      axios({
        method: 'get',
        url:'/my_items/check_clan',
        params: {
          name: val.trim()
        },
        headers: {
          'Authorization': 'bearer '+this.token.access
        } 
      })
      .then((response) => {  
        console.log(response.data );
        if (response.data == null) {
          this.responseClan = false;
        }else{
          this.responseClan =  response.data.name         
        }


      })
      .catch(function (error) {
        console.log(error);
      }); 
      // console.log("clanname check")
    },    
    isOpen(){
      if (this.isOpen == true) {
        this.ItemsGet()
      }
    }
  },
  computed: {
    // ...mapGetters([
    //   'token' 
    // ]),  
    ...mapState(useLogStore, {
      rock: "thisrock",
    })  
  },
  methods: {
 
  
 
      res(){
        axios({
          method: 'post',
          url: '/api/v1/ressurect',
          headers: {
            'Authorization': 'bearer '+this.$store.getters.token.access
          }           
        }).then((response) => { 
          this.$store.commit('deadsend', false )
 
          $emit('my-event')
        });
      },    
   proceed() {
 
      axios({
        method: 'post',
        url: '/my_items/paste_clan',
        data: {
          name: this.form.clan
        },
        headers: {
          'Authorization': 'bearer '+this.$store.getters.token.access
        } 
      }).then((response) => { 
        this.dialogBuildClan = false
      })
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
      // console.log('true')
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
      var data = new FormData
      console.log(this.token.access)
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
 .inv{
  width: 40px;
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