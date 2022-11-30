// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as jq from 'jquery';
import "jquery_ujs";
import "popper";
import "bootstrap"
window.importmapScriptsLoaded = true;

$(function(){
    console.log('JQuery is Working')
})

$(document).ready(function(){
    $('#flash').click(function(){
        this.remove()
    })
})
