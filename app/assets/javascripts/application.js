// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap

//初回読み込み、リロード、ページ切り替えで動く。
$(document).on('turbolinks:load', function() {
    $('.user-icon').click(function(){
        $('.user-menu').toggle();
    });

    $('.password-change-btn').click(function(){
        $('.password-change').toggle('slow');
        if($(this).text()=='パスワードを変更する'){
            $(this).text('パスワードを変更やめる');
        }else{
            $(this).text('パスワードを変更する');
        }
    });

    var input_password = new Vue({
        el: '#input_password',
        watch: {
          message: function(newVal, oldVal) {
            this.error.require = (newVal.length < 1) ? true : false;
            this.error.tooShort = (newVal.length < 6 && newVal.length != 0) ? true : false;
          }
        },
        data: {
          message: '',
          error: {
            require: false,
            tooLong: false
          }
        }
    });
});

