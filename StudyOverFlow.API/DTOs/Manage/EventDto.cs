using StudyOverFlow.API.Model;

namespace StudyOverFlow.API.DTOs.Manage
{
    public class EventDto
    {

        public int? EventId { get; set; }
        public string? Description { get; set; }
        public int? TotalCount { get; set; }
        public int? CurrentCount { get; set; } = 0;
        public Day Day { get; set; }
        public TimeOnly StartTime { get; set; }
        public TimeOnly EndTime { get; set; }
        public int? SubjectId { get; set; }

        public int? TagId { get; set; }
        public int? KanbanListId { get; set; }
        public int ColorId { get; set; }
    }
}
