using StudyOverFlow.API.Model;

namespace StudyOverFlow.API.DTOs.Manage;

public class TaskDto
{
    public int? TaskId { get; set; }
    public string Title { get; set; } = null!;
    public string Description { get; set; } = null!;
    public DateTime StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public bool IsChecked { get; set; }
    public string UserId { get; set; }
    public int? SubjectId { get; set; }
    public int? EventId { get; set; }
    public Event? Event { get; set; }

    public string? Massage { get; set; }
}