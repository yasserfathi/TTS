<template>
  <div>
    <v-navigation-drawer v-model="drawer" app clipped left>
      <v-list v-if="isAgent">
        <template>
          <div v-for="item in agentitems" :key="item.title">
            <v-list-group
              v-if="item.items"
              v-model="item.active"
              :prepend-icon="item.action"
              no-action
              link
            >
              <template v-slot:activator>
                <v-list-item-content>
                  <v-list-item-title v-text="item.title">
                    <v-chip style="float: right;" color="primary" x-small>
                  new
                </v-chip>
                  </v-list-item-title>
                </v-list-item-content>
              </template>
              <v-list-item v-for="subItem in item.items" :key="subItem.title" :to="subItem.to">
                <v-list-item-icon>
                  <v-icon v-text="subItem.action"></v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title v-text="subItem.title" ma-1 pa-1>
                    <v-chip style="float: right;" color="primary" x-small>
                  new
                </v-chip>
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-group>
            <v-list-item v-else :to="item.to" link>
              <v-list-item-icon>
                <v-icon v-text="item.action"></v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title v-text="item.title">
                  <v-chip style="float: right;" color="primary" x-small>
                  new
                </v-chip>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </div>
        </template>
      </v-list>
      <v-list v-else>
        <template>
          <div v-for="item in items" :key="item.title">
            <v-list-group
              v-if="item.items"
              v-model="item.active"
              :prepend-icon="item.action"
              no-action
              link
            >
              <template v-slot:activator>
                <v-list-item-content>
                  <v-list-item-title v-text="item.title"></v-list-item-title>
                </v-list-item-content>
              </template>
              <v-list-item v-for="subItem in item.items" :key="subItem.title" :to="subItem.to">
                <v-list-item-icon>
                  <v-icon v-text="subItem.action"></v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title v-text="subItem.title" ma-1 pa-1></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-group>
            <v-list-item v-else :to="item.to" link>
              <v-list-item-icon>
                <v-icon v-text="item.action"></v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title v-text="item.title"></v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </div>
        </template>
      </v-list>
      <template v-slot:append>
        <div class="pa-2">
          <v-btn block color="#e5e5e5" @click="logout"><v-icon>mdi-logout</v-icon>تسجيل الخروج</v-btn>
        </div>
      </template>
    </v-navigation-drawer>
    <v-app-bar
      :clipped-left="$vuetify.breakpoint.lgAndUp"
      app
      v-bind:class="{primary:kolor,secondary:nokolor}"
      dense
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title style="width: 600px" class="ml-0 pl-4">
        <span class="hidden-sm-and-down">ترحال TTS</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      {{username}}
      <v-menu open-on-hover offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn v-bind="attrs" v-on="on" text>
            <v-avatar size="40px">
              <img src="../static/avatar/user.png" />
            </v-avatar>
          </v-btn>
        </template>
        <v-list>
          <v-list-item @click="logout">
            <v-list-item-title>
              <v-icon>mdi-logout</v-icon>تسجيل الخروج
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn icon v-bind="attrs" v-on="on">
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item @click="logout">
            <v-list-item-title>
              <v-icon>mdi-logout</v-icon>تسجيل الخروج
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: {
    source: String,
  },
  data: () => ({
    drawer: null,
    username: "",
    isAgent: false,
    isOther: false,
    kolor: true,
    nokolor:  false,
    selected: [1],
    ResponseData: '',
    agentitems: [
      {
        title: "Ticket",
        action: "mdi-ticket",
        to: "/agentticket",
        new: true
      },
    ],
    items: [
      {
        title: "Dashboard",
        action: "mdi-view-dashboard",
        to: "/dashboard",
      },
      {
        title: "Users",
        action: "mdi-account-group",
        to: "/users",
      },
      {
        title: "Tirhal Apps",
        action: "mdi-cellphone-android",
        to: "/apps",
      },
      {
        title: "Categories",
        action: "mdi-database",
        to: "/category",
      },
      {
        title: "Filters",
        action: "mdi-filter",
        to: "/Filters",
      },
      {
        title: "Ticket",
        action: "mdi-ticket",
        to: "/ticket",
      },
      {
        title: "Reset Password",
        action: "mdi-lock-reset",
        to: "/resetpassword",
      },
    ],
    network: "",
  }),
  methods: {
    async check_Token() {
      const config = {
        headers: {
          Authorization: "Bearer " + localStorage.getItem("storeddata"),
        },
      };
      axios
        .get("http://127.0.0.1/backend/api/auth/profile", config)
        .then((response) => {
          this.username = response.data.name;
          if(response.data.role == 'Agent')
          {
            this.isAgent = true
          }
          this.kolor = true;
          this.nokolor = false;
        })
        .catch((error) => {
          this.username = "";
          this.kolor = false;
          this.nokolor = true;
          this.ResponseData = error
        });
    },
    logout() {
      this.$swal({
        title: "هل تريد الخروج",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      }).then((willDelete) => {
        if (willDelete) {
          const config = {
                  headers: {
                       Authorization: "Bearer " + localStorage.getItem("storeddata")
                  }
          }
          axios
            .post("http://127.0.0.1/backend/api/auth/logout",{} ,config)
            .then()
            .catch(() => {
              console.clear()
            });
            localStorage.removeItem("storeddata");
            this.$store.dispatch("setToken", null);
            this.$router.push("/");
        }
      });
    },
  },
  created() {
    //this.username = localStorage.getItem("storeddata");
    this.check_Token();
    setTimeout(() => {
      this.check_Token();
    }, 60000);
    //this.check_Token()
    //this.username = shared.check_Token()
  },
  computed: {
      bg () {
        //return 'https://cdn.vuetifyjs.com/images/backgrounds/bg.jpg'
        return ''
      },
  },
};
</script>
<style>
.v-application--is-ltr
  .v-list-group--no-action
  > .v-list-group__items
  > .v-list-item {
  padding-left: 20px;
}
v-list-item__icon v-list-group__header__prepend-icon {
  margin-left: 10px;
}
</style>
