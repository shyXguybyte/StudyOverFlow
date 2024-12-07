namespace StudyOverFlow.API.Model
{
    public class MaterialObj
    {
        [Key]
        public int MaterialId { get; set; }
        public string Name { get; set; } = null!;

        public DateTime Date { get; set; }      
        public string? Type { get; set; }
        public double? size { get; set; }
        public int? TaskId { get; set; }    
        public Task? Task { get; set; } 
        public int? SubjectId { get; set; }     
        public Subject? Subject { get; set; }    
    }
}
