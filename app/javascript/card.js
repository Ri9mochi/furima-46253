const pay = () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const postalCode = document.getElementById("postal-code").value;
    const prefectureId = document.getElementById("prefecture").value;
    
    if (postalCode === "" || prefectureId === "1") {
      form.submit();
      return;
    }
    
    form.querySelector('input[type="submit"]').disabled = true;
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        form.querySelector('input[type="submit"]').disabled = false;
      } else {
        const token = response.id;
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        form.submit();
      }
    });
  });
};

document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);