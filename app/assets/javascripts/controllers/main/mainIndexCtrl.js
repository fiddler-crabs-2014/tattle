this.IndexCtrl = function($scope, $location) {

  $("#myform").on('submit', function(event) {
    event.preventDefault();
    var company = $('#myinput').val();
    $.ajax({
      url: '/search',
      type: "get",
      data: {company_name: company},
      dataType: 'json'
    }).success(function(data) {
      console.log(data);
    }).fail(function(){
      console.log("you suck at programming")
    })
  });

  $scope.nope = {
    posts: [
      {
        title: 'My first post',
        contents: "Lebowski ipsum it's all a goddamn fake. Like Lenin said, look for the person who will benefit. And you will, uh, you know, you'll, uh, you know what I'm trying to say. Dolor sit amet, consectetur adipiscing elit praesent ac magna justo pellentesque. Shomer shabbos. Ac lectus quis elit blandit. Goodnight, sweet prince. Fringilla a ut turpis. …which would place him high in the runnin' for laziest worldwide—but sometimes there's a man… sometimes there's a man. Praesent felis ligula, malesuada suscipit malesuada non, ultrices non urna sed orci."
      }, {
        title: 'A walk down memory lane',
        contents: "That is our most modestly priced receptacle. Lorem aliquam placerat posuere neque, at dignissim magna ullamcorper in. It's a complicated case, Maude. Lotta ins, lotta outs, lotta what-have-yous. Aliquam sagittis massa ac. This Chinaman is not the issue! Tortor ultrices faucibus curabitur eu mi sapien, ut ultricies. Every time a rug is micturated upon in this fair city, I have to compensate. Ipsum morbi eget risus nulla nullam vel nisi enim."
      }
    ]
  };

  return $scope.viewBrowse = function() {
    return $location.url('/browse');
  };

};

