<script>
import { mapState, mapActions } from 'vuex'

export default {
    computed: {
        ...mapState('database', {
            is_db_connected: state => state.connected,
            is_db_connecting: state => state.is_connecting
        })
    },
    methods: {
        ...mapActions({
            connect: "database/CONNECT"
        })
    },
    watch: {
        is_db_connected(db_connected) {
            if (db_connected === false)
                return

            this.$router.push('/')
        }
    }
}
</script>

<template>
    <section id="error__db">
        <h1>
            Oops...
            <i class="zmdi zmdi-flash-off animated flash slower"></i>
        </h1>
        <h2>Une erreur de connexion à la base de données est survenue !</h2>

        <button title="Tenter une reconnexion" class="btn btn-warning" @click.prevent="connect">
            <i v-if="!is_db_connecting" class="zmdi zmdi-flash"></i>
            <clip-loader v-else :size="'14px'" :color="'#000'"></clip-loader>
            &nbsp;Tenter une reconnexion
        </button>

        <button title="En cours de développement" class="btn btn-danger disabled">
            <i class="zmdi zmdi-bug"></i>&nbsp;
            Reporter un problème
        </button>
    </section>
</template>

<style lang="scss">
#software {
    .content {
        &>div {
            // Pour la transition slide left/right
            transition: all .5s cubic-bezier(.55,0,.1,1);
        }
    }
}
</style>
