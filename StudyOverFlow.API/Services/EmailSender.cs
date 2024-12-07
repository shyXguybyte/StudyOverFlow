
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Options;
using StudyOverFlow.API.settings;
using System.Net;
using System.Net.Mail;

namespace StudyOverFlow.API.Services
{
    public class EmailSender : IEmailSender
    {
        private readonly MailSettings _mailSettings;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public EmailSender(IOptions<MailSettings> mailSettings, IWebHostEnvironment webHostEnvironment = null)
        {
            _mailSettings = mailSettings.Value;
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task SendEmailAsync(string email, string subject, string htmlMessage)
        {

            MailMessage message = new MailMessage()
            {
                From = new MailAddress(_mailSettings.Email!, _mailSettings.DisplayName),
                Body = htmlMessage,
                Subject = subject,
                IsBodyHtml = true

            };
            message.To.Add(_webHostEnvironment.IsDevelopment() ? "faresahmed687@gmail.com" : email);
            SmtpClient smtpClient = new SmtpClient(_mailSettings.Host)
            {
                Port = _mailSettings.Port,
                Credentials = new NetworkCredential(_mailSettings.Email, _mailSettings.Password),
                EnableSsl = true
            };
            await smtpClient.SendMailAsync(message);
            smtpClient.Dispose();



        }

        //Task IEmailSender.SendEmailAsync(string email, string subject, string htmlMessage)
        //{
        //    throw new NotImplementedException();
        //}
    }
}
