const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  // 購入フォームが存在しないページでは処理しない
  const form = document.getElementById('charge-form');
  if (!form) return;

  // DOM要素が存在するかチェック
  const numberForm = document.getElementById('number-form');
  const expiryForm = document.getElementById('expiry-form');
  const cvcForm = document.getElementById('cvc-form');

  if (!numberForm || !expiryForm || !cvcForm) {
    return;
  }

  // 各入力フィールドを作成してマウント
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // フォーム送信時の処理
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        alert("カード情報に誤りがあります。ご確認ください。");
      } else {
        const token = response.id;

        // トークンをフォームに埋め込み
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);

        // カード情報をリセット
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        // フォーム送信
        form.submit();
      }
    });
  });
};

// Turbo対応
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);