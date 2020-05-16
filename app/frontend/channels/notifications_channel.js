import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {

  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // Called when there's incoming data on the websocket for this channel
  received(data) {
    const rublesAmount = document.getElementById('rubles_amount');
    rublesAmount.insertAdjacentHTML('beforeend', data.amount);
  }
});
