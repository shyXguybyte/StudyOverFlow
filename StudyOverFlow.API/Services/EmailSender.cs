
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Options;
using PostmarkDotNet.Model;
using PostmarkDotNet;
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

        //public async Task SendEmailAsync(string email, string subject, string htmlMessage)
        //{
        //    var message = new PostmarkMessage()
        //    {
        //        To = _webHostEnvironment.IsDevelopment() ? "test@blackhole.postmarkapp.com" : email,
        //        From = "cds.faresahmed23247@alexu.edu.eg",
        //        TrackOpens = true,
        //        Subject = subject,
        //        HtmlBody = htmlMessage
        //    };

        //    var client = new PostmarkClient("0aad2477-e58c-4c87-a529-4eadae49a948");
        //    //SmtpClient smtpClient = new SmtpClient(_mailSettings.Host)
        //    //{
        //    //    Port = _mailSettings.Port,
        //    //    UseDefaultCredentials = false,
        //    //    Credentials = new NetworkCredential(_mailSettings.Email, _mailSettings.Password),
        //    //    EnableSsl = true,

        //    //};
        //    var sendResult = await client.SendMessageAsync(message);
        //  //  await smtpClient.SendMailAsync(message);
        //    //smtpClient.Dispose();



        //}






        public async Task SendEmailAsync(string email, string subject, string htmlMessage)
        {
            MailMessage message;
            if (_webHostEnvironment.IsDevelopment())
            {
                message = new MailMessage()
                {

                    From = new MailAddress(_mailSettings.Email!, _mailSettings.DisplayName),
                    Body = htmlMessage,
                    Subject = subject,
                    IsBodyHtml = true,

                };
            }
            else
            {
                message = new MailMessage()
                {

                    From = new MailAddress(Environment.GetEnvironmentVariable("MailSettingsEmail")!, _mailSettings.DisplayName),
                    Body = htmlMessage,
                    Subject = subject,
                    IsBodyHtml = true,

                };
            }

            message.To.Add(_webHostEnvironment.IsDevelopment() ? "faresahmed687@gmail.com" : email);

            SmtpClient smtpClient;
            if (_webHostEnvironment.IsDevelopment())
            {
                smtpClient = new SmtpClient(_mailSettings.Host)
                {
                    Port = _mailSettings.Port,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(_mailSettings.Email, _mailSettings.Password),
                    EnableSsl = true,

                };
            }
            else
            {
                smtpClient = new SmtpClient(_mailSettings.Host)
                {
                    Port = _mailSettings.Port,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(Environment.GetEnvironmentVariable("MailSettingsEmail"), Environment.GetEnvironmentVariable("MailSettingsPass")!),
                    EnableSsl = true,

                };
            }

            await smtpClient.SendMailAsync(message);
            smtpClient.Dispose();



        }

        //Task IEmailSender.SendEmailAsync(string email, string subject, string htmlMessage)
        //{
        //    throw new NotImplementedException();
        //}
    }
}
