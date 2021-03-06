using App.Domain.GenericAttributes;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class GenericAttributeConfiguration : EntityTypeConfiguration<GenericAttribute>
	{
		public GenericAttributeConfiguration()
		{
			ToTable("GenericAttribute");
			HasKey(x => x.Id)
                .Property(x => x.Id)
                .HasColumnName("Id").HasColumnType("int")
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
            
        }
	}
}