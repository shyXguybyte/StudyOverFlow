namespace StudyOverFlow.API.Model
{
    public class Color
    {
        [Key]
        public int ColorId { get; set; }    
        public string HexCode { get; set; } 
        public List<Tag> Tags { get; set; } 
        public List<Event> Events { get; set; } 
    }
}
