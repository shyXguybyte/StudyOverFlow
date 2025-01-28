using StudyOverFlow.API.Model;
using System.Text.Json.Serialization;

namespace StudyOverFlow.API.DTOs.Manage
{
    public class NoteDto
    {

        public int? NoteId { get; set; }
        public string Text { get; set; }

       

        public int? TaskId { get; set; }
      
        public int? SubjectId { get; set; }

    }
}
