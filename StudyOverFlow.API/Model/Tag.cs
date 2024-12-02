namespace StudyOverFlow.API.Model
{
    public class Tag
    {
        [Key]
        public int TagId { get; set; }
        public string Name { get; set; } = null!;
        public string Color { get; set; } = null!;
        public string? type { get; set; }   
        public List<ToDoTag> ToDoTags { get; set; } 
        

    }
}
