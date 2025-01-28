using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudyOverFlow.API.Data;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;
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
        public ActionResult AddEvent([FromBody] EventDto model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
          
            
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
                    UserId = FindUser.Id,
                    Duration = "2",
                    start = new TimeOnly(8, 0),
                    End = new TimeOnly(23, 59)

                });
                _dbcontext.SaveChanges();
                calender = record.Entity;
            }
            calender = FindUser.Calendar!;
          
            if (!_dbcontext.Colors.Select(c => c.ColorId).Contains(model.ColorId))
                return BadRequest("color don't exits in the current context.");
            if (model.TotalCount.HasValue && model.TotalCount > 0)
            {
                for (int i = 0; i < model.TotalCount; i++)
                {
                    var Event = _mapper.Map<Model.Event>(model);
                    Event.Date = Event.Date.ToUniversalTime().AddDays(7 * i);
                    Event.CalendarId = calender.CalendarId;

                    _dbcontext.Add(Event);
                    _dbcontext.SaveChanges();
                }

                return Ok();
            }
            var mEvent = _mapper.Map<Model.Event>(model);
            mEvent.Date = mEvent.Date.ToUniversalTime();
            mEvent.CalendarId = calender.CalendarId;
            _dbcontext.Add(mEvent);
            _dbcontext.SaveChanges();
            return Ok();

        }

        [Authorize]
        [HttpGet("GetAllEvents")]
        public ActionResult<IEnumerable<EventDto>> GetAllEvents()
        {

            var user = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            if (user is null)
                return BadRequest();
            var FindUser = _dbcontext.Users.Include(c => c.Calendar)
                .ThenInclude(c => c.Events)
               .FirstOrDefault(c => c.Id == user.Value);
            if (FindUser is null)
                return BadRequest();
            var Events = _mapper.Map<List<EventDto>>(FindUser.Calendar.Events);
            return Ok(Events);

        }


        [Authorize]
        [HttpGet("GetCurrentWeekEvents/{currentDate?}")]
        public ActionResult<IEnumerable<Model.Event>> GetCurrentWeekEvents(DateTime? currentDate = null)
        {
            currentDate ??= DateTime.UtcNow;
            // Calculate the start of the week (previous Saturday)
            int daysToSubtract = (currentDate.Value.DayOfWeek - DayOfWeek.Saturday + 7) % 7;
            DateTime startOfWeek = currentDate.Value.AddDays(-daysToSubtract).Date.ToUniversalTime(); // Midnight of Saturday

            // Calculate the end of the week (next Friday)
            DateTime endOfWeek = startOfWeek.AddDays(6).Date.ToUniversalTime(); // Midnight of Friday

            // Filter tasks where Date is between start and end (inclusive)
            return _dbcontext.Events.Where(t => (t.Date.Date >= startOfWeek && t.Date.Date <= endOfWeek) || t.TotalCount == null).ToList();
        }


        [Authorize]
        [HttpPut("EditEvent")]
        public ActionResult EditEvent([FromBody] EventDto model)
        {
            if (model.EventId is null)
            {
                ModelState.AddModelError("Event Id", "Event Id not exist in the current request.");
            }
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var user = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);
            if (user is null)
                return BadRequest();
            var FindUser = _dbcontext.Users.AsNoTracking().Include(c => c.Calendar)
                .ThenInclude(c => c.Events).FirstOrDefault(c => c.Id == user!.Value);
            if (FindUser is null)
                return NotFound();
            if (FindUser.Calendar is null)
                return NotFound();


            var Event = FindUser.Calendar.Events.FirstOrDefault(c => c.EventId == model.EventId);
            if (Event is null)
                return NotFound();
            if (!_dbcontext.Colors.Select(c => c.ColorId).Contains(model.ColorId))
                return BadRequest("color don't exits in the current context.");
            _mapper.Map(model, Event);

            _dbcontext.Update(Event);
            _dbcontext.SaveChanges();
            return Ok();


        }

    }
}
