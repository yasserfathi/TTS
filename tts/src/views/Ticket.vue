<template>
  <v-app id="inspire">
    <Menu></Menu>
    <v-main>
      <v-container  grid-list-xl fluid>
        <v-layout row wrap>
        <v-flex lg12>
          <template>
            <v-container grid-list-md text-xs-center>
              <v-form v-model="search_valid" ref="form" lazy-validation>
               <v-layout row wrap>
              <v-flex xs2></v-flex>
              <v-flex xs7>
                <v-text-field
                          id="search"
                          name="search"
                          v-model="search"
                          prepend-inner-icon="mdi-card-search-outline"
                          :items="search_result"
                          item-text="search" 
                          item-value="search"
                          :rules="categoryRules"
                          ></v-text-field>
              </v-flex>
              <v-flex xs1>
                 <v-btn color="success" @click="submit" :disabled="!search_valid"  class="mb-6 pa-6">بحث</v-btn>
              </v-flex>
               </v-layout>
              </v-form>
            </v-container>
          </template>
          <template>
            <v-data-table
              ref="myTable"
              :headers="headers"
              :items="tickets"
              class="elevation-1"
              v-if="showtbl"
              :footer-props="{
                showFirstLastPage: true,
                firstIcon: 'mdi-arrow-collapse-left',
                lastIcon: 'mdi-arrow-collapse-right',
                prevIcon: 'mdi-minus',
                nextIcon: 'mdi-plus'
              }"
            >
            <template v-slot:top>
            <v-toolbar flat color="white">
              <v-dialog
      v-model="dialog"
      light
      fullscreen
      width="1000"
    >
      <template v-slot:activator="{ on, attrs }">
            <v-btn class="mb-1" v-bind="attrs" v-on="on" color="primary">
              <v-icon left>mdi-plus</v-icon> New Item
            </v-btn>
          </template>
      <v-form v-model="valid" ref="form" multipart enctype="multipart/form-data" lazy-validation>
      <v-card dense>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>New Ticket</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-btn @click="save" icon :disabled="!valid" v-if="chksave">Save</v-btn>
          </v-toolbar-items>
        </v-toolbar>
        <v-container>
            <v-row>
            <v-col cols="12" sm="12" md="12">
              <v-select
                                  id="app"
                                  name="app"
                                  v-model="app"
                                  :items="apps"
                                  :item-text="'app_name'"
                                  :item-value="'app_abbr'"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose an App name']"
                                  label="Applications"
                                ></v-select>
              </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                  id="caller_name"
                  name="caller_name"
                  label="Caller Name"
                  v-model="caller_name"
                  prepend-icon="mdi-phone-check"
                  :rules="categoryRules"
                  required
                  ></v-text-field>
              </v-col>
            <v-col cols="12" sm="4" md="4">
               <v-text-field
                  id="caller_phone"
                  name="caller_phone"
                  label="Caller Phone"
                  v-model="caller_phone"
                  prepend-icon="mdi-phone-check"
                  :rules="categoryRules"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  id="caller_balance"
                  name="caller_balance"
                  label="Balance"
                  v-model="caller_balance"
                  prepend-icon="mdi-phone-check"
                  :rules="categoryRules"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
              <v-text-field
                  id="caller_email"
                  name="caller_email"
                  label="E-mail"
                  v-model="caller_email"
                  prepend-icon="mdi-phone-check"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  id="plate_no"
                  name="plate_no"
                  label="Plate Number"
                  v-model="plate_no"
                  prepend-icon="mdi-phone-check"
                  :rules="categoryRules"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-select
                                  id="type"
                                  name="type"
                                  :items="types"
                                  v-model="type"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose a role']"
                                  label="Type"
                                ></v-select>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  id="order_id"
                  name="order_id"
                  label="Order ID"
                  v-model="order_id"
                  prepend-icon="mdi-phone-check"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  id="trip_request"
                  name="trip_request"
                  label="Trip Request"
                  v-model="trip_request"
                  prepend-icon="mdi-phone-check"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  id="ophone"
                  name="ophone"
                  label="Other Phone"
                  v-model="ophone"
                  prepend-icon="mdi-phone-check"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="6">
                <v-select
                                  id="purpose"
                                  name="purpose"
                                  :items="purposes"
                                  v-model="purpose"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose a purpose']"
                                  label="Purpose"
                                ></v-select>
              </v-col>
              <v-col cols="12" sm="6" md="6">
                <v-text-field
                  id="name"
                  name="name"
                  label="Name"
                  v-model="name"
                  prepend-icon="mdi-phone-check"
                  required
                  ></v-text-field>
              </v-col>
              <v-col cols="12" sm="12" md="12">
                <v-select
                                  id="category"
                                  name="category"
                                  :items="filterByVal"
                                  :item-text="'category_title'"
                                  :item-value="'id'"
                                  v-model="category"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose a category']"
                                  label="Category"
                                ></v-select>
              </v-col>
              <v-col cols="12" sm="12" md="12">
                <v-textarea
                                  id="content"
                                  name="content"
                                  v-model="content"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese Fill the content']"
                                  label="Content"
                                  rows="2"
                                   row-height="10"
                                  dense
                                ></v-textarea>
              </v-col>
              <v-col cols="12" sm="12" md="12">
                <v-btn color="primary darken-0" block rounded style="color:#fff" @click="save" :disabled="!valid">Save</v-btn>
              </v-col>
            </v-row>
        </v-container>
      </v-card>
      </v-form>
    </v-dialog>
    <template>
  <v-row justify="center">
    <v-dialog v-model="dialog_det" fullscreen max-width="1000">
      <v-card>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click="dialog_det = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Ticket Details</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-simple-table light class="ma-6">
    <template v-slot:default>
      <tbody>
        <tr>
          <td>Ticket No</td>
          <td>{{ticket_no}}</td>
        </tr>
        <tr>
          <td>Name</td>
          <td>{{caller_name}}</td>
        </tr>
        <tr>
          <td>Phone</td>
          <td>{{caller_phone}}</td>
        </tr>
        <tr>
          <td>Email</td>
          <td>{{caller_email}}</td>
        </tr>
        <tr>
          <td>Balance</td>
          <td>{{caller_balance}}</td>
        </tr>
        <tr>
          <td>Type</td>
          <td>{{type}}</td>
        </tr>
        <tr>
          <td>Purpose</td>
          <td>{{purpose}}</td>
        </tr>
        <tr>
          <td>Plate No</td>
          <td>{{plate_no}}</td>
        </tr>
        <tr>
          <td>Order ID</td>
          <td>{{order_id}}</td>
        </tr>
        <tr>
          <td>Deatils</td>
          <td>{{content}}</td>
        </tr>
      </tbody>
    </template>
  </v-simple-table>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>
              <v-divider
                class="mx-4"
                inset
                vertical
              ></v-divider>
              <v-spacer></v-spacer>
        <v-toolbar-title>Tickets</v-toolbar-title>      
              </v-toolbar>
              </template>
              <template v-slot:item.actions="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        small
        @click="deleteItem(item)"
      >
        mdi-delete
      </v-icon>
    </template>
    <template v-slot:[`item.actions`]="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="viewItem(item)"
      >
        mdi-eye
      </v-icon>
    </template>
            </v-data-table>

          </template>
          
        </v-flex>
        </v-layout>
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
  import Menu from './Menu';
  import axios from 'axios';
  export default {
    data () {
      return {
        id:'',
        chksave:true,
        loading:true,
        chkedit:false,
        valid: false,
        search_valid: false,
        dialog: false,
        dialog_det: false,
        gdialog: false,
        showtbl: false,
        editedIndex: -1,
        skeletonval: 0,
        showprogress: false,
        caller_phone: '',
        caller_name: '',
        caller_balance: '',
        caller_email: '',
        plate_no: '',
        name: '',
        ophone: '',
        order_id: '',
        trip_request: '',
        type: '',
        purpose: '',
        category: '',
        app: '',
        content: '',
        search: '',
        lazy: false,
        headers: [
          { text: 'Caller Name', value: 'caller_name' },
          { text: 'Phone', value: 'caller_phone' },
          { text: 'Actions', value: 'actions', sortable: false },
        ],
        search_result: [],
        types: ['Driver', 'Passenger'],
        ResponseData: '',
        categories: [],
        apps: [],
        purposes: ['suggestion', 'complaint'],
        editedItem: {
          category_title: '',
          created_at: '',
          id: '',
          updated_at: '',
        },
        posts: [],
        tickets: [],
        menu1: false,
        menu2: false,
        pagination: {
                current: 1,
                total: 0
        },
        categoryRules: [
          v => !!v || 'Please Fill Data',
        ],
      }
    },
    props: {
      source: String,
    },
    components : {
      Menu
    },
    methods: {
      submit() {
      if (this.$refs.form.validate()) {
        const config = {
          headers: {
            Authorization: "Bearer " + localStorage.getItem("storeddata"),
            "Content-type": "application/json",
          },
        };
        axios.get("http://127.0.0.1/backend/api/auth/ticket/search/"+this.search,config)
          .then((response) => {
            this.tickets = response.data.ticket
            this.showtbl =true
          })
          .catch((error) => {
            this.ResponseData = error
          });
      }
    },
        loadmodal(){
          this.chksave = true 
          this.chkedit = false
          this.dialog = true
        },
        onPageChange() {
            this.getData()
        },
        save(){
          if(this.$refs.form.validate())
          {
            this.dialog = false;
            const config = {
            headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        "Content-type": "application/json"
                    }
            }
            console.log(config)
            axios.post("http://127.0.0.1/backend/api/auth/ticket",
            {
              ticket_no: this.app,
              caller_phone: this.caller_phone,
              caller_name: this.caller_name,
              caller_balance: this.caller_balance,
              caller_email: this.caller_email,
              plate_no: this.plate_no,
              type: this.type,
              purpose: this.purpose,
              content: this.content,
              category: this.category,
              otherphone: this.ophone,
              status: 'created',
              created_by: '7',
            },config)
            .then((response) => {
             //this.getData();
             console.log(response)
             this.ResponseData = response
          })
          .catch((error) => {
            this.ResponseData = error
            console.log(error)
            this.$swal('error','','warning')
          });
          }
        },
        getData(){
            this.skeletonval = 0
            const config = {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        'Content-Type': 'application/json',
                    }
            }
            this.tickets = []
           axios.get('http://127.0.0.1/backend/api/auth/ticket',config)
                .then(response => {
                      this.tickets = response.data
                      this.ResponseData = response.data
                })
                .catch(error => {
                  this.ResponseData = error
                })
        },
        getApps(){
            this.skeletonval = 0
            const config = {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        'Content-Type': 'application/json',
                    }
            }
            this.apps = []
           axios.get('http://127.0.0.1/backend/api/auth/app/show',config)
                .then(response => {
                    this.apps = response.data.apps
                    console.log(this.apps)
                })
                .catch(error => {
                  this.ResponseData = error
                })
        },
        getCategories(){
            this.skeletonval = 0
            const config = {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        'Content-Type': 'application/json',
                    }
            }
            this.categories = []
           axios.get('http://127.0.0.1/backend/api/auth/category/show',config)
                .then(response => {
                      //this.dialog = false
                      //this.showprogress = false
                      //this.uploadPercentage = 0
                      this.categories = response.data.categories
                })
                .catch(error => {
                  this.ResponseData = error
                })
        },
        viewItem(item){
          this.editedIndex = this.categories.indexOf(item)
          this.editedItem = Object.assign({}, item)
          this.ticket_no = this.editedItem['ticket_no']
          this.caller_phone = this.editedItem['caller_phone']
          this.caller_name = this.editedItem['caller_name']
          this.caller_email = this.editedItem['caller_email']
          this.caller_balance = this.editedItem['caller_balance']
          this.type = this.editedItem['type']
          this.purpose = this.editedItem['purpose']
          this.plate_no = this.editedItem['plate_no']
          this.order_id = this.editedItem['orderid']
          this.content = this.editedItem['content']
          this.dialog_det = true
        },
        editItem(item){
          this.editedIndex = this.categories.indexOf(item)
          this.editedItem = Object.assign({}, item)
          this.category = this.editedItem['category_title']
          this.chksave = false
          this.chkedit = true
          this.dialog = true
        },
    },
    created() {
    this.getCategories()
    this.getApps()
    //this.getData()
    /*window.setInterval(() => {
      this.getCountries()
    }, 10000)*/
    //this.checkToken()
    },
    computed: {
      filterByVal() {
        return this.categories.filter((categories) => {
          return categories.category_type.match(this.type)
        });
      },
    },
  }
</script>
<style scoped>
.theme--light.v-data-table > .v-data-table__wrapper > table > thead > tr:last-child > th {
      text-align: center !important;
    }
</style>