using Microsoft.VisualBasic;
using Pgvector;
using System.Numerics;
using Pgvector.EntityFrameworkCore;
namespace StudyOverFlow.API.Model
{
    public class langchain_pg_embedding
    {
        [Key]
        public Guid uuid { get; set; }    
        public Guid Collection_id { get; set; }
        public langchain_pg_collection Collection { get; set; }
        public Pgvector.Vector? embedding { get; set; }
        public string Document { get; set; }
        public JsonContent cmetadata { get; set; }
        public string UserId { get; set; }  
        public ApplicationUser User { get; set; }   


    }
}
