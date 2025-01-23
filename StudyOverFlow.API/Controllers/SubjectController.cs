using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;
using System.Security.Claims;
namespace StudyOverFlow.API.Controllers;

[Route("api/[controller]")]
public class SubjectController : Controller
{
    public ApplicationDbContext _dbcontext;
    public IMapper _mapper;
    public SubjectController(ApplicationDbContext dbcontext, IMapper mapper)
    {
        _dbcontext = dbcontext;
        _mapper = mapper;
    }
    [Authorize]
    [HttpGet("GetUserSubjects")]
    public ActionResult<IEnumerable<SubjectDto>> GetAllSubjects()
    {
        var user = User.FindFirst(ClaimTypes.NameIdentifier);
        if (user is null)
        {
            return BadRequest();
        }
        string id = user.Value;
        var subjects = _dbcontext.Subjects.Include(c=>c.MaterialObjs)
            .Include(c=>c.Tasks)
            .Include(c=>c.Notes)
            .Where(c=>c.UserId == id).ToList(); 

        return Ok(_mapper.Map<IEnumerable<SubjectDto>>(subjects));  
    }
    [Authorize]
    [HttpGet("GetOneUserSubject")]
    public ActionResult<Subject> GetOneSubject(int subjectid)
    {
        var user = User.FindFirst(ClaimTypes.NameIdentifier);
        if (user is null)
        {
            return BadRequest();
        }
        string id = user.Value;
        var subject = _dbcontext.Subjects.Include(c => c.MaterialObjs)
            .Include(c => c.Tasks)
            .Include(c => c.Notes)
            .FirstOrDefault(c => c.UserId == id && c.SubjectId == subjectid);

        return Ok(_mapper.Map<SubjectDto>(subject));
    }



    [Authorize]
    [HttpPost("CreateSubjectForUser")]
    public ActionResult CreateSubject(SubjectDto subject)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        var user = User.FindFirst(ClaimTypes.NameIdentifier);
        if (user is null)
        {
            return BadRequest();
        }
        string id = user.Value;

        _dbcontext.Subjects.Add(new Subject { 
            
            Title = subject.Title,  
            Description = subject.Description,  
            UserId=id,
            IsChecked=subject.IsChecked,
            StartDate=subject.StartDate  ,    
            EndDate=subject.EndDate
            
        });

        _dbcontext.SaveChanges();
        return Ok("Subject has been add successfuly");
    }
}