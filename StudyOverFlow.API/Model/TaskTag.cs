using System.ComponentModel.DataAnnotations.Schema;

namespace StudyOverFlow.API.Model
{
    public class TaskTag
    {
        
        public int TagId { get; set; } 
        public Tag Tag { get; set; } = null!;
        
        public int TaskId { get; set; }
        public Task Task { get; set; }  =null!;
    }
}
