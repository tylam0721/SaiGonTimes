$(document).ready(function() {
    $("#select-status").change(function() {
        var status = $("#select-status").find(":selected").val();
        if (status == 1) {
            $("#Allow").removeAttr("hidden");
            $("#notAllow").attr("hidden", true)
        } else {
            $("#notAllow").removeAttr("hidden");
            $("#Allow").attr("hidden", true);
        }
    })
    $("table td .statusname").click(function() {
        var t = $(this);
        $('#select-tag').val(t.parent().siblings(".tagid").text().split(","));
        $('#select-cat').val(t.parent().siblings(".catid").text());
        $('#select-tag').selectpicker();
        $("#saveStatus").click(function() {
            t.text($("#select-status").find(":selected").text());
            $("#Allow").attr("hidden", true);
            var data = {
                postid: t.parent().siblings(".Id").text(),
                statusid: $("#select-status").find(":selected").val(),
                reason: $("#reason").val(),
                tag: $("#select-tag").val(),
                cat: $("#select-cat").val(),
                day: $("#select-day").val()
            }
            changeStatus(data);
        })
    });
})

function changeStatus(data) {
    callajax('http://localhost:3000/editor', 'post', JSON.stringify(data));
}

function callajax(ajaxurl, method, datasend) {
    $.ajax({
        headers: {
            'Content-Type': 'application/json'
        },
        url: ajaxurl,
        type: method,
        data: datasend,
        async: false,
        error: function(d) {
            var fullError = JSON.stringify(d);
            console.log(fullError);
        }
    });
}