using StudyOverFlow.API.Model;

namespace StudyOverFlow.API.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
           : base(options)
        {
        }
     
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Subject>()
                        .HasOne(t => t.User)
                        .WithMany(c => c.Subjects)
                        .HasForeignKey(c=>c.UserId);
            modelBuilder.Entity<Todo>()
                       .HasOne(t => t.User)
                       .WithMany(c => c.Todos)
                       .HasForeignKey(c=>c.UserId);
            modelBuilder.Entity<KanbanList>()
                       .HasOne(t => t.User)
                       .WithMany(c => c.KanbanLists)
                       .HasForeignKey(c=>c.UserId);

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
