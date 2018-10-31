using App.Domain.Languages;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class LocalizedPropertyConfiguration : EntityTypeConfiguration<LocalizedProperty>
	{
		public LocalizedPropertyConfiguration()
		{
			ToTable("LocalizedProperty");
			HasKey(x => x.Id)
                .Property(x => x.Id)
                .HasColumnName("Id").HasColumnType("int")
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
        }
	}
}