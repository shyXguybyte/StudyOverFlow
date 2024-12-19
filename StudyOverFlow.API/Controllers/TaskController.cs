using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;
using Task = StudyOverFlow.API.Model.Task;

namespace StudyOverFlow.API.Controllers;

[Route("api/[controller]")]
public class TaskController : Controller
{
    public ApplicationDbContext _dbcontext;
    public TaskController(ApplicationDbContext dbcontext)
    {
        _dbcontext = dbcontext;
    }
    
    [HttpGet("Get")]
    public ActionResult<IEnumerable<Note>> GetAllTasks(string mk)
    {
        var tasks = _dbcontext.Notes.ToList()
            .Select(c=>new  TaskDto(){ text = c.text ,DateTime= c.DateTime}).ToList(); 

        return Ok(tasks);  
    }
    
    [HttpPost("Set")]
    public ActionResult<IEnumerable<Note>> CreateTask()
    {
        var task = _dbcontext.Tasks.Add(new Task());
        _dbcontext.SaveChanges();   
        return Ok(task);
    }
    
}