using App.Domain.StaticContents;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class StaticContentConfiguration : EntityTypeConfiguration<StaticContent>
	{
		public StaticContentConfiguration()
		{
			ToTable("StaticContent");
			HasKey(x => x.Id).Property(x => x.Id).HasColumnName("Id").HasColumnType("int").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
			HasRequired(x => x.MenuLink).WithMany(x => x.StaticContents).HasForeignKey(x => x.MenuId);
		}
	}
}