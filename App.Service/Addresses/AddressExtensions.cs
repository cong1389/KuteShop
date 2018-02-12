using System.Text;
using App.Core.Extensions;
using App.Domain.Common;

namespace App.Service.Addresses
{
    public static class AddressExtensions
    {
		public static string GetFullName(this Address address)
        {
            if (address == null) return null;

            var sb = new StringBuilder(address.FirstName);

            sb.AppendFormat("{0} ", address.LastName);

            if (address.Company.HasValue())
            {
                sb.AppendFormat("({0}) ", address.Company);
            }
            return sb.ToString().Trim();
        }
    }
}
