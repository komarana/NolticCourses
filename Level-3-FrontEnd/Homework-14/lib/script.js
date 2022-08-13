// Add your code here

window.onload = function () {
  let val = document.getElementById('val');
  let valueFrom = document.getElementById('valFrom');
  let valueTo = document.getElementById('valTo');
  let result = document.getElementsByClassName('convert_result')[0];

  function valid() {
    let num = Number(val.value);
    let text;
    if (isNaN(num)) {
      text = 'Invalid input. Please enter a number';
    } else if (num == "") {
      text = 'Enter a number';
    } else {
      text = null;
    } 
    document.getElementById('error').innerHTML = text;
  }

  function summ() {
    if (valueFrom.value === valueTo.value) {
      result.innerText = val.value;
    } else {
      result.innerHTML = (val.value * valueFrom.value) / valueTo.value;
    }
  }

  val.oninput = function () {
    summ(), valid();
  };
  valueFrom.onchange = function () {
    summ();
  };
  valueTo.onchange = function () {
    summ();
  };
};


