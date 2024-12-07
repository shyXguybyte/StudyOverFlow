using System.ComponentModel.DataAnnotations.Schema;

namespace StudyOverFlow.API.Model
{
    public class Subject
    {
        [Key]
        public int SubjectId { get; set; }
        public string Description { get; set; } = null!;
        public DateTime StartDate { get; set; } 
        public DateTime EndDate { get; set; }   
        public bool IsChecked { get; set; }
        
        public string UserId { get; set; }
        public ApplicationUser User { get; set; }
        public List<Task> Tasks { get; set; }
        public List<Note> Notes { get; set; }   
        public List<MaterialObj> MaterialObjs { get; set; }
        public List<Event> Events { get; set; }
    }
}
