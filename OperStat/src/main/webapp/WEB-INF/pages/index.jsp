<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>
        <title>Моя статистика</title>
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link type="text/css" href="css/radio.css" rel="stylesheet"> 
        <link rel="icon" type="image/png" href="https://image.ibb.co/foupj6/favicon.png" sizes="16x16">
        
        <script language="javascript">           
            function visibilityOfAddFunc(val){
                switch(val) {
                    case "Линия": {
                        $('#line').css("display", 'block');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'none');
                    }  break;
                    case "Большегрузы": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'block');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'visible');
                        $('#load_capacity').prop('required', true);
                        $('#cost').css("display", 'block');
                    }  break;
                    case "VIP линия": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'block');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'none');
                    }  break;
                    case "Эвакуаторы": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'block');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'block');
                    }  break;
                    case "Транспортная компания": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'block');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'none');
                    }  break;
                    case "Сборный груз": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'block');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'block');
                    }  break;
                    case "Чат отдела продаж": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'block');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'block');
                    }  break;
                    case "Консультации": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'block');
                        $('#complaint').css("display", 'none');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'block');
                    }  break;
                    case "Жалобы": {
                        $('#line').css("display", 'none');
                        $('#truck').css("display", 'none');
                        $('#vipline').css("display", 'none');
                        $('#evac').css("display", 'none');
                        $('#trans_comp').css("display", 'none');
                        $('#consolidate').css("display", 'none');
                        $('#sales_depart').css("display", 'none');
                        $('#consultation').css("display", 'none');
                        $('#complaint').css("display", 'block');
                        $('#load_capacity').css('visibility', 'hidden');
                        $('#load_capacity').prop('required', false);
                        $('#cost').css("display", 'none');
                    }  break;
                    default:;
                } 
            }
            <%
                String add_func = String.valueOf(session.getAttribute("add_func"));     
                String load_capacity = String.valueOf(session.getAttribute("load_capacity"));     
                out.print("$(document).ready(function(){visibilityOfAddFunc('" + add_func + "'); });");
            %>
        </script>
    </head>
    <body>
        <div style="width: 330px">
            <div> 
                <form action="Mystatistic" method="post">
                    <button type="submit" class="btn btn-link">Моя статистика</button>
                </form>
            </div>
            <form action="Call" method="post">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div style="float: left;">
                            <span style="vertical-align: -5px;">
                                <a href="/os/sign-out">Выход [<% out.print(session.getAttribute("login")); %>]</a>   
                            </span>
                        </div>
                        <div>
                            <select class="gap-bottom" name="add_func"
                                    title="Статистика для дополнительного функционала" 
                                    onchange="visibilityOfAddFunc(this.value)" 
                                    style="width: 200px; margin: 0 0 0 100px; padding: 5px;">
                                <%
                                    String[] arrAddFunc = {"Линия", "Большегрузы", "VIP линия", "Эвакуаторы", "Транспортная компания", "Сборный груз", "Чат отдела продаж", "Консультации", "Жалобы"};
                                    String[] arrAddFuncSelected = new String[arrAddFunc.length];
                                    for (int i = 0; i < arrAddFunc.length; i++) {
                                        arrAddFuncSelected[i] = "";
                                        if (arrAddFunc[i].equals(add_func)) arrAddFuncSelected[i] = "selected";
                                        out.print("<option " + arrAddFuncSelected[i] + " value='" + arrAddFunc[i] + "'>" + arrAddFunc[i] + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="panel-body scalable">
                        <div class="section">
                            <div class="selection"><input id="city1" required type="radio" class="radio" name="city" value="Санкт-Петербург"/>
                                <label for="city1">Санкт-Петербург</label>
                            </div>
                            <div class="selection"><input id="city2" required type="radio" class="radio" name="city" value="Москва"/>
                                <label for="city2">Москва</label>
                            </div>
                        </div>
                    </div>

                    <div class="panel-heading">
                        <div>
                            <!-- <input type="submit" value="Отправить" class="btn btn-warning"/> -->
                            <div style="float: left">
                                <button type="submit" class="btn btn-warning">Отправить</button>
                            </div>
                            <div>
                                <select class="gap-bottom" name="load_capacity" id="load_capacity" style="width: 200px; margin: 0 0 0 100px;">
                                    <option value="">Выберите тип авто</option>
                                    <%
                                        String[] arrLoadCapacity = { "3 т.", "3 т. гидроборт", "3 т. рефрижератор",
                                                                 "5 т.", "5 т. гидроборт", "5 т. рефрижератор",
                                                                "10 т.","10 т. гидроборт","10 т. рефрижератор",
                                                                "20 т.","20 т. гидроборт","20 т. рефрижератор",
                                                                "Автокран","Автовышка","Манипулятор","Самосвал","Тралл",
                                                                "Экскаватор-погрузчик","Фронтальный погрузчик","Ямобур"};
                                        String[] arrLoadCapacitySelected = new String[arrLoadCapacity.length];
                                        for (int i = 0; i < arrLoadCapacity.length; i++) {
                                            arrLoadCapacitySelected[i] = "";
                                            if (arrLoadCapacity[i].equals(load_capacity)) arrLoadCapacitySelected[i] = "selected";
                                            out.print("<option " + arrLoadCapacitySelected[i] + " value='" + arrLoadCapacity[i] + "'>" + arrLoadCapacity[i] + "</option>");
                                        }  
                                    %>
                                </select>
                            </div>   
                        </div>
                    </div>
                    <div class="panel-body scalable">             
                    <% 
                        Map<String, String[]> mapCallsType = new HashMap<String, String[]>();
                        mapCallsType.put("Линия", new String[]{"line", "Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Перевод на 20 т.", "Отдел кадров", "Перевод другому оператору", "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался", "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)"});
                        mapCallsType.put("Большегрузы", new String[]{"truck", "Заказ", "Отказ", "Консультация", "Ждёт звонка", "Нет машин на запрошенное время", "По ПДД не можем предоставить", "Дорого", "Узнавал цену, мониторинг", "Не отвечает", "Уже не актуально", "Просил перезвонить", "Ждёт ответа из ТО"});
                        mapCallsType.put("VIP линия", new String[]{"vipline", "Заказ", "Консультация", "Дорого", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Корректировка", "Доп.информация", "Опоздание", "Жалоба", "Не можем предоставить", "Передано другому оператору", "Сорвался", "Перевод в отдел кадров","Перевод в КО", "Перевод в ОКК", "Перевод в такси", "Ошиблись / Не по груз-кам", "Проверка связи"});    
                        mapCallsType.put("Эвакуаторы", new String[]{"evac", "Заказ", "Консультация", "Дорого", "Не можем предоставить", "Передано другому оператору", "Другое"});
                        mapCallsType.put("Транспортная компания", new String[]{"trans_comp", "Заказ", "Консультация", "Дорого", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Корректировка", "Доп.информация", "Опоздание", "Жалоба", "Не можем предоставить", "Передано другому оператору", "Сорвался", "Перевод в отдел кадров","Перевод в КО", "Перевод в ОКК", "Перевод в такси", "Ошиблись / Не по груз-кам", "Проверка связи"});
                        mapCallsType.put("Сборный груз", new String[]{"consolidate", "Заказ", "Консультация", "Дорого", "Не сборный груз", "Нет ответа", "Нет ответа", "Не сможем предоставить", "Изменение заказа", "Не актуально"});
                        mapCallsType.put("Чат отдела продаж", new String[]{"sales_depart", "Заказ", "Консультация", "Дорого", "Запрос на сборный груз", "Корректировка", "Доп.информация", "Не можем предоставить", "Передано другому оператору", "Другое"});
                        mapCallsType.put("Консультации", new String[]{"consultation", "Заказ", "Просил перезвонить", "Уже не интересует", "Не берёт трубку", "Дорого", "Скидка не нужна", "Переехали с нами", "Переехали сами", "Конкуренты", "Сами перезвонят", "Другое"});
                        mapCallsType.put("Жалобы", new String[]{"complaint", "Жалоба на оператора", "Жалоба на экипаж", "Опоздание", "Внести изменения в заказ", "Пересчёт", "Неверный тип авто", "Нарушение ПДД", "Не согласен с доп.часами", "Проверка номера телефона", "Не согласен со стоимостью", "Проверка стоимости заказа", "Данные", "Неверная дата", "Заказ с сайта", "Онлайн оплата", "Перегородил дорогу", "Сломался/замена авто", "Порча груза", "Другое"});
                        /* формируем функцию isRequired4Order() для установки required в cost при выборе "Заказ" */
                        out.print("<script>"
                                + "function isRequired4Order() {"
                                + "if ($('#truck1').is(':checked') || "
                                + "$('#evac1').is(':checked') || "
                                + "$('#consolidate1').is(':checked') || "
                                + "$('#sales_depart1').is(':checked') || "
                                + "$('#consultation1').is(':checked')) $('#cost').prop('required', true);"
                                + "else $('#cost').prop('required', false);"
                                + "}</script>" );
                        out.print("<input type='number' id='cost' name='cost' step='10' style='width: 152px; margin-left: 12px; padding: 0 0 0 12px' placeholder='Стоимость заказа'>"); 
                        for (Map.Entry<String, String[]> map : mapCallsType.entrySet()) { 
                            out.print("<div class='section' id='" + map.getValue()[0] + "'>");
                            for (int i = 1; i < map.getValue().length; i++) {
                                out.print("<div class='selection'>"
                                        + "<input id='" + (map.getValue()[0] + i) + "' onclick='isRequired4Order()' required type='radio' class='radio' name='callsType' value='" + map.getValue()[i] + "'/>"
                                        + "<label for='" + (map.getValue()[0] + i) + "'>" + map.getValue()[i] + "</label>");
                                out.print("</div>");
                            } 
                            out.print("</div>");
                        }
                    %>    
                    </div>
                </div> 
            </form> 
        </div>
    </body>
</html>