

namespace StudyOverFlow.API.Services
{
	public interface IEmailBodyBuilder
	{
		public string EmailBody(string imageurl,string header,string body,string? url ,string linkTitle);
		public string EmailBodyConfirm(string imageurl, string header, string bodys);

    }
}
