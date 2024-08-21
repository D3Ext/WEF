(function() {

	var onLoad = function() {
		var formElement = document.getElementById("loginform");
		if (formElement != null) {
			var password = document.getElementById("password");
			var showpass = function() {
				password.setAttribute("type", password.type == "text" ? "password" : "text");
			}
			document.getElementById("showpass").addEventListener("click", showpass);
			document.getElementById("showpass").checked = false;

			var validatepass = function() {
				if (password.value.length < 8) {
					alert("Ο κωδικός πρόσβασης πρέπει να αποτελείται από τουλάχιστον 8 χαρακτήρες");
				}
				else {
					formElement.submit();
				}
			}
			document.getElementById("formbutton").addEventListener("click", validatepass);
		}
	};

	document.readyState != 'loading' ? onLoad() : document.addEventListener('DOMContentLoaded', onLoad);
})();

function redirect() {
	document.location = "index.htm";
}

