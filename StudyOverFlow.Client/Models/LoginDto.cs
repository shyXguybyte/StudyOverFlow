using System.ComponentModel.DataAnnotations;

namespace StudyOverFlow.Client.Models
{
    public class LoginDto
    {
        [Required (ErrorMessage = "Email is required")]
        public string UserName { get; set; }
        [Required  (ErrorMessage = "Password is required")]
        public string Password { get; set; }
    }
}
