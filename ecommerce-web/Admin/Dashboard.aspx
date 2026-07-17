<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/MasterDesktopAdmin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ecommerce_web.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #0f1117; }

        /* ── Filtros ── */
        .filter-bar {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 24px;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-end;
            gap: 16px;
        }
        .filter-bar label { color: #8b92b8; font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: .05em; margin-bottom: 4px; display: block; }
        .filter-bar .form-control, .filter-bar .form-select {
            background: #252840;
            border: 1px solid #3a3f6b;
            color: #e2e5f0;
            border-radius: 8px;
            font-size: 13px;
        }
        .filter-bar .form-control:focus, .filter-bar .form-select:focus {
            background: #2e3360;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,.2);
            color: #fff;
        }
        .btn-filter {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border: none;
            color: #fff;
            border-radius: 8px;
            padding: 8px 22px;
            font-weight: 600;
            font-size: 13px;
            transition: all .2s;
        }
        .btn-filter:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(99,102,241,.4); color:#fff; }

        /* ── KPI Cards ── */
        .kpi-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-bottom: 24px; }
        .kpi-card {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 14px;
            padding: 22px 24px;
            position: relative;
            overflow: hidden;
            transition: transform .2s, box-shadow .2s;
        }
        .kpi-card:hover { transform: translateY(-3px); box-shadow: 0 12px 40px rgba(0,0,0,.4); }
        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
        }
        .kpi-card.green::before { background: linear-gradient(90deg, #10b981, #34d399); }
        .kpi-card.blue::before  { background: linear-gradient(90deg, #3b82f6, #60a5fa); }
        .kpi-card.purple::before{ background: linear-gradient(90deg, #8b5cf6, #a78bfa); }
        .kpi-card.orange::before{ background: linear-gradient(90deg, #f59e0b, #fbbf24); }
        .kpi-card .kpi-icon {
            width: 42px; height: 42px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
            margin-bottom: 14px;
        }
        .kpi-card.green .kpi-icon  { background: rgba(16,185,129,.15); }
        .kpi-card.blue .kpi-icon   { background: rgba(59,130,246,.15); }
        .kpi-card.purple .kpi-icon { background: rgba(139,92,246,.15); }
        .kpi-card.orange .kpi-icon { background: rgba(245,158,11,.15); }
        .kpi-label { color: #8b92b8; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: .06em; margin-bottom: 6px; }
        .kpi-value { color: #e2e5f0; font-size: 28px; font-weight: 800; line-height: 1; }
        .kpi-sub   { color: #6b7280; font-size: 12px; margin-top: 6px; }

        /* ── Panel / Card genérico ── */
        .dash-card {
            background: #1a1d2e;
            border: 1px solid #2d3148;
            border-radius: 14px;
            padding: 22px 24px;
        }
        .dash-card-title {
            color: #e2e5f0;
            font-size: 15px;
            font-weight: 700;
            margin-bottom: 18px;
            display: flex; align-items: center; gap: 8px;
        }
        .dash-card-title span { font-size: 18px; }

        /* ── Tabla personalizada ── */
        .dash-table { width: 100%; border-collapse: separate; border-spacing: 0; }
        .dash-table thead th {
            color: #8b92b8; font-size: 11px; font-weight: 600;
            text-transform: uppercase; letter-spacing: .05em;
            padding: 8px 12px; border-bottom: 1px solid #2d3148;
        }
        .dash-table tbody tr { transition: background .15s; }
        .dash-table tbody tr:hover td { background: #1e2238; }
        .dash-table tbody td { color: #c9cde0; font-size: 13px; padding: 10px 12px; border-bottom: 1px solid #22253a; vertical-align: middle; }
        .dash-table tbody tr:last-child td { border-bottom: none; }

        /* Badges de estado */
        .badge-estado {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .badge-pendiente { background: rgba(245,158,11,.15); color: #fbbf24; }
        .badge-enviado   { background: rgba(59,130,246,.15);  color: #60a5fa; }
        .badge-entregado { background: rgba(16,185,129,.15);  color: #34d399; }
        .badge-cancelado { background: rgba(239,68,68,.15);   color: #f87171; }
        .badge-default   { background: rgba(107,114,128,.15); color: #9ca3af; }

        /* Barra de progreso en la tabla top productos */
        .progress-bar-wrap { background: #252840; border-radius: 20px; height: 6px; min-width: 80px; }
        .progress-bar-fill { height: 6px; border-radius: 20px; background: linear-gradient(90deg,#6366f1,#8b5cf6); }

        /* Etiqueta "sin ventas" */
        .sin-ventas-badge { background: rgba(239,68,68,.12); color: #f87171; padding: 2px 8px; border-radius: 20px; font-size: 11px; }

        .chart-wrap { position: relative; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager runat="server" ID="ScriptManager1" />

    <asp:UpdatePanel runat="server" ID="upDashboard" UpdateMode="Conditional">
        <ContentTemplate>

            <!-- ── Filtros ─────────────────────────────── -->
            <div class="filter-bar">
                <div>
                    <label>Desde</label>
                    <asp:TextBox runat="server" ID="txtDesde" TextMode="Date" CssClass="form-control" style="width:160px;" />
                </div>
                <div>
                    <label>Hasta</label>
                    <asp:TextBox runat="server" ID="txtHasta" TextMode="Date" CssClass="form-control" style="width:160px;" />
                </div>
                <div>
                    <label>Criterio</label>
                    <asp:DropDownList runat="server" ID="ddlCriterio" CssClass="form-select" style="width:150px;"
                        AutoPostBack="false">
                        <asp:ListItem Value="">Todos</asp:ListItem>
                        <asp:ListItem Value="Marca">Por Marca</asp:ListItem>
                        <asp:ListItem Value="Categoria">Por Categoria</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <label>Filtro</label>
                    <asp:DropDownList runat="server" ID="ddlFiltroValor" CssClass="form-select" style="width:180px;" />
                </div>
                <div>
                    <asp:Button runat="server" ID="btnAplicar" Text="Aplicar Filtros" CssClass="btn btn-filter"
                        OnClick="btnAplicar_Click" />
                </div>
            </div>

            <!-- ── KPI Cards ───────────────────────────── -->
            <div class="kpi-grid">
                <div class="kpi-card green">
                    <%--<div class="kpi-icon">💰</div>--%>
                    <div class="kpi-label">Ingresos Totales</div>
                    <div class="kpi-value">$<asp:Literal runat="server" ID="litIngresos" /></div>
                    <div class="kpi-sub"><asp:Literal runat="server" ID="litCantPedidos" /> pedidos</div>
                </div>
                <div class="kpi-card blue">
                    <%--<div class="kpi-icon">🛒</div>--%>
                    <div class="kpi-label">Ticket Promedio</div>
                    <div class="kpi-value">$<asp:Literal runat="server" ID="litTicket" /></div>
                    <div class="kpi-sub">Por compra</div>
                </div>
                <div class="kpi-card purple">
                    <%--<div class="kpi-icon">👥</div>--%>
                    <div class="kpi-label">Clientes</div>
                    <div class="kpi-value"><asp:Literal runat="server" ID="litClientes" /></div>
                    <div class="kpi-sub">Registrados en total</div>
                </div>
                <div class="kpi-card orange">
                    <%--<div class="kpi-icon">📦</div>--%>
                    <div class="kpi-label">Productos Activos</div>
                    <div class="kpi-value"><asp:Literal runat="server" ID="litProductos" /></div>
                    <div class="kpi-sub">En catalogo</div>
                </div>
            </div>

            <!-- ── Fila de gráficos ────────────────────── -->
            <div class="row g-3 mb-3">
                <div class="col-lg-8">
                    <div class="dash-card" style="height:340px;">
                        <%--<div class="dash-card-title"><span>📈</span> Evolución de Ventas</div>--%>
                        <div class="dash-card-title">Evolucion de Ventas</div>
                        <div class="chart-wrap" style="height:270px;">
                            <canvas id="chartVentas"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="dash-card" style="height:340px;">
                        <%--<div class="dash-card-title"><span>🍩</span> Ventas por Categoría</div>--%>
                        <div class="dash-card-title">Ventas por Categoria</div>
                        <div class="chart-wrap" style="height:270px;">
                            <canvas id="chartCategoria"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ── Fila de tablas ──────────────────────── -->
            <div class="row g-3 mb-3">
                <!-- Top Productos -->
                <div class="col-lg-6">
                    <div class="dash-card">
                        <%--<div class="dash-card-title"><span>🏆</span> Top 5 Productos Más Vendidos</div>--%>
                        <div class="dash-card-title">Top 5 Productos Mas Vendidos</div>
                        <asp:Repeater runat="server" ID="rpTopProductos">
                            <HeaderTemplate>
                                <table class="dash-table">
                                <thead><tr>
                                    <th>Producto</th>
                                    <th style="text-align:right">Unidades</th>
                                    <th style="min-width:90px"></th>
                                    <th style="text-align:right">Ingreso</th>
                                </tr></thead>
                                <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <div style="font-weight:600;color:#e2e5f0;"><%# Eval("Nombre") %></div>
                                        <div style="color:#6b7280;font-size:11px;">SKU: <%# Eval("Sku") %></div>
                                    </td>
                                    <td style="text-align:right;font-weight:700;color:#a78bfa;"><%# Eval("UnidadesVendidas") %></td>
                                    <td>
                                        <div class="progress-bar-wrap">
                                            <div class="progress-bar-fill" id="bar_<%# Container.ItemIndex %>"
                                                 style="width:<%# GetBarWidth((int)Eval("UnidadesVendidas")) %>%"></div>
                                        </div>
                                    </td>
                                    <td style="text-align:right;color:#34d399;font-weight:600;">$<%# string.Format("{0:N0}", Eval("IngresoTotal")) %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate></tbody></table></FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- Productos Sin Ventas -->
                <div class="col-lg-6">
                    <div class="dash-card">
                        <%--<div class="dash-card-title"><span>⚠️</span> Productos Sin Ventas (Stock Estancado)</div>--%>
                        <div class="dash-card-title">Productos Sin Ventas (Stock Estancado)</div>
                        <asp:Repeater runat="server" ID="rpSinVentas">
                            <HeaderTemplate>
                                <table class="dash-table">
                                <thead><tr>
                                    <th>Producto</th>
                                    <th style="text-align:right">Stock</th>
                                    <th style="text-align:center">Estado</th>
                                </tr></thead>
                                <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <div style="font-weight:600;color:#e2e5f0;"><%# Eval("Nombre") %></div>
                                        <div style="color:#6b7280;font-size:11px;">SKU: <%# Eval("Sku") %></div>
                                    </td>
                                    <td style="text-align:right;color:#fbbf24;font-weight:700;"><%# Eval("Stock") %> u.</td>
                                    <td style="text-align:center"><span class="sin-ventas-badge">Sin ventas</span></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate></tbody></table></FooterTemplate>
                        </asp:Repeater>
                        <%--<asp:Label runat="server" ID="lblSinVentasVacio" Text="🎉 ¡Todos los productos tuvieron ventas en el período!"--%>
                        <asp:Label runat="server" ID="lblSinVentasVacio" Text="¡Todos los productos tuvieron ventas en el periodo!"
                            style="color:#34d399;font-size:13px;display:none;" />
                    </div>
                </div>
            </div>

            <!-- ── Últimos Pedidos ─────────────────────── -->
            <div class="dash-card mb-3">
                <%--<div class="dash-card-title"><span>🕐</span> Últimos 10 Pedidos</div>--%>
                <div class="dash-card-title">Últimos 10 Pedidos</div>
                <asp:GridView runat="server" ID="gvUltimosPedidos" AutoGenerateColumns="false"
                    CssClass="dash-table" GridLines="None" ShowHeaderWhenEmpty="true"
                    EmptyDataText="No hay pedidos en este período.">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="# Pedido" ItemStyle-Width="70px" />
                        <asp:BoundField DataField="NombreCliente" HeaderText="Cliente" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:TemplateField HeaderText="Total">
                            <ItemTemplate>
                                <span style="color:#34d399;font-weight:600;">$<%# string.Format("{0:N0}", Eval("Total")) %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <span class='<%# GetBadgeClass(Eval("Estado").ToString()) %>'><%# Eval("Estado") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <a href='DetallePedido.aspx?id=<%# Eval("Id") %>' 
                                   style="color:#6366f1;font-size:12px;text-decoration:none;">Ver →</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Datos serializados para Chart.js (hidden) -->
            <asp:HiddenField runat="server" ID="hfVentasMeses"     />
            <asp:HiddenField runat="server" ID="hfVentasTotales"   />
            <asp:HiddenField runat="server" ID="hfCategoriaNombres"/>
            <asp:HiddenField runat="server" ID="hfCategoriaTotales"/>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAplicar" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

    <!-- ── Chart.js ───────────────────────────────────── -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script>
        var chartVentas = null;
        var chartCat = null;

        function renderCharts() {
            var meses    = (document.getElementById('<%= hfVentasMeses.ClientID %>').value || '').split('|').filter(Boolean);
            var totales  = (document.getElementById('<%= hfVentasTotales.ClientID %>').value || '').split('|').filter(Boolean).map(Number);
            var catNom   = (document.getElementById('<%= hfCategoriaNombres.ClientID %>').value || '').split('|').filter(Boolean);
            var catTot   = (document.getElementById('<%= hfCategoriaTotales.ClientID %>').value || '').split('|').filter(Boolean).map(Number);

            // Colores para doughnut
            var colores = ['#6366f1','#8b5cf6','#ec4899','#f59e0b','#10b981','#3b82f6','#ef4444','#14b8a6'];

            // ── Gráfico de Líneas ──
            if (chartVentas) chartVentas.destroy();
            var ctxV = document.getElementById('chartVentas').getContext('2d');
            chartVentas = new Chart(ctxV, {
                type: 'line',
                data: {
                    labels: meses.length ? meses : ['Sin datos'],
                    datasets: [{
                        label: 'Ingresos ($)',
                        data: totales.length ? totales : [0],
                        borderColor: '#6366f1',
                        backgroundColor: 'rgba(99,102,241,0.15)',
                        borderWidth: 2.5,
                        pointBackgroundColor: '#6366f1',
                        pointRadius: 5,
                        pointHoverRadius: 7,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true, maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        x: { grid: { color: '#2d3148' }, ticks: { color: '#8b92b8', font: { size: 11 } } },
                        y: { grid: { color: '#2d3148' }, ticks: { color: '#8b92b8', font: { size: 11 },
                               callback: v => '$' + v.toLocaleString('es-AR') } }
                    }
                }
            });

            // ── Gráfico Doughnut ──
            if (chartCat) chartCat.destroy();
            var ctxC = document.getElementById('chartCategoria').getContext('2d');
            chartCat = new Chart(ctxC, {
                type: 'doughnut',
                data: {
                    labels: catNom.length ? catNom : ['Sin datos'],
                    datasets: [{
                        data: catTot.length ? catTot : [1],
                        backgroundColor: colores.slice(0, catNom.length || 1),
                        borderWidth: 2,
                        borderColor: '#1a1d2e'
                    }]
                },
                options: {
                    responsive: true, maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { color: '#8b92b8', font: { size: 11 }, padding: 12, boxWidth: 12 }
                        }
                    },
                    cutout: '68%'
                }
            });
        }

        // Render inicial y tras UpdatePanel
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(renderCharts);
        window.addEventListener('DOMContentLoaded', renderCharts);
    </script>
</asp:Content>

