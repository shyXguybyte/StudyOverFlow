namespace StudyOverFlow.API.Services.Caching
{
    public interface IRedisCacheService

    {
        T? GetData<T>(string key);
        void SetData<T>(string key, T data);
        void DeleteData(string key);
    }
}
