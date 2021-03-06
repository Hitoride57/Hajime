import SoftwareContainer from './SoftwareContainer/Component'
import Vue from 'Vue'

const bus = new Vue();

const SoftwareContainerPlugin = {
    install(Vue) {
        Vue.component("SoftwareContainer", SoftwareContainer)
        Vue.softwareContainer = Vue.prototype.$softwareContainer = bus
    }
}

export default SoftwareContainerPlugin