using Microsoft.AspNetCore.Identity;

namespace StudyOverFlow.API.Model
{
    public class ApplicationUser:IdentityUser
    {
        public string FirstName { get; set; }   
        public string LastName { get; set; }    
        public List<Subject> Subjects { get; set; }
        public List<Todo> Todos { get; set; }
        public List<KanbanList> KanbanLists { get; set; }
        public List<langchain_pg_embedding> Embeddings { get; set; }   
    }
}
