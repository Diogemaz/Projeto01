<%-- 
    Document   : index
    Created on : 5 de set de 2020, 10:41:15
    Author     : Diogenes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>;
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/headreferences.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização</title>
    </head>
    <body>
        <%
            String erro = null;
            double valor = 0;
            double juros = 0;
            double prazo = 0;
            double valorJuros = 0;
            DecimalFormat formato = new DecimalFormat("0.00");
            if(request.getParameter("valor") != null && request.getParameter("juros") != null && request.getParameter("prazo") != null){
            try{
                valor = Double.parseDouble(request.getParameter("valor"));
                juros = Double.parseDouble(request.getParameter("juros"));
                prazo = Integer.parseInt(request.getParameter("prazo"));
            }catch(Exception ex){
                valor = 0;
                juros = 0;
                prazo = 0;
                if(request.getParameter("valor") != null){
                    erro = "Valor inválido como parâmetro";
                } else if(request.getParameter("juros") != null){
                    erro = "Juros inválido como parâmetro";
                }   else if(request.getParameter("prazo") != null){
                    erro = "Prazo inválido como parâmetro";
                }
            }}
        %>
        <%@include file="WEB-INF/jspf/menu.jspf"%> 
        <form method="GET">
            Digite o valor:<br>
            <input type="text" name="valor"><br>
            Juros:<br>
            <input type="text" name="juros"><br>
            Prazo:<br>
            <input type="number" name="prazo"><br>
            <input type="submit" value="Calcular">
        </form>
        <div class="container">
            <div class="col-sm">
                <div class="table-responsive-sm">
                    <%
                        if(request.getParameter("valor") == null || request.getParameter("juros") == null || request.getParameter("prazo") == null){
                    %>
                    Digite os valores para a operação
                    <%
                    }else if(erro != null){
                        %>
                        <div><%= erro %></div>
                    <%}else{
                        valorJuros = (0.01 * valor)*juros;

                     %>
                    <table class="table table-striped" border="1">
                     <thead class="thead-dark">
                        <th>Mês</th>
                        <th>Saldo <br> devedor</th>
                        <th>Amortização</th>
                        <th>Juros</th>
                        <th>Prestação</th>
                    </thead>
                        <%
                            for(int i = 0; i <= prazo; i++){
                         %>
                    <tr>
                        <td><%= i %></td>
                        <%
                            if(i != prazo){
                        %>
                        <td><%= formato.format(valor) %></td>
                        <%
                            }else{
                        %>
                        <td>-</td>
                        <%
                            }
                            if(i != prazo){
                        %>
                        <td>-</td>
                        <%
                            }else{
                        %>
                        <td><%= formato.format(valor) %></td>
                        <%
                            }
                            if(i == 0){
                        %>
                        <td>-</td>
                        <%
                            }else if(i != prazo){
                        %>
                        <td><%= formato.format(valorJuros) %></td>
                        <%
                            } else {
                        %>
                        <td><%= formato.format(valorJuros) %></td>
                        <%
                            }
                            if(i == 0){
                        %>
                        <td>-</td>
                        <%
                            }else if(i != prazo){
                        %>
                        <td><%= formato.format(valorJuros) %></td>
                        <%
                            } else if(i == prazo){
                        %>
                        <td><%= formato.format(valor+valorJuros) %></td>
                        <%
                            }
                        %>
                    </tr>
                     <%
                       }
                     %>
                    <tfoot>
                        <td>Total<td>
                        <td><%= formato.format(valor) %></td>
                        <td><%= formato.format(prazo*valorJuros) %></td>
                        <td><%= formato.format((prazo*valorJuros)+valor) %></td>
                    </tfoot>
                    <%}%>
                </table>
                </div>
            </div>
        </div>
    </body>
</html>
