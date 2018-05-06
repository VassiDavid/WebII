$(document).ready(function() {
    //Get website url for ajax requests
    var SITE_URL = $(location).attr('protocol') + '//' + $(location).attr('hostname') + $(location).attr('pathname');
    SITE_URL = SITE_URL.replace('index.php', '');
    
    $('#login-btn').click(function () {
        var username = $('#username').val();
        var password = $('#password').val();
        
        if(username !== '' && password !== '') {
            $.ajax({
                type: 'post',
                url: SITE_URL + 'ajax.php?action=login',
                data: { username: username, password: password },
                dataType: 'json'
            })
            .done(function(response) {
                if(response.success === 1) {
                    alert('Login success');
                    location.href = SITE_URL;
                } else {
                    alert('Wrong username or password');
                }
            })
            .fail(function() {
                alert('Server error. Try later.');
            });
        } else {
            alert('Username or password is empty');
        }
    });
    
    $('#registration-btn').click(function () {
        var username = $('#username').val();
        var password = $('#password').val();
        var repassword = $('#repassword').val();
        var email = $('#email').val();
        
        if(username !== '' && password !== '' && email !== '' && password === repassword) {
            $.ajax({
                type: 'post',
                url: SITE_URL + 'ajax.php?action=registration',
                data: { password: password, username: username, email: email },
                dataType: 'json'
            })
            .done(function(json) {
                console.log(json);
                if(json.resp === 1) {
                    alert("Successful registration");
                    location.href = SITE_URL;
                }
            })
            .fail(function() {
                alert('Server error. Try later');
            });
        } else {
            alert('An input seems empty');
        }
    });
    
    $('#logout-btn').click(function () {
        $.ajax({
            type: 'post',
            url: SITE_URL + 'ajax.php?action=logout',
            dataType: 'json'
        })
        .done(function(response) {
            location.href = SITE_URL;
        })
        .fail(function() {
            alert('Server error. Try later');
        });
    });
    
    if($('.news-list') !== undefined) {
        $.ajax({
            type: 'get',
            url: SITE_URL + 'ajax.php?action=news_get',
            dataType: 'json'
        })
        .done(function(response) {
            if(response.success === 1) {
                var html_result = "";
                response.news.forEach(function(item) {
                    html_result += "<li>";
                    html_result += '<div class="title">' + item.news_title + '</div>';
                    html_result += '<div class="username">posted by ' + item.account_name + '</div>';
                    html_result += '<div class="date">' + item.news_date + '</div>';
                    html_result += '<div class="text">' + item.news_text + '</div>';
                    html_result += "</li>";
                });
                $('.news-list').html(html_result);
            } else {
                alert('An error occured');
            }
        })
        .fail(function() {
            alert('Server error. Try later');
        });
    }
    
    $('#news-btn').click(function () {
        var title = $('#news-title').val();
        var text = $('#news-text').val();
        if(title !== '' && text !== '') {
            $.ajax({
                type: 'post',
                url: SITE_URL + 'ajax.php?action=news_add',
                data: { title: title, text: text },
                dataType: 'json'
            })
            .done(function(response) {
                if(response.success === 1) {
                    location.reload();
                } else {
                    alert('An error occured');
                }
            })
            .fail(function() {
                alert('Server error. Try later');
            });
        }
    });
});

