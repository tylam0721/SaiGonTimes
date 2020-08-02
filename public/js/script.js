function posstHTML(val){
    var html=' <li class="single_comment_area">'
    + '<div class="comment-content d-flex">'
    +    '<div class="comment-author">'
    +       '<img src="/public/img/bg-img/53.jpg" alt="author">'
    +   '</div>'
    +    '<div class="comment-meta">'
    +        '<a href="#" class="comment-date">27 Aug 2019</a>'
    +        '<h6>Tomas Mandy</h6>'
    +        '<p>'
                val
    +        '</p>'
    +        '<div class="d-flex align-items-center">'
    +            '<a href="#" class="like">like</a>'
    +            '<a href="#" class="reply">Reply</a>'
    +        '</div>'
    +    '</div>'
    +'</div>'
    +'</li>'
    $('#comment').prepend(html);
}