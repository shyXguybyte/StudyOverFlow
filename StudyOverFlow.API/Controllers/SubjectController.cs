using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;
namespace StudyOverFlow.API.Controllers;

[Route("api/[controller]")]
public class SubjectController : Controller
{
    public ApplicationDbContext _dbcontext;
    public SubjectController(ApplicationDbContext dbcontext)
    {
        _dbcontext = dbcontext;
    }
    
    [HttpGet("Get")]
    public ActionResult<IEnumerable<Note>> GetAllSubjects(string mk)
    {
        var subjects = _dbcontext.Subjects.ToList()
            .Select(c=>new  SubjectDto(){ text = c.Title}).ToList(); 

        return Ok(subjects);  
    }

    [HttpPost("Set")]
    public ActionResult<IEnumerable<Note>> CreateSubject()
    {
        var subject = _dbcontext.Subjects.Add(new Subject());
        _dbcontext.SaveChanges();
        return Ok(subject);
    }
}