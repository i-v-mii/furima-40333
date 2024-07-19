function setupPriceCalculation() {
  if (document.getElementById('item-price') != null) {
    const priceInput = document.getElementById("item-price");
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    priceInput.addEventListener("input", () => {
      const inputValue = document.getElementById("item-price").value;
      let tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = tax.toLocaleString();
      let profit = inputValue - tax;
      profitDom.innerHTML = profit.toLocaleString();
    });
  }
}

window.addEventListener("turbo:load", setupPriceCalculation);

document.addEventListener("turbo:render", setupPriceCalculation);