namespace StudyOverFlow.API.Model
{
    public class ToDoTag
    {
        [Key]
        public int TagId { get; set; } 
        public Tag Tag { get; set; } = null!;
        [Key]
        public int TodoId { get; set; }
        public Todo Todo { get; set; }  =null!;
    }
}
