var serviceUrl = "https://flashplusplus.net/api/services/build/index.html";
var serviceId = "HPP-Service-Id";

var containerId = "";
var appId = "";
var serviceRef = null;

window.HPPServices = {};

window.HPPServices.init = (containerId, appId) =>
{
	this.containerId = containerId;
	this.appId = appId;

	window.addEventListener('message', function(e)
	{
		switch (e.data)
		{
			case "CLOSE_REQUEST": window.HPPServices.close();
		}
	})
}

window.HPPServices.open = () =>
{
	container = document.getElementById(containerId);

	if (serviceRef == null)
	{
		serviceRef = document.createElement("iframe");
		serviceRef.setAttribute("src", serviceUrl + "?appId=" + appId);
		serviceRef.setAttribute("id", serviceId);
		serviceRef.style.width = "100%";
		serviceRef.style.height = "100%";
		serviceRef.style.border = "none";
		//serviceRef.contentWindow.postMessage
	}

	container.appendChild(serviceRef);
}

window.HPPServices.close = () =>
{
	container = document.getElementById(containerId);

	container.removeChild(serviceRef);
}