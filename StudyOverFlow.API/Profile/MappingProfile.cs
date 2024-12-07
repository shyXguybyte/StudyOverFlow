using AutoMapper;
using StudyOverFlow.API.DTOs.Account;
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
        }
    }
}
