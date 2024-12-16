using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;

namespace StudyOverFlow.API.Controllers
{

    [Route("api/[controller]")]
    public class NoteController : Controller
    {
        public ApplicationDbContext _dbcontext;
        public NoteController(ApplicationDbContext dbcontext)
        {
            _dbcontext = dbcontext;
        }
        //[HttpPost()]

        //public ActionResult<IEnumerable<Note>> AddNoteToDate(int tagId)
        //{
        //    _dbcontext.Add(new TaskKanbanList());
        //    _dbcontext.SaveChanges();   
        //}

            [HttpGet("Notes")]
        public ActionResult<IEnumerable<Note>> GetAllNotes(string mk)
        {
            var notes = _dbcontext.Notes.ToList()
                .Select(c=>new  NoteDto{ text = c.text ,DateTime= c.DateTime}).ToList(); 

            
            if(mk is null || mk.Length < 2)
            {
                return BadRequest();
            }

            return Ok(notes);   
 
                
        
        }
        //public IActionResult Index()
        //{
        //    return View();
        //}




    }
}
