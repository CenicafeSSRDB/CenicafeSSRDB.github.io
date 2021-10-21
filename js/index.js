$(document).ready(function(){
  $.ajax({
    type: 'POST',
    url: 'php/cargar_listas.php'
    data: {'peticion': 'cargar_listas'}
  })
  .done(function(genomas){
    
  })
  .fail(fuction(){
    alert('Hubo un error al cargar las listas')
  })
})