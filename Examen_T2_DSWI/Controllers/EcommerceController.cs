using Examen_T2_DSWI.DAO;
using Examen_T2_DSWI.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Newtonsoft.Json;

namespace Examen_T2_DSWI.Controllers
{
    public class EcommerceController : Controller
    {
        private readonly EcommerceDAO dao;
        List<Carrito> lista_carrito = new List<Carrito>();
        public EcommerceController(EcommerceDAO _dao)
        {
            dao = _dao;
        }

        // serializar los datos del objeto lista_carrito a
        // una cadena json guardando en una session
        void GrabarCarrito()
        {
            HttpContext.Session.SetString("Carrito",
                JsonConvert.SerializeObject(lista_carrito));
        }

        // deserializar la cadena json de una session a
        // un objeto lista_carrito
        List<Carrito> RecuperarCarrito()
        {
            return JsonConvert.DeserializeObject<List<Carrito>>(
                HttpContext.Session.GetString("Carrito")!)!;
        }

        // GET: EcommerceController
        public ActionResult IndexProductos() // List
        {
            // si la variable de session Carrito no existe
            // entonces la creamos por medio de GrabarCarrito
            if (HttpContext.Session.GetString("Carrito") == null)
            {
                GrabarCarrito();
                TempData.Clear();
            }
             var listado = dao.GetProductos();           

            //
            return View(listado);
        }

        // GET: EcommerceController/AgregarAlCarrito/5
        public ActionResult AgregarAlCarrito(string id) // Details
        {
            return View(dao.BuscarProducto(id));
        }

        // POST: EcommerceController/AgregarAlCarrito/5
        [HttpPost]
        public ActionResult AgregarAlCarrito(string id, int cantidad)
        {
            // recuperar los datos del producto
            var prod = dao.BuscarProducto(id);
            // creamos un nuevo objeto carrito de compra y le enviamos
            // los datos
            var car = new Carrito()
            {
                Codigo = prod.cod_art,
                NombreProducto = prod.nom_art,
                Precio = prod.pre_art,
                Cantidad = cantidad
            };
            // obtenemos el contenido del carrito de compra
            lista_carrito = RecuperarCarrito();
            // buscamos en el carrito el codigo "id" del producto
            var encontrado = lista_carrito.Find(x => x.Codigo.Equals(id));
            // si es nulo, el id no fue encontrado, entonces lo agregamos
            if (encontrado == null)
            {
                lista_carrito.Add(car);
                ViewBag.mensaje = "Producto Agregado al Carrito de Compra";
            }
            else // caso contrario, si existe el producto, entonces aumentamos la cantidad
            {
                encontrado.Cantidad += cantidad;
                ViewBag.mensaje =
                    "Cantidad del Producto fué actualizada correctamente";
            }
            // después de lo realizado (cualquiera de las dos), debemos
            // grabar los cambios en el carrito de compra
            GrabarCarrito();
            //
            return View(prod);
        }         

        // GET
        public ActionResult VerCarrito() // Listado
        {
            // si la variable de session existe
            if (HttpContext.Session.GetString("Carrito") != null)
            {
                lista_carrito = RecuperarCarrito();
                if (lista_carrito.Count == 0)
                {
                    TempData.Remove("mensaje");
                    return RedirectToAction("IndexProductos");
                }
                //
            }
            ViewBag.total = lista_carrito.Sum(c => c.Importe);
            //
            return View(lista_carrito);
        }

        // GET: EcommerceController/Delete/5
        public ActionResult EliminarProducto(string id)
        {
            lista_carrito = RecuperarCarrito();

            //var car = lista_carrito.Find(c=>c.Codigo.Equals(id));
            //lista_carrito.Remove(car);

            lista_carrito.RemoveAll(c => c.Codigo.Equals(id));

            GrabarCarrito();

            TempData["mensaje"] = "Producto Eliminado correctamente";
            return RedirectToAction("VerCarrito");
        }


        public async Task<IActionResult> ListarProductos(int nropagina = 0, string nombre= null!)
        {

           IEnumerable<Articulos> listado = string.IsNullOrEmpty(nombre) ? new List<Articulos>() : dao.listarArticulos(nombre);

            ViewBag.nombre = nombre;

            // Inicio de la paginacion
            int filas_pagina = 10;
            int contador = listado.Count();
            int paginas = 0;
            if (contador % filas_pagina == 0)
                paginas = contador / filas_pagina;
            else
                paginas = (contador / filas_pagina) + 1;

            ViewBag.paginas = paginas;
            return View(listado.Skip(nropagina * filas_pagina).Take(filas_pagina));


        }



        // GET: EcommerceController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: EcommerceController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: EcommerceController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: EcommerceController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: EcommerceController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: EcommerceController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}
