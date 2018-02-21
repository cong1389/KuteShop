﻿using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using App.Domain.Entities.Data;

namespace App.Infra.Data.Mapping
{
    public class RepairGalleryConfiguration : EntityTypeConfiguration<RepairGallery>
    {
        public RepairGalleryConfiguration()
        {
            ToTable("RepairGallery");

            HasKey(x => x.Id).Property(x => x.Id).HasColumnName("Id").HasColumnType("int").HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity).IsRequired();

            HasRequired(x => x.Repairs)
                .WithMany(x => x.RepairGalleries)
                .HasForeignKey(x => x.RepairId)
                .WillCascadeOnDelete(true);
        }
    }
}