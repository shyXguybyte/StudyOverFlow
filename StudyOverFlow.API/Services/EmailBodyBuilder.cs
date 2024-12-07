
using Microsoft.AspNetCore.Hosting;
using System.Text.Encodings.Web;

namespace StudyOverFlow.API.Services
{
	public class EmailBodyBuilder : IEmailBodyBuilder
	{
		private readonly IWebHostEnvironment _webHostEnvironment;

		public EmailBodyBuilder(IWebHostEnvironment webHostEnvironment)
		{
			_webHostEnvironment = webHostEnvironment;
		}

		public string EmailBody( string imageurl, string header, string bodys, string? url, string linkTitle)
		{
			var filePath = $"{_webHostEnvironment.WebRootPath}/assats/templates/email.html";
			StreamReader reader = new StreamReader(filePath);
			var body = reader.ReadToEnd();
			reader.Close();
			body = body
				  .Replace("[imageUrl]", imageurl)
				  .Replace("[header]", header)
				  .Replace("[body]", bodys)
				  .Replace("[url]", url)
				  .Replace("[linkTitle]", linkTitle) ;
			return body;
		}
        public string EmailBodyConfirm(string imageurl, string header, string bodys)
        {
            var filePath = $"{_webHostEnvironment.WebRootPath}/assats/templates/confirememail.html";
            StreamReader reader = new StreamReader(filePath);
            var body = reader.ReadToEnd();
            reader.Close();
            body = body
                  .Replace("[imageUrl]", imageurl)
                  .Replace("[header]", header)
                  .Replace("[body]", bodys);
            return body;
        }
    }
}
