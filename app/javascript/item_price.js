const price = () => {
  const priceInput = document.getElementById("item-price");
  const taxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput || !taxPrice || !profit) return; // 要素がなければ終了

  priceInput.addEventListener("input", () => {
    let inputValue = priceInput.value.replace(/[^0-9]/g, ""); // 半角数字のみ
    inputValue = parseInt(inputValue, 10) || 0; // 数値変換

    if (inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.1);
      const revenue = inputValue - tax;

      taxPrice.innerHTML = tax.toLocaleString();
      profit.innerHTML = revenue.toLocaleString();
    } else {
      taxPrice.innerHTML = "0";
      profit.innerHTML = "0";
    }
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);