namespace StudyOverFlow.API.Model
{
    public class Note
    {
        [Key]
        public int NoteId { get; set; } 
        public string text { get;set; }
        public DateTime DateTime { get; set; }
        public int? TaskId { get;set; }  
        public Task? Task { get; set; }  
        public int? SubjectId {  get; set; } 
        public Subject? Subject { get; set; }    
    }
}
