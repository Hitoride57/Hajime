<script>
import { mapActions, mapGetters, mapState } from 'vuex'
import Step1 from './create/steps/Form'
import Step2 from './create/steps/FighterImport'
import Step3 from './create/steps/CompetitionFormula'

export default {
    components: { Step1, Step2, Step3 },
    computed: {
        ...mapState('competition', {
            competition_id: state => state.model.id,
        }),
        ...mapGetters({
            entry_count: "competition/entry_count"
        }),
        step_component() {
            return this.step_list[this.current_step-1].component_name
        },
        step_list() {
            return [
                {
                    name: "Informations générales",
                    component_name: "Step1"
                },
                {
                    name: "Import des combattants",
                    component_name: "Step2",
                    count: this.entry_count
                },
                {
                    name: "Formule de compétition",
                    component_name: "Step3"
                }
            ]
        },
        is_last_step() {
            return this.current_step == this.step_list.length
        }
    },
    methods: {
        ...mapActions({
            clearCompetition: "competition/CLEAR",
        }),
        nextStep() {
            this.current_step = this.current_step + 1
        },
        previousStep() {
            this.current_step = this.current_step - 1
        },
        goToStep(step) {
            if (this.current_step <= step)
                return

            this.current_step = step
        },
        redirectToCompetition() {
            this.$router.push({ name: 'manage-competition', params: { id: this.competition_id } })
        }
    },
    data() {
        return {
            current_step: 1,
        }
    },
    created() {
        this.clearCompetition()
    }
}
</script>

<template>
    <section id="competition__create">

        <header class="content__title">
            <h1>Nouvelle compétition</h1>

            <div class="actions">
                <router-link to="/" class="btn btn-dark btn--icon-text">
                    <i class="zmdi zmdi-close"></i> Annuler et revenir à l'écran principal
                </router-link>
                
                <transition name="fade" mode="out-in">
                    <button v-if="current_step > 1" class="btn btn-dark btn--icon-text" @click.prevent="previousStep()">
                        <i class="zmdi zmdi-arrow-left"></i> Revenir à l'étape précédente
                    </button>
                </transition>
            </div>
        </header>

        <div class="card">
            <div class="card-body">

                <nav aria-label="step-wizard" role="navigation">
                    <ol class="breadcrumb mb-3 software__container--offset-element">
                        <li v-for="(step, index) in step_list" :key="index" @click="goToStep(index+1)" class="breadcrumb-item" :class="{ active: current_step >= index+1 }">
                            {{ index+1 }}. {{ step.name }} <span v-if="null !== step.count" class="badge badge-pill badge-primary">{{ step.count }}</span>
                        </li>
                    </ol>
                </nav>

                <transition name="fade" mode="out-in">
                    <component :is="step_component" @onValidate="is_last_step ? redirectToCompetition() : nextStep()" @onBack="previousStep()"></component>
                </transition>
            </div>
        </div>

    </section>
</template>

<style lang="scss">
    .breadcrumb-item.active {
        cursor: pointer;
    }
</style>
