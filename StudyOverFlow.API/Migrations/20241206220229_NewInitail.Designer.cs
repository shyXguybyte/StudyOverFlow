﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using Pgvector;
using StudyOverFlow.API.Data;

#nullable disable

namespace StudyOverFlow.API.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20241206220229_NewInitail")]
    partial class NewInitail
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.11")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.HasPostgresExtension(modelBuilder, "vector");
            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasDatabaseName("RoleNameIndex");

                    b.ToTable("AspNetRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("text");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("text");

                    b.Property<string>("RoleId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("text");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider")
                        .HasColumnType("text");

                    b.Property<string>("ProviderKey")
                        .HasColumnType("text");

                    b.Property<string>("ProviderDisplayName")
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.Property<string>("RoleId")
                        .HasColumnType("text");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.Property<string>("LoginProvider")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<string>("Value")
                        .HasColumnType("text");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens", (string)null);
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.ApplicationUser", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("integer");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("boolean");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("text");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("text");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("boolean");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("text");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("boolean");

                    b.Property<string>("UserName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasDatabaseName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasDatabaseName("UserNameIndex");

                    b.ToTable("AspNetUsers", (string)null);
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Calendar", b =>
                {
                    b.Property<int>("CalendarId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("CalendarId"));

                    b.Property<string>("Duration")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<TimeOnly>("End")
                        .HasColumnType("time without time zone");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<TimeOnly>("start")
                        .HasColumnType("time without time zone");

                    b.HasKey("CalendarId");

                    b.HasIndex("UserId")
                        .IsUnique();

                    b.ToTable("Calendars");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Color", b =>
                {
                    b.Property<int>("ColorId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("ColorId"));

                    b.Property<string>("HexCode")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("ColorId");

                    b.ToTable("Colors");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Event", b =>
                {
                    b.Property<int>("EventId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("EventId"));

                    b.Property<int>("CalendarId")
                        .HasColumnType("integer");

                    b.Property<int>("ColorId")
                        .HasColumnType("integer");

                    b.Property<int?>("CurrentCount")
                        .HasColumnType("integer");

                    b.Property<int>("Day")
                        .HasColumnType("integer");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<TimeOnly>("EndTime")
                        .HasColumnType("time without time zone");

                    b.Property<int>("KanbanListId")
                        .HasColumnType("integer");

                    b.Property<TimeOnly>("StartTime")
                        .HasColumnType("time without time zone");

                    b.Property<int>("SubjectId")
                        .HasColumnType("integer");

                    b.Property<int>("TagId")
                        .HasColumnType("integer");

                    b.Property<int?>("TotalCount")
                        .HasColumnType("integer");

                    b.HasKey("EventId");

                    b.HasIndex("CalendarId");

                    b.HasIndex("ColorId");

                    b.HasIndex("KanbanListId");

                    b.HasIndex("SubjectId");

                    b.HasIndex("TagId");

                    b.ToTable("Events");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.KanbanList", b =>
                {
                    b.Property<int>("KanbanListId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("KanbanListId"));

                    b.Property<int>("ListOrder")
                        .HasColumnType("integer");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("KanbanListId");

                    b.HasIndex("UserId");

                    b.ToTable("KanbanLists");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.MaterialObj", b =>
                {
                    b.Property<int>("MaterialId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("MaterialId"));

                    b.Property<DateTime>("Date")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int?>("SubjectId")
                        .HasColumnType("integer");

                    b.Property<int?>("TaskId")
                        .HasColumnType("integer");

                    b.Property<string>("Type")
                        .HasColumnType("text");

                    b.Property<double?>("size")
                        .HasColumnType("double precision");

                    b.HasKey("MaterialId");

                    b.HasIndex("SubjectId");

                    b.HasIndex("TaskId");

                    b.ToTable("MaterialObjs");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Note", b =>
                {
                    b.Property<int>("NoteId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("NoteId"));

                    b.Property<DateTime>("DateTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int?>("SubjectId")
                        .HasColumnType("integer");

                    b.Property<int?>("TaskId")
                        .HasColumnType("integer");

                    b.Property<string>("text")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("NoteId");

                    b.HasIndex("SubjectId");

                    b.HasIndex("TaskId");

                    b.ToTable("Notes");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Subject", b =>
                {
                    b.Property<int>("SubjectId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("SubjectId"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("EndDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<bool>("IsChecked")
                        .HasColumnType("boolean");

                    b.Property<DateTime>("StartDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("SubjectId");

                    b.HasIndex("UserId");

                    b.ToTable("Subjects");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Tag", b =>
                {
                    b.Property<int>("TagId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("TagId"));

                    b.Property<int>("ColorId")
                        .HasColumnType("integer");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("type")
                        .HasColumnType("text");

                    b.HasKey("TagId");

                    b.HasIndex("ColorId");

                    b.ToTable("Tags");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Task", b =>
                {
                    b.Property<int>("TaskId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("TaskId"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("EndDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int?>("EventId")
                        .HasColumnType("integer");

                    b.Property<bool>("IsChecked")
                        .HasColumnType("boolean");

                    b.Property<DateTime>("StartDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int?>("SubjectId")
                        .HasColumnType("integer");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("TaskId");

                    b.HasIndex("EventId");

                    b.HasIndex("SubjectId");

                    b.HasIndex("UserId");

                    b.ToTable("Tasks");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.TaskKanbanList", b =>
                {
                    b.Property<int>("TaskId")
                        .HasColumnType("integer");

                    b.Property<int>("KanbanListId")
                        .HasColumnType("integer");

                    b.Property<int>("Index")
                        .HasColumnType("integer");

                    b.HasKey("TaskId", "KanbanListId");

                    b.HasIndex("KanbanListId");

                    b.ToTable("TaskKanbanLists");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.TaskTag", b =>
                {
                    b.Property<int>("TagId")
                        .HasColumnType("integer");

                    b.Property<int>("TaskId")
                        .HasColumnType("integer");

                    b.HasKey("TagId", "TaskId");

                    b.HasIndex("TaskId");

                    b.ToTable("TaskTags");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.langchain_pg_collection", b =>
                {
                    b.Property<Guid>("uuid")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("cmetadata")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("uuid");

                    b.ToTable("Langchain_Pg_Collections");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.langchain_pg_embedding", b =>
                {
                    b.Property<Guid>("uuid")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("Collection_id")
                        .HasColumnType("uuid");

                    b.Property<string>("Document")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("cmetadata")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<Vector>("embedding")
                        .HasColumnType("vector");

                    b.HasKey("uuid");

                    b.HasIndex("Collection_id");

                    b.HasIndex("UserId");

                    b.ToTable("Langchain_Pg_Embeddings");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Calendar", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", "User")
                        .WithOne("Calendar")
                        .HasForeignKey("StudyOverFlow.API.Model.Calendar", "UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Event", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.Calendar", "Calendar")
                        .WithMany("Events")
                        .HasForeignKey("CalendarId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.Color", "Color")
                        .WithMany("Events")
                        .HasForeignKey("ColorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.KanbanList", "KanbanList")
                        .WithMany("Events")
                        .HasForeignKey("KanbanListId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.Subject", "Subject")
                        .WithMany("Events")
                        .HasForeignKey("SubjectId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.Tag", "Tag")
                        .WithMany("Events")
                        .HasForeignKey("TagId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Calendar");

                    b.Navigation("Color");

                    b.Navigation("KanbanList");

                    b.Navigation("Subject");

                    b.Navigation("Tag");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.KanbanList", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", "User")
                        .WithMany("KanbanLists")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.MaterialObj", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.Subject", "Subject")
                        .WithMany("MaterialObjs")
                        .HasForeignKey("SubjectId");

                    b.HasOne("StudyOverFlow.API.Model.Task", "Task")
                        .WithMany("MaterialObjs")
                        .HasForeignKey("TaskId");

                    b.Navigation("Subject");

                    b.Navigation("Task");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Note", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.Subject", "Subject")
                        .WithMany("Notes")
                        .HasForeignKey("SubjectId");

                    b.HasOne("StudyOverFlow.API.Model.Task", "Task")
                        .WithMany("Notes")
                        .HasForeignKey("TaskId");

                    b.Navigation("Subject");

                    b.Navigation("Task");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Subject", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", "User")
                        .WithMany("Subjects")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Tag", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.Color", "Color")
                        .WithMany("Tags")
                        .HasForeignKey("ColorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Color");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Task", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.Event", "Event")
                        .WithMany("tasks")
                        .HasForeignKey("EventId");

                    b.HasOne("StudyOverFlow.API.Model.Subject", "Subject")
                        .WithMany("Tasks")
                        .HasForeignKey("SubjectId");

                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", "User")
                        .WithMany("Tasks")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Event");

                    b.Navigation("Subject");

                    b.Navigation("User");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.TaskKanbanList", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.KanbanList", "KanbanList")
                        .WithMany("TaskKanbanLists")
                        .HasForeignKey("KanbanListId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.Task", "Task")
                        .WithMany("TaskKanbanLists")
                        .HasForeignKey("TaskId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("KanbanList");

                    b.Navigation("Task");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.TaskTag", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.Tag", "Tag")
                        .WithMany("TaskTags")
                        .HasForeignKey("TagId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.Task", "Task")
                        .WithMany("TaskTags")
                        .HasForeignKey("TaskId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Tag");

                    b.Navigation("Task");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.langchain_pg_embedding", b =>
                {
                    b.HasOne("StudyOverFlow.API.Model.langchain_pg_collection", "Collection")
                        .WithMany("Embeddings")
                        .HasForeignKey("Collection_id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("StudyOverFlow.API.Model.ApplicationUser", "User")
                        .WithMany("Embeddings")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Collection");

                    b.Navigation("User");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.ApplicationUser", b =>
                {
                    b.Navigation("Calendar")
                        .IsRequired();

                    b.Navigation("Embeddings");

                    b.Navigation("KanbanLists");

                    b.Navigation("Subjects");

                    b.Navigation("Tasks");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Calendar", b =>
                {
                    b.Navigation("Events");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Color", b =>
                {
                    b.Navigation("Events");

                    b.Navigation("Tags");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Event", b =>
                {
                    b.Navigation("tasks");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.KanbanList", b =>
                {
                    b.Navigation("Events");

                    b.Navigation("TaskKanbanLists");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Subject", b =>
                {
                    b.Navigation("Events");

                    b.Navigation("MaterialObjs");

                    b.Navigation("Notes");

                    b.Navigation("Tasks");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Tag", b =>
                {
                    b.Navigation("Events");

                    b.Navigation("TaskTags");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.Task", b =>
                {
                    b.Navigation("MaterialObjs");

                    b.Navigation("Notes");

                    b.Navigation("TaskKanbanLists");

                    b.Navigation("TaskTags");
                });

            modelBuilder.Entity("StudyOverFlow.API.Model.langchain_pg_collection", b =>
                {
                    b.Navigation("Embeddings");
                });
#pragma warning restore 612, 618
        }
    }
}
