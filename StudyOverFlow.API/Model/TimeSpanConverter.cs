
using System.Text.Json;
using System.Text.Json.Serialization;

namespace StudyOverFlow.API.Model
{
    public class TimeSpanConverter : JsonConverter<TimeSpan>
    {
        public override TimeSpan Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            using (JsonDocument doc = JsonDocument.ParseValue(ref reader))
            {
                var root = doc.RootElement;
                int hours = root.GetProperty("hour").GetInt32();
                int minutes = root.GetProperty("minute").GetInt32();
                return new TimeSpan(hours, minutes, 0);
            }
        }

        public override void Write(Utf8JsonWriter writer, TimeSpan value, JsonSerializerOptions options)
        {
            writer.WriteStartObject();
            writer.WriteNumber("hour", value.Hours);
            writer.WriteNumber("minute", value.Minutes);
            writer.WriteEndObject();
        }

    }
}
