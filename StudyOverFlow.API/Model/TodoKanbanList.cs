namespace StudyOverFlow.API.Model
{
    public class TodoKanbanList
    {
        [Key]
        public int KanbanListId { get; set; }
        public KanbanList KanbanList { get; set; }  
        [Key]
        public int TodoId { get; set; } 
        public Todo Todo { get; set; }        
        public int Index { get; set; }  
    }
}
