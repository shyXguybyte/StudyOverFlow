using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudyOverFlow.API.Migrations
{
    /// <inheritdoc />
    public partial class TimeSpan : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Duration",
                table: "Events");

            migrationBuilder.AddColumn<int>(
                name: "DurationSpan",
                table: "Events",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DurationSpan",
                table: "Events");

            migrationBuilder.AddColumn<TimeOnly>(
                name: "Duration",
                table: "Events",
                type: "time without time zone",
                nullable: false,
                defaultValue: new TimeOnly(0, 0, 0));
        }
    }
}
