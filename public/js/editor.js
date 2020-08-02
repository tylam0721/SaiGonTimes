$(document).ready(function(){
  $("#select-status").change(function(){
    var status=$("#select-status").find(":selected").val();
    if(status==1) {$("#Allow").removeAttr("hidden");$("#notAllow").attr("hidden",true)}
    else {$("#notAllow").removeAttr("hidden");$("#Allow").attr("hidden",true)}
  })
  $("table td .statusname").click(function(){
    var t=$(this);
    $("#select-status").val(t.parent().siblings(".statusid").text());
    $("#saveStatus").click(function(){     
      t.text($("#select-status").find(":selected").text());
      t.parent().siblings(".statusid").text($("#select-status").find(":selected").val())
      $("#notAllow").attr("hidden",true);
      $("#Allow").attr("hidden",true);
      var data={
        postid:t.parent().siblings(".Id").text(),
        statusid:t.parent().siblings(".statusid").text(),
        reason:$("#reason").val()
      }
      changeStatus(data);
    })
  }); 
})
function changeStatus(data){
  callajax('http://localhost:3000/editor','post',JSON.stringify(data));
}
function callajax(ajaxurl,method,datasend){
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
