using App.Domain.News;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class NewsConfiguration : EntityTypeConfiguration<News>
	{
		public NewsConfiguration()
		{
			ToTable("News");
			HasKey(x => x.Id).Property(x => x.Id).HasColumnName("Id").HasColumnType("int")
			    .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
			HasRequired(x => x.MenuLink)
                .WithMany(x => x.News)
                .HasForeignKey(x => x.MenuId);
		}
	}
}