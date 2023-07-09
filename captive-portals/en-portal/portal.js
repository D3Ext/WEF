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
					alert("The password must be at least 8 characters");
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

