using System.ComponentModel.DataAnnotations;

namespace Examen_T2_DSWI.Models
{
    public class Articulos
    {
        [Display(Name = "Codigo")]
        public string cod_art { get; set; } = "";

        [Display(Name = "Nombre del Articulo")]
        public string nom_art { get; set; } = "";

        [Display(Name = "Precio")]
        public decimal pre_art { get; set; }

        [Display(Name = "Stock")]
        public int stk_art { get; set; }
    }
}
