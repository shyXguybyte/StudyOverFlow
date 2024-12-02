using StudyOverFlow.API.Consts;

namespace StudyOverFlow.API.Model
{
    public class KanbanList
    {
        [Key]
        public int KanbanListId { get; set; }
        public string Title { get; set; } = CDatabase.KanBanDefaultName;
        public int ListOrder { get; set; }  
        public string UserId { get; set; } 
        public ApplicationUser User { get; set; }  
        public List<TodoKanbanList> TodoKanbanLists { get; set; }   
    }
}
