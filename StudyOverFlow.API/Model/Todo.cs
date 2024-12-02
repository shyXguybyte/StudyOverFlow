namespace StudyOverFlow.API.Model
{
    public class Todo
    {
        [Key]
        public int TodoId { get; set; }
        public string Title { get; set; } = null!;
        public string Description { get; set; } = null!;
        public DateTime StartDate { get; set; } 
        public DateTime EndDate { get; set; } 
        public bool IsChecked { get; set; }
        public string UserId { get; set; }
        public ApplicationUser User { get; set; }   
        public int? SubjectId { get; set; }  
        public Subject? Subject { get; set; }
        public List<Note> Notes { get; set; }
        public List<MaterialObj> MaterialObjs { get; set; }
        public List<ToDoTag> ToDoTags { get; set; }
        public List<TodoKanbanList> TodoKanbanLists { get; set; }
    }
}
