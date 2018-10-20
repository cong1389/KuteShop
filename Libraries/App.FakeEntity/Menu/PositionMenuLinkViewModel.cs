using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using App.Service.Language;
using Resources;

namespace App.FakeEntity.Menu
{
    public class PositionMenuLinkViewModel : ILocalizedModel<PositionMenuLinkLocalesViewModel>
    {
        public int Id
        {
            get;
            set;
        }

        public string Name
        {
            get;
            set;
        }

        public int Status
        {
            get;
            set;
        }

        public bool Selected
        {
            get; set;
        }

        public IList<PositionMenuLinkLocalesViewModel> Locales { get; set; }
        public PositionMenuLinkViewModel()
        {
            Locales = new List<PositionMenuLinkLocalesViewModel>();
        }
    }

    public class PositionMenuLinkLocalesViewModel : ILocalizedModelLocal
    {
        public int LanguageId { get; set; }

        public int LocalesId { get; set; }

        public string Name
        {
            get;
            set;
        }

        public bool Selected
        {
            get; set;
        }

        public int Status
        {
            get;
            set;
        }

    }
}