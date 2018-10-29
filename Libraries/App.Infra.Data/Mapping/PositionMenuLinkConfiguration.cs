using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace App.Infra.Data.Mapping
{
    public class PositionMenuLinkConfiguration : EntityTypeConfiguration<Domain.Menus.PositionMenuLink>
    {
        public PositionMenuLinkConfiguration()
        {
            ToTable("PositionMenuLink");

            HasKey(x => x.Id)
                .Property(x => x.Id)
                .HasColumnName("Id").HasColumnType("int")
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            HasMany(x => x.MenuLinks)
                 .WithMany(x => x.PositionMenuLinks)
                 .Map(x =>
                 {
                     x.ToTable("MenuLinkWithPosition");
                     x.MapLeftKey("PositionId");
                     x.MapRightKey("MenuLinkId");
                 });
        }
    }
}