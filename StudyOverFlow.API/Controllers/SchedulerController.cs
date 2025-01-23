using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Services.Caching;
using System.Globalization;
using System.Security.Claims;

namespace StudyOverFlow.API.Controllers
{
    [Route("api/[controller]")]
    public class SchedulerController : ControllerBase
    {
        private readonly ApplicationDbContext _dbcontext;
        private readonly IMapper _mapper;
        private readonly IRedisCacheService _cache;
        public SchedulerController(ApplicationDbContext dbcontext, IMapper mapper, IRedisCacheService cache)
        {
            _dbcontext = dbcontext;
            _mapper = mapper;
            _cache = cache;
        }
        [Authorize]
        [HttpPost("AddEvent")]
        public ActionResult AddEvent(EventDto model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var Event = _mapper.Map<Model.Event>(model);
            var user = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            if (user is null)
                return BadRequest();

            var FindUser = _dbcontext.Users.Include(c => c.Calendar)
                .FirstOrDefault(c => c.Id == user.Value);
            if (FindUser is null)
                return BadRequest();
            Model.Calendar calender;
            if (FindUser.Calendar is null)
            {
                var record = _dbcontext.Calendars.Add(new Model.Calendar()
                {
                    Duration = "2",
                    start = new TimeOnly(8, 0),
                    End = new TimeOnly(20, 0)

                });
                _dbcontext.SaveChanges();
                calender = record.Entity;
            }
            calender = FindUser.Calendar!;
            Event.CalendarId = calender.CalendarId;
            _dbcontext.Add(calender);
            _dbcontext.SaveChanges();
            return Ok();

        }

        [Authorize]
        [HttpPost("GetAllEvents")]
        public ActionResult<IEnumerable<EventDto>> GetAllEvents()
        {
            var user = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            if (user is null)
                return BadRequest();
            var FindUser = _dbcontext.Users.Include(c => c.Calendar)
                .ThenInclude(c=>c.Events)
               .FirstOrDefault(c => c.Id == user.Value);
            if (FindUser is null)
                return BadRequest();
            var Events = _mapper.Map<IEnumerable<EventDto>>(FindUser.Calendar.Events);
            return Ok(Events);  

        }


        [Authorize]
        [HttpPut("EditEvent")]
        public ActionResult EditEvent(EventDto model)
        {
            if(model.EventId is null)
            {
                ModelState.AddModelError("Event Id","Event Id not exist in the current request.");
            }
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var user = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            if (user is null)
                return BadRequest();
            var FindUser = _dbcontext.Users.AsNoTracking().Include(c => c.Calendar)
                .ThenInclude(c => c.Events).FirstOrDefault(c=>c.Id == user!.Value);
            if (FindUser is null)
                return NotFound();
            if (FindUser.Calendar is null)
                return NotFound();


            var Event = FindUser.Calendar.Events.FirstOrDefault(c => c.EventId == model.EventId);
            if(Event is null)
                return NotFound();
            _mapper.Map(model, Event);
            _dbcontext.Update(Event);
            _dbcontext.SaveChanges();
            return Ok();

            
        }

    }
}
