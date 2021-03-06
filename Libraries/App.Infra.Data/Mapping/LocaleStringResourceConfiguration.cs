using App.Domain.Languages;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class LocaleStringResourceConfiguration : EntityTypeConfiguration<LocaleStringResource>
	{
		public LocaleStringResourceConfiguration()
		{
			ToTable("LocaleStringResource");
			HasKey(x => x.Id)
                .Property(x => x.Id)
                .HasColumnName("Id").HasColumnType("int")
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
            
        }
	}
}