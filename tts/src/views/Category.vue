<template>
  <v-app id="inspire">
    <Menu></Menu>
    <v-main>
      <v-container  grid-list-xl fluid>
        <v-layout row wrap>
        <v-flex lg12>
          <template>
            <v-data-table
              ref="myTable"
              :headers="headers"
              :items="categories"
              class="elevation-1"
              id="print"
              :footer-props="{
                showFirstLastPage: true,
                firstIcon: 'mdi-arrow-collapse-left',
                lastIcon: 'mdi-arrow-collapse-right',
                prevIcon: 'mdi-minus',
                nextIcon: 'mdi-plus'
              }"
            >
            <template v-slot:item.category_type="{ item }">
              <v-chip :color="typeColor(item.category_type)" dark>{{item.category_type}}</v-chip>
            </template>
            <template v-slot:item.category_priority="{ item }">
              <v-chip :color="priorityColor(item.category_priority)" dark>{{item.category_priority}}</v-chip>
            </template>
            <template v-slot:top>
            <v-toolbar flat color="white">
              <v-dialog
      v-model="dialog"
      width="800px"
    >
      <template v-slot:activator="{ on, attrs }">
            <v-btn class="mb-1" v-bind="attrs" v-on="on" color="primary">
              <v-icon left>mdi-plus</v-icon> New Item
            </v-btn>
          </template>
      <v-form v-model="valid" ref="form" multipart enctype="multipart/form-data" lazy-validation>
      <v-card>
        <v-card-title style="color:#fff" class="primary lighten-1">
          Categories
        </v-card-title>
        <v-container>
            <v-col
              class="align-center justify-space-between"
              cols="12"
            >
              <v-row
                align="center"
                class="mr-0"
              >
                <v-text-field
                  id="category"
                  name="category"
                  label="Category title"
                  v-model="category"
                  prepend-icon="mdi-folder-outline"
                  :rules="categoryRules"
                  required
                  ></v-text-field>
              </v-row>
              <v-row>
                <v-select
                                  id="category_type"
                                  name="category_type"
                                  :items="category_types"
                                  v-model="category_type"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose one']"
                                  label="Type"
                                ></v-select>
            </v-row>
            <v-row>
                <v-select
                                  id="category_priority"
                                  name="category_priority"
                                  :items="category_priorities"
                                  v-model="category_priority"
                                  prepend-icon="mdi-folder-outline"
                                  :rules="[v => !!v || 'Plese choose one']"
                                  label="Priority"
                                ></v-select>
            </v-row>
            </v-col>
        </v-container>
        <v-card-actions>
          <v-btn color="info" @click="dialog = false" >الغاء</v-btn>
          <v-btn color="success" @click="save" :disabled="!valid" v-if="chksave">حفظ</v-btn>
          <v-btn color="success" @click="edit" :disabled="!valid" v-if="chkedit">تحرير</v-btn>
        </v-card-actions>
      </v-card>
      </v-form>
    </v-dialog>
              <v-divider
                class="mx-4"
                inset
                vertical
              ></v-divider>
              <v-spacer></v-spacer>
        <v-toolbar-title>Categories</v-toolbar-title>      
              </v-toolbar>
              </template>
              <template v-slot:[`item.actions`]="{ item }">
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
  import moment from 'moment'
  import { format } from 'date-fns'
  export default {
    data () {
      return {
        id:'',
        chksave:true,
        loading:true,
        chkedit:false,
        valid: false,
        dialog: false,
        gdialog: false,
        uploadPercentage: 0,
        editedIndex: -1,
        skeletonval: 0,
        showprogress: false,
        lazy: false,
        headers: [
          { text: 'Category Title', value: 'category_title' },
          { text: 'Type', value: 'category_type' },
          { text: 'Priority', value: 'category_priority' },
          { text: 'Actions', value: 'actions', sortable: false },
        ],
        category_types: ['Passenger', 'Driver'],
        category_priorities: ['High', 'Medium','Low'],
        category_type:'',
        category_priority:'',
        editedItem: {
          category_title: '',
          created_at: '',
          id: '',
          updated_at: '',
        },
        posts: [],
        categories: [],
        date1: new Date().toISOString().substr(0, 10),
        date2: new Date().toISOString().substr(0, 10),
        menu1: false,
        menu2: false,
        pagination: {
                current: 1,
                total: 0
        },
        country: '',
        category: '',
        editcountry: [],
        user_id: '',
        categoryRules: [
          v => !!v || 'الرجاء ادخال البيانات',
        ],
        flag: '',
        flagRules: [
          //v => !v || 'A file is required'
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
        loadgraphmodal(){
          this.gdialog = true
        },
        loadmodal(){
          this.chksave = true 
          this.chkedit = false
          this.dialog = true
        },
        fileChanged(event) {
          this.flag  = event
        },
        async checkToken() {
            var token = localStorage.getItem('storeddata')
            const config = {
                    headers: {
                        'Authorization': 'Basic '+token,
                        'Access-Control-Allow-Origin': true,
                    }
            }
            console.log(config)
        },
        onPageChange() {
            this.getData()
        },
        priorityColor (priority) {
            if (priority == 'High') return 'red';
            else if (priority == 'Medium') return 'orange';
            else return 'green'
        },
        typeColor (type) {
            if (type == 'Passenger') return 'indigo';
            else return '#423c3c'
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
            axios.post("http://127.0.0.1/backend/api/auth/category",{ category_title: this.category,created_by: this.user_id,category_type:this.category_type,category_priority:this.category_priority },config)
            .then((response) => {
             this.getData();
             console.log(response.data);
             console.log(response);
              this.$refs.form.reset()
              this.$swal('تمت العملية بنجاح','','success')
          })
          .catch((error) => {
            console.log(error);
            this.$swal('error','','warning')
          });
          }
        },
        edit(){
          if(this.$refs.form.validate())
          {
            this.dialog = false;
            const config = {
            headers: {
                        'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                        "Content-type": "application/json"
                    }
            }
            axios.put('http://127.0.0.1/backend/api/auth/category/update',{ id:this.editedItem['id'],category_title: this.category,category_type:this.category_type,category_priority:this.category_priority },config)
            .then((response) => {
             console.log(response);
             this.getData()
             this.$refs.form.reset()
             this.$swal('تمت العملية بنجاح','','success')
          })
          .catch((error) => {
            console.log(error);
            this.$swal('error','','warning')
          });
            /*axios.post('http://localhost:8000/savecountry',{country: this.country })
                .then(response => {
                      console.log(response);
                      this.getNews(); 
                      this.$swal('success','','success')
                })
                .catch(err => {
                  this.$swal(err,'','danger')
                })*/

          }
        },
        deleteItem(item){
            this.editedIndex = this.categories.indexOf(item)
            this.editedItem = Object.assign({}, item)
            this.$swal({
                title: "هل تريد اكمال العملية",
                icon: "warning",
                buttons: true,
                dangerMode: true,
              })
              .then((willDelete) => {
                  if (willDelete) {
                      const config = {
                      headers: {
                                  'Authorization': 'Bearer '+localStorage.getItem("storeddata"),
                                  "Content-Type": "application/x-www-form-urlencoded"
                              }
                      }
                      axios.delete('http://127.0.0.1/backend/api/auth/category/'+this.editedItem['id'],config)
                        .then(response => {
                              //console.log(this.editedItem['id']);
                              console.log(response);
                              this.$swal({
                                position: 'top-end',
                                icon: 'success',
                                title: 'تمت العملية بنجاح',
                                showConfirmButton: false,
                                timer: 1500
                              }).then(() => { 
                                this.skeletonval = 0
                                this.getData()
                                }
                              );
                        })
                        .catch(err => {
                          console.log(err);
                      })
                  }
            });
        },
        getData(){
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
                      //this.flag = ''
                      console.log(response.data);
                      /*this.pagination.current = 1;
                      this.$swal({
                        position: 'top-end',
                        icon: 'success',
                        title: 'تمت العملية بنجاح',
                        showConfirmButton: false,
                        timer: 1500
                      }).then(() => { 
                        this.skeletonval = 0;
                        this.getCountries();
                        }
                      );*/
                })
                .catch(err => {
                  console.log(err);
                })
        },
        editItem(item){
          this.editedIndex = this.categories.indexOf(item)
          this.editedItem = Object.assign({}, item)
          this.category = this.editedItem['category_title']
          this.category_type = this.editedItem['category_type']
          this.category_priority = this.editedItem['category_priority']
          this.chksave = false
          this.chkedit = true
          this.dialog = true
        },
        check_Token: function() {
          const config = {
                  headers: {
                      'Authorization': 'Bearer '+localStorage.getItem("storeddata")
                  }
          }
          axios.get('http://127.0.0.1/backend/api/auth/profile',config).then(response => {
                //this.result = response;
                this.user_id = response.data.id
              })
              .catch(error => {
                this.result = error;
                return "error"
              })
        },
    },
    mounted() {
    this.check_Token()
    this.getData()
    /*window.setInterval(() => {
      this.getCountries()
    }, 10000)*/
    //this.checkToken()
    },
    computed: {
      getPercentage () {
        return this.uploadPercentage
      },
      getmail () {
        return this.$store.state.getEmail
      },
      computedDateFormattedMomentjs () {
        return this.date ? moment(this.date).format('dddd, MMMM Do YYYY') : ''
      },
      computedDateFormattedDatefns () {
        return this.date ? format(this.date, 'EEEE, MMMM do yyyy') : ''
      },
    },
  }
</script>
<style scoped>
.theme--light.v-data-table > .v-data-table__wrapper > table > thead > tr:last-child > th {
      text-align: center !important;
    }
</style>