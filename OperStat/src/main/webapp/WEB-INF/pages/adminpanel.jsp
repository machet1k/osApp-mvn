<%@page import="ru.gruzovichkof.operstat.web.Authentication"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.lang.String"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet;"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate;"%>
<%@page import="java.time.format.DateTimeFormatter;"%>
<%@page import="org.apache.poi.ss.usermodel.*;"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%  // параметры для подключения к базе данных hrdb           
            String url = "jdbc:derby://localhost:1527/osdb";
            String username = "root";
            String password = "hermes";
            String from = String.valueOf(session.getAttribute("from"));
            String to = String.valueOf(session.getAttribute("to"));
            String line = String.valueOf(session.getAttribute("line"));
            String login = String.valueOf(session.getAttribute("login"));
            String city = String.valueOf(session.getAttribute("city"));
            String calls_type = String.valueOf(session.getAttribute("calls_type"));
            String add_func = String.valueOf(session.getAttribute("add_func"));
            String cost = String.valueOf(session.getAttribute("cost"));
            String load_capacity = String.valueOf(session.getAttribute("load_capacity"));
            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat vwFormat = new SimpleDateFormat("dd.MM.yyyy");
            // получение соединения с БД, расположенной по url, используя username/password     
            Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();
            String query = String.valueOf(request.getSession().getAttribute("queryForAdminPanel"));
            ResultSet rs = statement.executeQuery(query);
            
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = null;
            Row row = null;
            int numRow = 0;
            int numCell = 0;
        %>
