using System.ComponentModel.DataAnnotations.Schema;

namespace StudyOverFlow.API.Model
{
  //  [Index(nameof(KanbanListId),nameof(TodoId))]
    public class TaskKanbanList
    {
      //  [Key, Column(Order = 0)]
        public int KanbanListId { get; set; }
        public KanbanList KanbanList { get; set; }  
      //  [Key, Column(Order = 1)]
        public int TaskId { get; set; } 
        public Task Task { get; set; }        
        public int Index { get; set; }  
    }
}
