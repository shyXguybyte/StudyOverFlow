using AutoMapper;
using StudyOverFlow.API.DTOs.Account;
using StudyOverFlow.API.DTOs.Manage;
using StudyOverFlow.API.Model;

namespace StudyOverFlow.API.Profile
{
    public class MappingProfile : AutoMapper.Profile
    {
        public MappingProfile()
        {
            CreateMap<RegisterDto, ApplicationUser>()
                .ForMember(Dest =>Dest.Email , src=>src.MapFrom(c=>c.Email))
                .ForMember(Dest => Dest.FirstName, src => src.MapFrom(c => c.FirstName))
                .ForMember(Dest => Dest.LastName, src => src.MapFrom(c => c.LastName))
                .ForMember(Dest => Dest.UserName, src => src.MapFrom(c => c.UserName))
                .ForMember(Dest => Dest.PhoneNumber, src => src.MapFrom(c => c.Phone))
                ;

            CreateMap<Model.Task, TaskDto>()
            
                .ReverseMap();

            CreateMap<EventDto,Event>().ReverseMap();
            CreateMap<Model.Note, NoteDto>()
                .ForMember(dest => dest.Text, src=>src.MapFrom(c=>c.text))
                .ReverseMap();
            //CreateMap<Model.Subject, SubjectDto>().ReverseMap();   
            CreateMap<Subject, SubjectDto>()
           .AfterMap((src, dest, context) =>
           {
               // Map Tasks if they exist
               if (src.Tasks != null)
               {
                   dest.Tasks = src.Tasks.Select(task => context.Mapper.Map<TaskDto>(task)).ToList();
               }

               // Map Notes if they exist
               if (src.Notes != null)
               {
                   dest.Notes = src.Notes.Select(note =>
                   {
                       var noteDto = context.Mapper.Map<NoteDto>(note);
                       noteDto.SubjectId = src.SubjectId;  // Ensure SubjectId is set
                       return noteDto;
                   }).ToList();
               }

               // Map MaterialObjs if they exist
               if (src.MaterialObjs != null)
               {
                   dest.MaterialObjs = src.MaterialObjs.Select(obj => context.Mapper.Map<MaterialObjDto>(obj)).ToList();
               }
           })
           .ForMember(dest => dest.Massage, opt => opt.Ignore());









         
        }
    }
}
