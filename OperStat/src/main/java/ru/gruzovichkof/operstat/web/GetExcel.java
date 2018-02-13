package ru.gruzovichkof.operstat.web;

import ru.gruzovichkof.operstat.core.AbstractServlet;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Workbook;

@WebServlet("/GetExcel")
public class GetExcel extends AbstractServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Workbook workbook = (Workbook) getSession().getAttribute("workbook");

        try {
            try (FileOutputStream out = new FileOutputStream("OperStatApp.xlsx")) { 
                workbook.write(out);
                System.out.println("Файл создан!");
            }
        } catch (IOException e) {
            System.out.println("Что-то не так!");
        } catch (NullPointerException e) {
            System.out.println("Проверьте, не открыт ли у Вас файл Статистика.xlsx");
        }
        
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-disposition","attachment; filename=OperStatApp.xlsx");

        // файл, который вы отправляете
        File file = new File("OperStatApp.xlsx");

        // отправить файл в response
        OutputStream out = response.getOutputStream();
        try (FileInputStream in = new FileInputStream(file)) {
            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
        out.flush();
        redirect("/os");
    }
}