<!DOCTYPE html>
<html>
    <head>      
        <title>Результаты выгрузки</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
        <!--link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"-->
        <link rel="icon" type="image/png" href="https://image.ibb.co/foupj6/favicon.png" sizes="16x16">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script language="javascript">           
        /*    function visibilityOfAddFunc(val){
                if (val == "Большегрузы") $('#load_capacity').css("visibility", 'visible');
                else $('#load_capacity').css("visibility", 'hidden');
            }
           
                out.print("$(document).ready(function(){visibilityOfAddFunc('" + add_func + "'); });");
        */
        </script>
    </head>
    <body>
        <div class="containerDownload">
            <div class="row">
                <div class="panel panel-default">
                    <div id="download">
                        <form action="GetExcel" method="Get">
                            <div class="pull-right" style="margin: 20px 10px 20px 0">
                                <button type="submit" class="btn btn-success">Скачать .xls</button>
                            </div>
                        </form>
                        <form action="Download" method="Post">
                            <div>&ensp;</div>

                            <% out.print("<div>Выгрузить с <input type='datetime-local' name='from' required value='" + from.replace(' ', 'T').substring(0, 16) + "'></div>"); %>

                            <% out.print("<div> по <input type='datetime-local' name='to' required value='" + to.replace(' ', 'T').substring(0, 16) + "'></div>"); %>

                            <%
                                if (!"null".equals(line)) out.print("<div>Номер линии<input type='text' name='line' placeholder='Все' value='" + line + "'></div>");
                                else out.print("<div>Номер линии<input type='text' name='line' placeholder='Все'></div>");
                            %>

                            <div>Город
                                <select class="gap-bottom" name="city">
                                    <%
                                        String[] arrCity = {"Санкт-Петербург", "Москва", "Воронеж", "Екатеринбург", "Иркутск", "КавМинВоды", "Казань", "Калининград", "Краснодар", 
                                                            "Красноярск", "Новосибирск", "Омск", "Пермь", "Петрозаводск", "Ростов-на-Дону", "Самара", "Тула", "Уфа", "Челябинск"};
                                        String[] arrCitySelected = new String[arrCity.length];
                                        for (int z = 0; z < arrCitySelected.length; z++) arrCitySelected[z] = "";
                                        out.print("<option value='null'>Все</option>");
                                        for (int i = 0; i < arrCity.length; i++) {
                                            if (arrCity[i].equals(city)) arrCitySelected[i] = "selected";
                                            out.print("<option " + arrCitySelected[i] + " value='" + arrCity[i] + "'>" + arrCity[i] + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div>Функционал
                                <select class="gap-bottom" name="add_func"> 
                                    <%
                                        String[] arrAddFunc = {"Линия", "Большегрузы", "VIP линия", "Эвакуаторы", "Транспортная компания", "Сборный груз", "Чат отдела продаж", "Консультации", "Жалобы"};
                                        String[] arrAddFuncSelected = new String[arrAddFunc.length];
                                        for (int z = 0; z < arrAddFuncSelected.length; z++) arrAddFuncSelected[z] = "";
                                        out.print("<option value='null'>Все</option>");
                                        for (int i = 0; i < arrAddFunc.length; i++) {
                                            if (arrAddFunc[i].equals(add_func)) arrAddFuncSelected[i] = "selected";
                                            out.print("<option " + arrAddFuncSelected[i] + " value='" + arrAddFunc[i] + "'>" + arrAddFunc[i] + "</option>");
                                        }
                                    %>
                                </select>
                            </div>  
                            <div id="load_capacity" style="width: 170px">Тип авто 
                                <select class="gap-bottom" name="load_capacity">
                                    <%
                                        String[] arrLoadCapacity = {"3 т.", "3 т. гидроборт", "3 т. рефрижератор",
                                                                 "5 т.", "5 т. гидроборт", "5 т. рефрижератор",
                                                                "10 т.","10 т. гидроборт","10 т. рефрижератор",
                                                                "20 т.","20 т. гидроборт","20 т. рефрижератор",
                                                                "Автокран","Автовышка","Манипулятор","Самосвал","Тралл",
                                                                "Экскаватор-погрузчик","Фронтальный погрузчик","Ямобур"};
                                        String[] arrLoadCapacitySelected = new String[arrLoadCapacity.length];                                       
                                        out.print("<option value='null'>Все</option>");
                                        for (int i = 0; i < arrLoadCapacity.length; i++) {
                                            arrLoadCapacitySelected[i] = "";
                                            if (arrLoadCapacity[i].equals(load_capacity)) arrLoadCapacitySelected[i] = "selected";
                                            out.print("<option " + arrLoadCapacitySelected[i] + " value='" + arrLoadCapacity[i] + "'>" + arrLoadCapacity[i] + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                                
                            <div class="downloadbtn">
                                <button type="submit" class="btn btn-info">Выгрузить</button>
                                <!--button class="btn" onclick="this.form.reset();">Очистить</button-->
                            </div>
                            <a href="/os/sign-out">Выход [<% out.print(login); %>]</a>
                        </form>
                    </div> 

                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#panel1">#1 Типы по датам</a>
                        </li>
                        <li>
                            <a data-toggle="tab" href="#panel2">#2 Операторы по типам</a>
                        </li>
                        <li>
                            <a data-toggle="tab" href="#panel3">#3 Выгрузка из БД</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div id="panel1" class="tab-pane fade in active">
                            <%
                                // #1 Типы по датам
                                Connection connection1 = DriverManager.getConnection(url, username, password);
                                Statement statement1 = connection1.createStatement();
                                String query1 = "select date(regtime) as date, calls_type, count(*) as count from calls where "
                                        + "regtime >= '" + from + "' and regtime <= '" + to + "' ";
                                if (!"".equals(line)) query1 += "and line = '" + line + "' ";
                                if (!"null".equals(city)) query1 += "and city = '" + city + "' ";
                                if (!"null".equals(calls_type)) query1 += "and calls_type = '" + calls_type + "' ";
                                if (!"null".equals(add_func)) query1 += "and add_func = '" + add_func + "' ";
                                if (!"null".equals(cost)) query1 += "and cost = '" + cost + "' ";
                                if (!"null".equals(load_capacity)) query1 += "and load_capacity = '" + load_capacity + "' ";
                                query1 += "group by date(regtime), calls_type "
                                        + "order by date(regtime), calls_type";
                                System.out.println("#1 Типы по датам: " + query1);
                                ResultSet rs1 = statement1.executeQuery(query1);
                                // инициализация 
                                int lengthOfArrMap = (int) ((dbFormat.parse(to).getTime() - dbFormat.parse(from).getTime()) / (60 * 60 * 24 * 1000)) + 1;
                                HashMap[] arrMap = new HashMap[lengthOfArrMap];
                                for (int i = 0; i < lengthOfArrMap; i++) {
                                    arrMap[i] = new HashMap<String, Integer>();
                                }
                                // заполнение
                                int i = 0;
                                Date currentDate = null;
                                Date previousDate = null;
                                if (rs1.next()) {
                                    currentDate = dbFormat.parse(rs1.getString(1));
                                    
                                    int beginEmptyDays = (int)(currentDate.getTime() - dbFormat.parse(from).getTime()) / (60 * 60 * 24 * 1000);
                                    for (int day = 0; day < beginEmptyDays; day++) i++;
                                    
                                    arrMap[i].put(rs1.getString(2), rs1.getString(3));
                                }
                                while (rs1.next()) {
                                    previousDate = currentDate;
                                    currentDate = dbFormat.parse(rs1.getString(1));
                                    if (!currentDate.equals(previousDate)) {
                                        int emptyDays = (int)(currentDate.getTime() - previousDate.getTime()) / (60 * 60 * 24 * 1000);
                                        for (int day = 0; day < emptyDays; day++) i++; // Подсчёт ПУСТЫХ ДНЕЙ 
                                    }
                                    arrMap[i].put(rs1.getString(2), rs1.getString(3));
                                }
                        // Вывод на экран
                        sheet = workbook.createSheet("Типы по датам");
                        row = sheet.createRow(numRow++);
                        
                        row.createCell(numCell++).setCellValue("Тип");
                                
                                out.print("<table><tr class='bold'><td>Тип</td>");
                                Date firstDay = dbFormat.parse(from);
                                // 1st line
                                for (int j = 0; j < lengthOfArrMap; j++) {
                        row.createCell(numCell++).setCellValue(vwFormat.format(firstDay));
                                    out.print("<td>" + vwFormat.format(firstDay) + "</td>");
                                    firstDay.setDate(firstDay.getDate() + 1);
                                }
                                out.print("</tr>");
                                
                                Map<String, String[]> mapCallsType = new HashMap<String, String[]>();
                                mapCallsType.put("Линия", new String[]{"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Перевод на 20 т.", "Отдел кадров", "Перевод другому оператору", "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался", "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)"});
                                mapCallsType.put("Большегрузы", new String[]{"Заказ", "Отказ", "Консультация", "Ждёт звонка", "Нет машин на запрошенное время", "По ПДД не можем предоставить", "Дорого", "Узнавал цену, мониторинг", "Не отвечает", "Уже не актуально", "Просил перезвонить", "Ждёт ответа из ТО"});
                                mapCallsType.put("VIP линия", new String[]{"Заказ", "Консультация", "Дорого", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Корректировка", "Доп.информация", "Опоздание", "Жалоба", "Не можем предоставить", "Передано другому оператору", "Сорвался", "Перевод в отдел кадров","Перевод в КО", "Перевод в ОКК", "Перевод в такси", "Ошиблись / Не по груз-кам", "Проверка связи"});    
                                mapCallsType.put("Эвакуаторы", new String[]{"Заказ", "Консультация", "Дорого", "Не можем предоставить", "Передано другому оператору", "Другое"});
                                mapCallsType.put("Транспортная компания", new String[]{"Заказ", "Консультация", "Дорого", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Корректировка", "Доп.информация", "Опоздание", "Жалоба", "Не можем предоставить", "Передано другому оператору", "Сорвался", "Перевод в отдел кадров","Перевод в КО", "Перевод в ОКК", "Перевод в такси", "Ошиблись / Не по груз-кам", "Проверка связи"});
                                mapCallsType.put("Сборный груз", new String[]{"Заказ", "Консультация", "Дорого", "Не сборный груз", "Нет ответа", "Нет ответа", "Не сможем предоставить", "Изменение заказа", "Не актуально"});
                                mapCallsType.put("Чат отдела продаж", new String[]{"Заказ", "Консультация", "Дорого", "Запрос на сборный груз", "Корректировка", "Доп.информация", "Не можем предоставить", "Передано другому оператору", "Другое"});
                                mapCallsType.put("Консультации", new String[]{"Заказ", "Просил перезвонить", "Уже не интересует", "Не берёт трубку", "Дорого", "Скидка не нужна", "Переехали с нами", "Переехали сами", "Конкуренты", "Сами перезвонят", "Другое"});
                                mapCallsType.put("Жалобы", new String[]{"Жалоба на оператора", "Жалоба на экипаж", "Опоздание", "Внести изменения в заказ", "Пересчёт", "Неверный тип авто", "Нарушение ПДД", "Не согласен с доп.часами", "Проверка номера телефона", "Не согласен со стоимостью", "Проверка стоимости заказа", "Данные", "Неверная дата", "Заказ с сайта", "Онлайн оплата", "Перегородил дорогу", "Сломался/замена авто", "Порча груза", "Другое"});
                                mapCallsType.put("null", new String[]{"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался", "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)", "Отказ", "Ждёт звонка", "Нет машин на запрошенное время", "По ПДД не можем предоставить", "Узнавал цену, мониторинг", "Не отвечает", "Уже не актуально", "Просил перезвонить", "Ждёт ответа из ТО", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Жалоба", "Передано другому оператору", "Перевод в отдел кадров", "Перевод в ОКК", "Перевод в такси", "Другое", "Не сборный груз", "Нет ответа", "Не сможем предоставить", "Изменение заказа", "Не актуально", "Уже не интересует", "Не берёт трубку", "Скидка не нужна", "Переехали с нами", "Переехали сами", "Конкуренты", "Сами перезвонят", "Жалоба на оператора", "Жалоба на экипаж", "Внести изменения в заказ", "Пересчёт", "Неверный тип авто", "Нарушение ПДД", "Не согласен с доп.часами", "Проверка номера телефона", "Не согласен со стоимостью", "Проверка стоимости заказа", "Данные", "Неверная дата", "Заказ с сайта", "Онлайн оплата", "Перегородил дорогу", "Сломался/замена авто", "Порча груза"});
                                // data                               
                                for (int ind = 0; ind < mapCallsType.get(add_func).length; ind++) {
                        numCell = 0;
                        row = sheet.createRow(numRow++);
                        row.createCell(numCell++).setCellValue(mapCallsType.get(add_func)[ind]);
                                    out.print("<tr><td>" + mapCallsType.get(add_func)[ind] + "</td>");
                                    for (int j = 0; j < arrMap.length; j++) {
                                        if (arrMap[j].get(mapCallsType.get(add_func)[ind]) != null) {
                        row.createCell(numCell++).setCellValue(Integer.parseInt(String.valueOf(arrMap[j].get(mapCallsType.get(add_func)[ind]))));
                                            out.print("<td>" + arrMap[j].get(mapCallsType.get(add_func)[ind]) + "</td>");
                                        } else {
                        row.createCell(numCell++).setCellValue(0);
                                            out.print("<td>0</td>");
                                        }
                                    }
                                    out.print("</tr>");
                                }
                                out.print("</table>");
                                
                            %>
                        </div>
                        <div id="panel2" class="tab-pane fade">
                            <%
                                // #2 Операторы по типам
                                Connection connection2 = DriverManager.getConnection(url, username, password);
                                Statement statement2 = connection2.createStatement();
                                String query2 = "select line, users.surname, users.name, calls_type, count(*) as count from calls left join users on calls.line = users.login "
                                        + "where regtime >= '" + from + "' and regtime <= '" + to + "' ";
                                        if (!"null".equals(city)) query2 += "and city = '" + city + "' ";
                                        if (!"null".equals(add_func)) query2 += "and add_func = '" + add_func + "' ";
                                        if (!"null".equals(load_capacity)) query2 += "and load_capacity = '" + load_capacity + "' ";
                                        query2 += "group by line, users.surname, users.name, calls_type order by line";
                                System.out.println("#2 Операторы по типам: " + query2);
                                ResultSet rs2 = statement2.executeQuery(query2);
                                
                                HashMap po_operam = new HashMap<String, HashMap<String, String>>();
                                /* Обрабатываем первую строку выгрузки:
                                   000 Иванов Иван Заказ 7
                                   000 Иванов Иван Консультация 1
                                   111 Петров Пётр Заказ 5
                                */
                                String prevLineName = "";
                                HashMap type_count = null;
                                if (rs2.next()) {
                                    prevLineName = rs2.getString(1) + "</td><td>" + rs2.getString(2) + " " + rs2.getString(3);
                                    type_count = new HashMap<String, String>();
                                    type_count.put(rs2.getString(4), rs2.getString(5));
                                
                                    // остальные строки 
                                    while (rs2.next()) {
                                        String nextLineName = rs2.getString(1) + "</td><td>" + rs2.getString(2) + " " + rs2.getString(3);
                                        if (nextLineName.equals(prevLineName)) type_count.put(rs2.getString(4), rs2.getString(5));
                                        else {
                                            po_operam.put(prevLineName, type_count);   
                                            type_count = new HashMap<String, String>();
                                            type_count.put(rs2.getString(4), rs2.getString(5));
                                        }
                                        prevLineName = nextLineName;
                                    }
                                    po_operam.put(prevLineName, type_count); // добавление последнего оператора
                                    // вывод на экран
                            for (int column = 0; column < lengthOfArrMap; column++) sheet.autoSizeColumn(column);
                            sheet = workbook.createSheet("Операторы по типам");
                            numCell = 0; 
                            numRow = 0;
                            row = sheet.createRow(numRow++);
                            row.createCell(numCell++).setCellValue("№ линии");
                            row.createCell(numCell++).setCellValue("Фамилия Имя оператора");
                                    out.print("<table><tr class='bold'><td>№ линии</td><td class='wider'>Фамилия Имя оператора</td>");
                                    for (int j = 0; j < mapCallsType.get(add_func).length; j++) {           
                            row.createCell(numCell++).setCellValue(mapCallsType.get(add_func)[j]);
                                        out.print("<td>" + mapCallsType.get(add_func)[j] + "</td>");
                                    }
                                    out.print("</tr>");
                                    Iterator<Map.Entry<String, HashMap<String, String>>> iter = po_operam.entrySet().iterator();
                                    while (iter.hasNext()) {
                                        out.print("<tr>");
                                        Map.Entry<String, HashMap<String, String>> map = iter.next();
                            numCell = 0;
                            row = sheet.createRow(numRow++);
                            String[] arr_line_name = map.getKey().split("</td><td>");
                            row.createCell(numCell++).setCellValue(arr_line_name[0]);
                            row.createCell(numCell++).setCellValue(arr_line_name[1]);
                            
                                        out.print("<td>" + map.getKey() + "</td>");
                                        for (int j = 0; j < mapCallsType.get(add_func).length; j++) {
                                            String count = map.getValue().get(mapCallsType.get(add_func)[j]);
                                            if (count != null) {
                            row.createCell(numCell++).setCellValue(Integer.parseInt(count));
                                                out.print("<td>" + count + "</td>");
                                            } else {
                            row.createCell(numCell++).setCellValue(0);
                                                out.print("<td>0</td>");
                                            }
                                        }
                                        out.print("</tr>");
                                    }
                                    out.print("</table>");
                                } else {
                                    out.print("<table><tr><td>Нет данных</td></tr></table>");
                                }
                            %>
                        </div>
                        <div id="panel3" class="tab-pane fade">
                            <table>  
                                <% // #3 Выгрузка
                            for (int column = 0; column < mapCallsType.get(add_func).length; column++) sheet.autoSizeColumn(column);
                                    
                            sheet = workbook.createSheet("Выгрузка из БД");
                            numRow = 0;
                            numCell = 0;
                            row = sheet.createRow(numRow++);
                                    
                                    out.print("<tr class='bold'>");
                                    String[] columns_db = new String[]{"ID","Время звонка","Номер линии","Фамилия","Имя","Город","Тип звонка","Функционал","Стоимость заказа","Тип автомобиля"};
                                    
                                    for (int j = 0; j < columns_db.length; j++) {
                                        out.print("<td>" + columns_db[j] + "</td>");
                            row.createCell(numCell++).setCellValue(columns_db[j]); 
                                    }
                                    out.print("</tr>");

                                    while (rs.next()) {
                            numCell = 0;
                            row = sheet.createRow(numRow++);
                            
                            out.print("<tr>");
                            for (int j = 1; j < 11; j++) {
                                if (rs.getString(j) != null) {
                                    row.createCell(numCell++).setCellValue(rs.getString(j));
                                    out.print("<td>" + rs.getString(j) + "</td>");
                                } else {
                                    out.print("<td>–</td>");
                                }
                            }
                            out.print("</tr>");
                                    }
                                    
                                    for (int column = 0; column < columns_db.length; column++) sheet.autoSizeColumn(column);
                                    
                                    // освобождение ресурсов
                                    connection.close();
                                    connection = null;
                                    statement.close();
                                    statement = null;
                                    rs.close();
                                    rs = null;
                                    connection1.close();
                                    connection1 = null;
                                    statement1.close();
                                    statement1 = null;
                                    rs1.close();
                                    rs1 = null;
                                    connection2.close();
                                    connection2 = null;
                                    statement2.close();
                                    statement2 = null;
                                    rs2.close();
                                    rs2 = null;
                                    /*request.getSession().setAttribute("line", null);
                                    request.getSession().setAttribute("city", null);
                                    request.getSession().setAttribute("calls_type", null);
                                    request.getSession().setAttribute("add_func", null);
                                    request.getSession().setAttribute("cost", null);
                                    request.getSession().setAttribute("load_capacity", null);*/
                                    
                                    request.getSession().setAttribute("workbook", workbook);
                                %>
                            </table>
                        </div>
                    </div>        
                </div>
            </div> 
        </div>
    </div>                   
</body>
</html>