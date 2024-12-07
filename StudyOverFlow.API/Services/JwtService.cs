using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.Model;
using Microsoft.Extensions.Options;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;

namespace StudyOverFlow.API.Services
{
    public class JwtService
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly JWT _jwt;



        //private readonly IConfiguration _config;
        //private SymmetricSecurityKey _jwtKey;
        //private readonly ApplicationDbContext _context;
        public JwtService(IConfiguration config, ApplicationDbContext context , UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager, IOptions<JWT> jwt)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _jwt = jwt.Value;
            //_context = context;
            //_config = config;
            //_jwtKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["JWT:Key"]));

        }
        //public string CreateJwt(ApplicationUser user, IList<string> userRole)
        //{
        //    List<Claim> userClaims = GetClaim(user, userRole);
        //    var credentials = new SigningCredentials(_jwtKey, SecurityAlgorithms.HmacSha256Signature);
        //    var tokenDescriptor = new SecurityTokenDescriptor
        //    {
        //        Subject = new ClaimsIdentity(userClaims),
        //        Expires = DateTime.UtcNow.AddDays(int.Parse(_config["JWT:ExpiresInDays"])),
        //        SigningCredentials = credentials,
        //        Issuer = _config["JWT:Issuer"]
        //    };
        //    var tokenHandler = new JwtSecurityTokenHandler();
        //    var jwt = tokenHandler.CreateToken(tokenDescriptor);
        //    return tokenHandler.WriteToken(jwt);
        //}


        public async Task<string> CreateJwt(ApplicationUser user)
        {
            var userClaims = await _userManager.GetClaimsAsync(user);
            var roles = await _userManager.GetRolesAsync(user);
            var roleClaims = new List<Claim>();

            foreach (var role in roles)
                roleClaims.Add(new Claim("roles", role));

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim("uid", user.Id)
            }
            .Union(userClaims)
            .Union(roleClaims);

            var symmetricSecurityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwt.Key));
            var signingCredentials = new SigningCredentials(symmetricSecurityKey, SecurityAlgorithms.HmacSha256);

            var jwtSecurityToken = new JwtSecurityToken(
                issuer: _jwt.Issuer,
                audience: _jwt.Audience,
                claims: claims,
                expires: DateTime.Now.AddDays(_jwt.DurationInDays),
                signingCredentials: signingCredentials);
            var tokenHandler = new JwtSecurityTokenHandler();
           return  tokenHandler.WriteToken(jwtSecurityToken);   
           // jwtSecurityToken;
        }



        //#region Private Helper Method
        //private List<Claim> GetClaim(User user, IList<string> userRole)
        //{
        //    var claims = new List<Claim>
        //    {
        //        new Claim(ClaimTypes.NameIdentifier, user.Id),
        //    };
        //    foreach (var role in userRole)
        //    {
        //        claims.Add(new Claim(ClaimTypes.Role, role));
        //    }

        //    return claims;
        //}
        //#endregion
    }
}
