<template>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      :clipped="$vuetify.breakpoint.lgAndUp"
      app
    >
      <Menu />
    </v-navigation-drawer>

    <v-app-bar
      :clipped-left="$vuetify.breakpoint.lgAndUp"
      app
      color="blue darken-3"
      dark
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title
        style="width: 300px"
        class="ml-0 pl-4"
      >
        <span class="hidden-sm-and-down">Google Contacts</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn icon>
        <v-icon>mdi-apps</v-icon>
      </v-btn>
      <v-btn icon>
        <v-icon>mdi-bell</v-icon>
      </v-btn>
      <v-btn
        icon
        large
      >
        <v-avatar
          size="32px"
          item
        >
          <v-img
            src="https://cdn.vuetifyjs.com/images/logos/logo.svg"
            alt="Vuetify"
          ></v-img></v-avatar>
      </v-btn>
    </v-app-bar>
    <v-main>
      <v-container class="full-width"
      >
        <v-row>
           
 

          <v-data-table
    :headers="headers"
    :items="listItems"
    class="elevation-1"
  >
  <template slot="items" slot-scope="props">
        <td class="text-xs-right">{{ items.item.id }}</td>
        <td class="text-xs-right">{{ props.item.id }}</td>
      </template>
  </v-data-table>
          
           
          

        </v-row>
      </v-container>
    </v-main>
    <v-btn
      bottom
      color="pink"
      dark
      fab
      fixed
      right
      @click="dialog = !dialog"
    >
      <v-icon>mdi-plus</v-icon>
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="800px"
    >
      <v-form v-model="valid" ref="form" lazy-validation>
      <v-card>
        <v-card-title style="color:#fff" class="primary darken-2">
          Create contact
        </v-card-title>
        <v-container>
          <v-row class="mx-2">
            <v-col
              class="align-center justify-space-between"
              cols="12"
            >
              <v-row
                align="center"
                class="mr-0"
              >
                <v-avatar
                  size="40px"
                  class="mx-3"
                >
                  <img
                    src="//ssl.gstatic.com/s2/oz/images/sge/grey_silhouette.png"
                    alt=""
                  >
                </v-avatar>
                <v-text-field
                  id="country"
                  name="country"
                  label="country"
                  v-model="country"
                  :rules="countryRules"
                  required
                  ></v-text-field>
              </v-row>
            </v-col>
           
          </v-row>
        </v-container>
        <v-card-actions>
          <v-btn color="info" @click="dialog = false" >Cancel</v-btn>
          <v-btn color="success" @click="save" :disabled="!valid" >Save</v-btn>
        </v-card-actions>
      </v-card>
      </v-form>
    </v-dialog>
  </v-app>
</template>
<script>
  import Menu from './Menu';
  import axios from 'axios';
  export default {
    data () {
      return {
        valid: false,
        dialog: false,
        drawer: null,
        posts: [],
        pagination: {
                current: 1,
                total: 0
        },
        country: '',
        countryRules: [
          v => !!v || 'Country is required',
        ],
         headers: [
        { text: 'الرقم' },
        { text: 'البلد' },
      ],
      listItems: []
      }
    },
    props: {
      source: String,
    },
    components : {
      Menu
    },
    methods: {
        getNews() {
            axios.get('http://localhost:8000')
                .then(response => {
                    /*this.posts = response.data.data;
                    this.pagination.current = response.data.current_page;
                    this.pagination.total = response.data.last_page;*/
                    this.listItems = response.data
                    console.log(response.data);
                })
                .catch(err => {
                  console.log(err);
                })
        },
        onPageChange() {
            this.getNews();
        },
        save(){
          if(this.$refs.form.validate())
          {
            //router.push('about')
            //
            //this.$router.push('about')
            this.dialog = false;
            axios.post('http://localhost:8000/savecountry',{country: this.country })
                .then(response => {
                      console.log(response);
                      this.getNews(); 
                      this.$swal('success','','success')
                })
                .catch(err => {
                  this.$swal(err,'','danger')
                })

          }
        },
    },
    mounted() {
    this.getNews();
    /*
    //axios.get(`http://jsonplaceholder.typicode.com/posts`)
    axios.get(`http://localhost:8000`)
    .then(response => {
      // JSON responses are automatically parsed.
      //console.log(response.data.data);
      this.posts = response.data.data
    })
    .catch(err => {
      console.log(err);
    })

    // async / await version (created() becomes async created())
    //
    // try {
    //   const response = await axios.get(`http://jsonplaceholder.typicode.com/posts`)
    //   this.posts = response.data
    // } catch (e) {
    //   this.errors.push(e)
    // }*/
    }
  }
</script>