namespace StudyOverFlow.API.Model
{
    public class Note
    {
        [Key]
        public int NoteId { get; set; } 
        public string text { get;set; }
        public DateTime DateTime { get; set; }
        public int? TodoId { get;set; }  
        public Todo? Todo { get; set; }  
        public int? SubjectId {  get; set; } 
        public Subject? Subject { get; set; }    
    }
}
