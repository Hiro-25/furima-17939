document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // 要素がない場合は処理を中断

  const taxArea = document.getElementById("add-tax-price");
  const profitArea = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value, 10);

    if (isNaN(inputValue) || inputValue < 300 || inputValue > 9999999) {
      taxArea.innerHTML = "0";
      profitArea.innerHTML = "0";
      return;
    }

    const tax = Math.floor(inputValue * 0.1); // 10%の販売手数料
    const profit = inputValue - tax; // 利益

    taxArea.innerHTML = tax.toLocaleString(); // カンマ区切りで表示
    profitArea.innerHTML = profit.toLocaleString();
  });
});
