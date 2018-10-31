using App.Domain.Customers;
using App.Domain.Languages;

namespace App.Service.Common
{
    public interface IWorkContext 
    {
        Customer CurrentCustomer { get; set; }

        Language WorkingLanguage { get; set; }
    }
}