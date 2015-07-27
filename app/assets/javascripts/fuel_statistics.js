$(document).on('focusout', '#transaction_amount',function(evt) {
  var price = $('#price_litre').val();
  var new_mileage = $('#transaction_supplier').val();
  var old_mileage = $('#transaction_mileage').val();
  var covered = new_mileage - old_mileage
  var amount = $('#transaction_amount').val();
  var mpg = calculateMpg(amount, covered,price);
  $('#mpg').val(mpg);
});

function calculateMpg(amount, miles_covered,cost_litre) {
  var conv_to_gal = 0.21977
  var litres_used = amount / cost_litre
  var gallons_used = litres_used * conv_to_gal
  return miles_covered / gallons_used
}
