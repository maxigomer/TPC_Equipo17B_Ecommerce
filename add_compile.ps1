# Ejecuta esto desde la raíz del repo (cierra Visual Studio primero o Unload Project)
$proj = 'negocio\negocio.csproj'
Copy-Item $proj "$proj.bak"
[xml]$xml = Get-Content $proj
$ns = $xml.Project.NamespaceURI

# ¿Ya existe la entrada?
$exists = $xml.Project.ItemGroup.Compile | Where-Object { $_.Include -eq 'PedidoEstadoAutomaticoNegocio.cs' }
if (-not $exists) {
  $ig = $xml.Project.ItemGroup | Where-Object { $_.Compile } | Select-Object -First 1
  $node = $xml.CreateElement('Compile', $ns)
  $node.SetAttribute('Include','PedidoEstadoAutomaticoNegocio.cs')
  $ig.AppendChild($node) | Out-Null
  $xml.Save($proj)
  Write-Output "Agregado PedidoEstadoAutomaticoNegocio.cs al .csproj"
} else {
  Write-Output "Entrada ya presente"
}