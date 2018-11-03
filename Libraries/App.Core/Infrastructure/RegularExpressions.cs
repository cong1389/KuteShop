using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace App.Core.Infrastructure
{
    public static class RegularExpressions
    {
        public static string NonAccent(this string txt)
        {
            if (string.IsNullOrWhiteSpace(txt))
            {
                txt = string.Empty;
            }
            else
            {
                string[] strArrays = { "aAeEoOuUiIdDyY", "áàảãạăắằẳẵặâấầẩẫậ", "ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ", "éèẻẽẹêếềểễệ", "ÉÈẺẼẸÊẾỀỂỄỆ", "óòỏõọôốồổỗộơớờởỡợ", "ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ", "úùủũụưứừửữự", "ÚÙỦŨỤƯỨỪỬỮỰ", "íìỉĩị", "ÍÌỈĨỊ", "đ", "Đ", "ýỳỷỹỵ", "ÝỲỶỸỴ" };
                string[] strArrays1 = { "aAeEoOuUiIdDyY", "áàảãạăắằẳẵặâấầẩẫậ", "ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ", "éèẻẽẹêếềểễệ", "ÉÈẺẼẸÊẾỀỂỄỆ", "óòỏõọôốồổỗộơớờởỡợ", "ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ", "úùủũụưứừửữự", "ÚÙỦŨỤƯỨỪỬỮỰ", "íìỉĩị", "ÍÌỈĨỊ", "đ", "Đ", "ýỳỷỹỵ", "ÝỲỶỸỴ" };
                for (int i = 1; i < strArrays.Length; i++)
                {
                    for (int j = 0; j < strArrays[i].Length; j++)
                    {
                        txt = txt.Replace(strArrays1[i][j], strArrays1[0][i - 1]).Replace(strArrays[i][j], strArrays[0][i - 1]);
                    }
                }
                txt = Regex.Replace(Regex.Replace(txt, "[^a-zA-Z0-9_-]", "-", RegexOptions.Compiled), "-+", "-", RegexOptions.Compiled).Trim('-');
            }
            return txt.ToLower();
        }

        public static string TrimVietNamMark(this string txt)
        {
            if (string.IsNullOrWhiteSpace(txt))
            {
                txt = string.Empty;
            }
            else
            {
                string[] strArrays = { "aAeEoOuUiIdDyY", "áàảãạăắằẳẵặâấầẩẫậ", "ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ", "éèẻẽẹêếềểễệ", "ÉÈẺẼẸÊẾỀỂỄỆ", "óòỏõọôốồổỗộơớờởỡợ", "ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ", "úùủũụưứừửữự", "ÚÙỦŨỤƯỨỪỬỮỰ", "íìỉĩị", "ÍÌỈĨỊ", "đ", "Đ", "ýỳỷỹỵ", "ÝỲỶỸỴ" };
                string[] strArrays1 = { "aAeEoOuUiIdDyY", "áàảãạăắằẳẵặâấầẩẫậ", "ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ", "éèẻẽẹêếềểễệ", "ÉÈẺẼẸÊẾỀỂỄỆ", "óòỏõọôốồổỗộơớờởỡợ", "ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ", "úùủũụưứừửữự", "ÚÙỦŨỤƯỨỪỬỮỰ", "íìỉĩị", "ÍÌỈĨỊ", "đ", "Đ", "ýỳỷỹỵ", "ÝỲỶỸỴ" };
                for (int i = 1; i < strArrays.Length; i++)
                {
                    for (int j = 0; j < strArrays[i].Length; j++)
                    {
                        txt = txt.Replace(strArrays1[i][j], strArrays1[0][i - 1]).Replace(strArrays[i][j], strArrays[0][i - 1]);
                    }
                }
            }
            return txt.ToLower();
        }
    }
}
