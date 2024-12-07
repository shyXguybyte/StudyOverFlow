﻿using System.ComponentModel.DataAnnotations;

namespace StudyOverFlow.API.DTOs.Account
{
    public class LoginDto
    {
        [Required (ErrorMessage = "Email is required")]
        public string UserName { get; set; }
        [Required  (ErrorMessage = "Password is required")]
        public string Password { get; set; }
    }
}
