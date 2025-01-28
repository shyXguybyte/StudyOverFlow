
using System.Text.Json;
using Microsoft.Extensions.Caching.Memory;
namespace StudyOverFlow.API.Services.Caching
{
    public class RedisCachService : IRedisCacheService
    {
        private readonly IMemoryCache _cache;
        public RedisCachService(IMemoryCache cache)
        {
            _cache = cache; 
        }
        public T? GetData<T>(string key)
        {
            var data = _cache?.Get<string>(key);

            if (data is null) { 
            return default(T?); 
            } 
            return JsonSerializer.Deserialize<T>(data); 
        }

        public void SetData<T>(string key, T data)
        {
            var options = new MemoryCacheEntryOptions()
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(3)
            };
            _cache?.Set(key, JsonSerializer.Serialize(data),options);
        }
        public void DeleteData(string key)
        {
            _cache?.Remove(key);
        }
    }
}
