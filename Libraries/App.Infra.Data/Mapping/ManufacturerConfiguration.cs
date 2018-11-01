using App.Domain.Manufacturers;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class ManufacturerConfiguration : EntityTypeConfiguration<Manufacturer>
	{
		public ManufacturerConfiguration()
		{
			ToTable("Manufacturer");
			HasKey(x => x.Id).Property(x => x.Id).HasColumnName("Id").HasColumnType("int")
			    .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
		}
	}
}