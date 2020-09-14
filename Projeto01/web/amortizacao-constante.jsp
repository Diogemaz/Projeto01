<%-- 
    Document   : index
    Created on : 5 de set de 2020, 12:40:15
    Author     : Bruno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/headreferences.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf"%>
        <%@include file ="WEB-INF/jspf/cabecalho.jspf"%>
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
        <div class="container">
            <div class="row">
                <div class="mx-auto mt-4">
                    <form method="GET">
                        <div class="form-group">
                            <label for="valor">Valor</label>
                            <input type="text" name="valor" class="form-control" id="valor" placeholder="Valor da divida">
                        </div>
                        <div class="form-group">
                            <label for="juros">Juros</label>
                            <input type="text" name="juros" class="form-control" id="juros"  placeholder="Juros (%)">
                        </div>
                        <div class="form-group">
                            <label for="prazo">Prazo</label>
                            <input type="number" name="prazo" class="form-control" id="prazo" placeholder="Prazo em meses">
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="mx-auto mt-2 mb-3">
                                    <button type="submit" class="btn btn-secondary">Calcular</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-sm">
                <div class="table-responsive-sm">
                    <%
                        if(request.getParameter("valor") == null || request.getParameter("juros") == null || request.getParameter("prazo") == null){
                    %>
                    <div class="container">
                        <div class="row">
                            <div class="mx-auto mt-4">
                                Digite os valores para a operação
                            </div>
                        </div>
                    </div>    
                    <%
                    }else if(erro != null){
                        %>
                        <div><%= erro %></div>
                    <%}else{
                        valorJuros = (0.01 * valor)*juros;

                     %>
                    <table class="table table-striped" border="1">
                     <thead class="thead-dark">
                        <th>Número da Parcela</th>
                        <th>Parcela</th>
                        <th>Juros</th>
                        <th>Amortização</th>
                        <th>Dívida</th>
                    </thead>
                        <%
                            double amortizacao = 0;
                            double divida;
                            double parcela = 0;
                            double valorjuros = 0;
                            divida = valor;
                            
                            amortizacao = valor/prazo;
                            
                            for(int i = 0; i <= prazo; i++){
                                
                                valorjuros = (divida * juros)/100;
                                
                                parcela = valorjuros + amortizacao;
                                
                                if (i != 0){
                                   
                                    divida = divida - amortizacao;
                                    
                                }
                         %>
                    <tr>
                        <td><%=i%></td>
                        <%
                            if(i == 0){
                        %>
                        <td>-</td>
                        <%
                            }else{
                        %>
                        <td><%= formato.format(parcela)%></td>
                        <%
                            }
                            if(i == 0){
                        %>
                        <td>-</td>
                        <%
                            }else{
                        %>
                        <td><%=formato.format(valorjuros)%></td>
                        <%
                            }
                        %>
                        <td><%=formato.format(amortizacao) %></td>
                        <td><%=formato.format(divida)%></td>
                    </tr>
                     <%
                       }
                     %>
                    <%}%>
                </table>
                </div>
            </div>
        </div>
               <%@include file ="WEB-INF/jspf/rodape.jspf"%>
    </body>
</html>


