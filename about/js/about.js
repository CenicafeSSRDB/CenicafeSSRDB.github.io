  function genChange(gen){
    document.getElementById('hv1').innerHTML = "Hemileia vastatrix - " + gen;
    genValues=document.getElementsByClassName('pag2');
    meanContent=document.getElementsByClassName('place');
    
    var H1 = ["547Mb", "5469", "2%"];
    var H2 = ["XXXMb", "XXXX", "X%"];
    
    var boxT = " "
    
    if(gen=='HV-XXXIII'){
    
      for (i = 0; i < genValues.length; i++){
        boxT = genValues[i].getElementsByTagName('h1')
        boxT[0].innerHTML = H1[i];
      }
      
      var pie=document.getElementById('htmlwidget-21b323315c11bd3f6dda');
      
    }else if(gen=='HVCENICAFE'){
      
      for (i = 0; i < genValues.length; i++){
        boxT = genValues[i].getElementsByTagName('h1')
        boxT[0].innerHTML = H2[i];
      }
      
      var pie=document.getElementById('htmlwidget-21b323315c11bd3f6dda');
      var bars=document.getElementById('htmlwidget-6ff8b0eff05f35a17a2e');
      
    }
    
  }
 /* function initial(gen){
    utilizar esta funcion con el onload del body, para que se carguen los datos iniciales del primer genoma
  }*/