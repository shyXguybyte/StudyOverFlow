using StudyOverFlow.API.Model;

namespace StudyOverFlow.API.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
           : base(options)
        {
        }
        //public DbSet<ApplicationUser> ApplicationUsers { get; set; }

        public DbSet<Event> Events { get; set; }
        public DbSet<Calendar> Calendars { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<KanbanList> KanbanLists { get; set; }
        public DbSet<langchain_pg_collection> Langchain_Pg_Collections { get; set; }
        public DbSet<langchain_pg_embedding> Langchain_Pg_Embeddings { get; set; }
        public DbSet<MaterialObj> MaterialObjs { get; set; }
        public DbSet<Note> Notes { get; set; }
        public DbSet<Color> Colors { get; set; }    
        public DbSet<Model.Task> Tasks { get; set; }
        public DbSet<Subject> Subjects { get; set; }
        public DbSet<TaskKanbanList> TaskKanbanLists { get; set; }
        public DbSet<TaskTag> TaskTags { get; set; }

      


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TaskTag>().HasKey(e => new
            {
                e.TagId,
                e.TaskId
            });
            modelBuilder.Entity<TaskKanbanList>().HasKey(e => new
            {
                e.TaskId,
                e.KanbanListId
            });
            modelBuilder.Entity<Subject>()
                        .HasOne(t => t.User)
                        .WithMany(c => c.Subjects)
                        .HasForeignKey(c=>c.UserId);
            modelBuilder.Entity<Model.Task>()
                       .HasOne(t => t.User)
                       .WithMany(c => c.Tasks)
                       .HasForeignKey(c=> c.UserId);
            modelBuilder.Entity<KanbanList>()
                       .HasOne(t => t.User)
                       .WithMany(c => c.KanbanLists)
                       .HasForeignKey(c=>c.UserId);
            modelBuilder.Entity<Calendar>()
                .HasOne(t => t.User)
                .WithOne(c => c.Calendar)
                .HasForeignKey<Calendar>(c=>c.UserId)
                .HasPrincipalKey<ApplicationUser>(c=>c.Id);


            modelBuilder.Entity<langchain_pg_embedding>()
                .HasOne(t => t.User)
                .WithMany(c=>c.Embeddings)
                .HasForeignKey(c=>c.UserId);


            modelBuilder.Entity<langchain_pg_embedding>()
                .HasOne(c => c.Collection)
                .WithMany(c => c.Embeddings)
                .HasForeignKey(c=>c.Collection_id)
                .HasPrincipalKey(c=>c.uuid);
            modelBuilder.HasPostgresExtension("vector");
            base.OnModelCreating(modelBuilder);

        }
    }
}
