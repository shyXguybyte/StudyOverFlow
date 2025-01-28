using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;
using StudyOverFlow.API.Services.Caching;
using System.Security.Claims;
using Task = StudyOverFlow.API.Model.Task;

namespace StudyOverFlow.API.Controllers;

[Route("api/[controller]")]
public class TaskController : Controller
{
    public ApplicationDbContext _dbcontext;
    private readonly IMapper _mapper;
   
    public TaskController(ApplicationDbContext dbcontext, IMapper mapper)
    {
        _dbcontext = dbcontext;
        _mapper = mapper;
    }

    [Authorize]
    [HttpGet("GetUserAllTasks")]
    public ActionResult<IEnumerable<TaskDto>> GetAllTasks()
    {
        var user = User.FindFirst(ClaimTypes.NameIdentifier);
        if (user is null)
        {
            return BadRequest();
        }
        string id = user.Value;
        var subjects = _dbcontext.Tasks
            .Where(c => c.UserId == id).ToList();

        return Ok(_mapper.Map<IEnumerable<TaskDto>>(subjects));
    }






    [Authorize]
    [HttpGet("GetOneUserTask")]
    public ActionResult<TaskDto> GetOneTask(int taskid)
    {

        var user = User.FindFirst(ClaimTypes.NameIdentifier);
        if (user is null)
        {
            return BadRequest();
        }
        string id = user.Value;


        var task = _dbcontext.Tasks.FirstOrDefault(c => c.UserId == id && c.TaskId == taskid);

        if (task is null)
            return NotFound("there is no Task with that name");
        return Ok(_mapper.Map<TaskDto>(task));
    }

    [Authorize]
    [HttpPost("EditTask")]
    public ActionResult EditTask(TaskDto model)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        if (model.TaskId is null)
            return BadRequest("Task Id should be provided to preform this operation");
        var user = User.FindFirst(ClaimTypes.NameIdentifier);
        if (user is null)
        {
            return BadRequest();
        }
        string id = user.Value;

        var task = _dbcontext.Tasks.FirstOrDefault(c => c.TaskId == model.TaskId);

        if (task is null)
            return BadRequest("there isn't any task with that id");

        task.Title = model.Title;
        task.Description = model.Description;
        task.IsChecked = model.IsChecked;

        _dbcontext.Update(task);
        _dbcontext.SaveChanges();
        return Ok();

    }











    [Authorize]
    [HttpPost("AddTaskToKanbanList")]
    public ActionResult AddTaskToKanbanList(int taskId, string KanbanListTitle, int? controlIndex = null)
    {
        var task = _dbcontext.Tasks.FirstOrDefault(c => c.TaskId == taskId);
        if (task is null)
            return BadRequest("their is no Task with that id");
        var Kanban = _dbcontext.KanbanLists.FirstOrDefault(c => c.Title == KanbanListTitle);
        if (Kanban is null)
            return BadRequest("their is no Kanban list with that title");
        var existpreivously = _dbcontext.TaskKanbanLists.AsNoTracking().FirstOrDefault(c => c.TaskId == taskId);
        if (existpreivously is not null)
        {
            _dbcontext.Remove(existpreivously);
            _dbcontext.SaveChanges();
            _dbcontext.TaskKanbanLists.Where(c => c.KanbanListId == existpreivously.KanbanListId && c.Index >= existpreivously.Index)
                .ExecuteUpdate(x => x.SetProperty(c => c.Index, e => e.Index - 1));
            _dbcontext.SaveChanges();
        }

        var taskkanbanlist = _dbcontext.TaskKanbanLists.Where(c => c.KanbanListId == Kanban.KanbanListId).ToList();
        var mainindex = (taskkanbanlist.Count() <= 0) ? 0 : taskkanbanlist.Max(c => c.Index);

        if (controlIndex is not null)
        {
            _dbcontext.TaskKanbanLists.Where(c => c.KanbanListId == Kanban.KanbanListId && c.Index >= controlIndex)
                .ExecuteUpdate(x => x.SetProperty(c => c.Index, e => e.Index + 1));
            _dbcontext.SaveChanges();
        }
        _dbcontext.TaskKanbanLists.Add(new TaskKanbanList()
        {
            KanbanListId = taskId,
            TaskId = taskId,
            Index = mainindex + 1
        });
        _dbcontext.SaveChanges();
        return Ok();
    }
    [Authorize]
    [HttpPost("RemoveTaskToKanbanList")]
    public ActionResult RemoveTaskToKanbanList(int taskId)
    {
        var task = _dbcontext.Tasks.FirstOrDefault(c => c.TaskId == taskId);
        if (task is null)
            return BadRequest("their is no Task with that id");

        var existpreivously = _dbcontext.TaskKanbanLists.AsNoTracking().FirstOrDefault(c => c.TaskId == taskId);
        if (existpreivously is not null)
        {
            _dbcontext.Remove(existpreivously);
            _dbcontext.SaveChanges();
            _dbcontext.TaskKanbanLists.Where(c => c.KanbanListId == existpreivously.KanbanListId && c.Index >= existpreivously.Index)
                .ExecuteUpdate(x => x.SetProperty(c => c.Index, e => e.Index - 1));
            _dbcontext.SaveChanges();
        }
        return Ok();
    }


    [Authorize]
    [HttpPost("CreateTaskForUser")]
    public ActionResult CreateTaskForUser(TaskDto model)
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

        _dbcontext.Add(_mapper.Map<Task>(model));

        _dbcontext.SaveChanges();
        return Ok("Task succesfully created");
    }

}