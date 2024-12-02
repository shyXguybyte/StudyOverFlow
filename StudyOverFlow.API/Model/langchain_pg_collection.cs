﻿namespace StudyOverFlow.API.Model
{
    public class langchain_pg_collection
    {
        [Key]
        public Guid uuid { get; set; }    
        public string Name { get; set; }    
        public JsonContent cmetadata { get; set; }   
        public List<langchain_pg_embedding> Embeddings { get; set; }  
    }
}
