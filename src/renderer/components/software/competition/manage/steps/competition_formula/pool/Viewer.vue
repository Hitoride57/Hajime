<script>
import { mapState, mapGetters, mapActions } from 'vuex'
import PoolList from '@partials/pool/List'

export default {
    components: { PoolList },
    computed: {
        ...mapState('pool', {
            number_of_entry_per_pool: state => state.configuration.number_of_entry_per_pool
        }),
        ...mapState('competition', { // @TODO il faut être sûr que la compétition soit chargée, à revoir ...
            competition_type: state => state.model.type,
        }),
        ...mapGetters({
            list: "pool/ranked_list",
            constant_type_list: "competition/constant_type_list",
            pool_count: 'pool/count'
        }),
        number_of_entry_left() {
            const last_pool = this.list[this.pool_count-1]

            if (undefined === last_pool)
                return 0

            return last_pool.entry_list.length
        },
        is_last_pool_different_size() {
            return this.number_of_entry_per_pool !== this.number_of_entry_left
        },
        number_of_pool() {
            return this.is_last_pool_different_size ? this.pool_count - 1 : this.pool_count
        },
        entry_label() {
            return this.competition_type === this.constant_type_list.TEAM ? "équipes" : "combattants"
        }
    },
    methods: {
        ...mapActions({
            GeneratePdf: "pool/GENERATE_PDF"
        })
    },
    data() {
        return {}
    }
}
</script>

<template>
    <div>
        <div class="toolbar">
            <div class="toolbar__label">
                {{ number_of_pool }} poules de {{ number_of_entry_per_pool }} {{ entry_label }}
                <template v-if="is_last_pool_different_size">
                    et 1 poule de {{ number_of_entry_left }} {{ entry_label }}
                </template>
            </div>

            <div class="actions">
                <a href="javascript:void(0);" @click.prevent="GeneratePdf" title="Télécharger le PDF de la liste des poules" class="actions__item zmdi zmdi-collection-pdf"></a>
            </div>
        </div>

        <software-container limit-container="software__footer" element-scroll="poolListViewer">
            <pool-list
                id="poolListViewer"
                :list="list"
                :canShowDetail="true"
            />
        </software-container>
    </div>
</template>
