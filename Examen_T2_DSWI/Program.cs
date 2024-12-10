using Examen_T2_DSWI.DAO;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// 1.- Agregar el DAO EcommerceDAO para que pueda ser utilizado
builder.Services.AddScoped<EcommerceDAO>();

// 2.- Establecer el tiempo de la duración de las
// variables de Session
builder.Services.AddSession(
    s => s.IdleTimeout = TimeSpan.FromMinutes(20));

var app = builder.Build();

// 3.- Habilitar las variables de Session
app.UseSession();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default2",
    pattern: "{controller=Ecommerce}/{action=IndexProductos}/{id?}");

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
