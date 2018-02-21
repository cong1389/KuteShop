using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using App.Domain.Entities.Data;

namespace App.Infra.Data.Mapping
{
	public class FlowStepConfiguration : EntityTypeConfiguration<FlowStep>
	{
		public FlowStepConfiguration()
		{
			ToTable("FlowStep");
			HasKey(x => x.Id).Property(x => x.Id).HasColumnName("Id").HasColumnType("int").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();
		}
	}
}