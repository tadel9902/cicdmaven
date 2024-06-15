package ptithcm.admin.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.bean.UploadFile;
import ptithcm.controller.AccountController;
import ptithcm.entity.AuthorEntity;
import ptithcm.entity.BookEntity;
import ptithcm.entity.CategoryEntity;
import ptithcm.entity.CompanyEntity;
import ptithcm.serviceimpl.AuthorServiceImpl;
import ptithcm.serviceimpl.CategoryServiceImpl;
import ptithcm.serviceimpl.CompanyServiceImpl;
import ptithcm.serviceimpl.HomeServiceImpl;
import ptithcm.serviceimpl.StatisticsServiceImpl;

@Controller
public class BookAdminController {
	@Autowired
	@Qualifier("uploadfile")
	UploadFile UpFile;
	
	@Autowired
	HomeServiceImpl homeServiceImpl;
	
	@Autowired
	CategoryServiceImpl categoryServiceImpl;
	
	@Autowired
	CompanyServiceImpl companyServiceImpl;
	
	@Autowired
	AuthorServiceImpl authorServiceImpl;
	
	@Autowired
	StatisticsServiceImpl statisticsServiceImpl;
	
	private int currentpage = 1;
	private int maxpage = 1;
	private int pagesize = 1;
	private int hienthi = 1;
	private String order = "id_book"; // book_name / id_book / price / total_quantity
	private String dir = "asc"; 
	
	@RequestMapping("admin/book")
	public String bookAdmin(HttpServletRequest request, ModelMap model, RedirectAttributes ra) {
		getMaxPage();
		ra.addFlashAttribute("username", AccountController.getUser().getUsername());
		if(order.equals("id_book")) {
			model.addAttribute("orderpage", "id");
		}else if(order.equals("book_name")){
			model.addAttribute("orderpage", "name");
		}else if(order.equals("price")){
			model.addAttribute("orderpage", "price");
		}else if(order.equals("total_quantity")){
			model.addAttribute("orderpage", "quantity");
		}
		request.setAttribute("dirpage", dir);
		if(dir.equals("asc")) {
			request.setAttribute("orderLink", "desc");
		}else {
			request.setAttribute("orderLink", "asc");
		}
		
		request.setAttribute("books", homeServiceImpl.bookPage(currentpage, hienthi, order, dir));
		request.setAttribute("count", homeServiceImpl.getBookCount());
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("currentpage", currentpage);
		request.setAttribute("pagesize", pagesize);
		System.out.println("------------------- SEARCH");
		request.setAttribute("categories", categoryServiceImpl.dsCategory());
		request.setAttribute("publishers", companyServiceImpl.dsCompany());
		request.setAttribute("authors", authorServiceImpl.dsAuthor());
		request.setAttribute("total_profit", statisticsServiceImpl.getProfitThisYear());
		request.setAttribute("total_orders", statisticsServiceImpl.getOrdersCountThisYear());
		request.setAttribute("total_users", statisticsServiceImpl.getUsersCount());
		return "admin/book";
	}
	
	@RequestMapping(value = "admin/book", params = "page")
	public String authorPage(@RequestParam(required = true) int page, @RequestParam("order") String o,
			@RequestParam("dir") String d, HttpServletRequest request) {
		if(o.equals("id")) {
			order = "id_book";
		}else if(o.equals("name")) {
			order = "book_name";
		}else if(o.equals("price")) {
			order = "price";
		}else if(o.equals("quantity")) {
			order = "total_quantity";
		}
		
		if(d.equals("asc")) {
			dir = "asc";
		}else if(d.equals("desc")) {
			dir = "desc";
		}
		
		getMaxPage();
		if(page > maxpage) {
			page = 1;
		}
		request.setAttribute("count", homeServiceImpl.getBookCount());
		request.setAttribute("books", homeServiceImpl.bookPage(page, hienthi, order, dir));
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("currentpage", page);
		request.setAttribute("total_profit", statisticsServiceImpl.getProfitThisYear());
		request.setAttribute("total_orders", statisticsServiceImpl.getOrdersCountThisYear());
		request.setAttribute("total_users", statisticsServiceImpl.getUsersCount());
		request.setAttribute("categories", categoryServiceImpl.dsCategory());
		request.setAttribute("publishers", companyServiceImpl.dsCompany());
		request.setAttribute("authors", authorServiceImpl.dsAuthor());
		//
		currentpage = page;
		request.setAttribute("pagesize", pagesize);
		
		if(order.equals("id_book")) {
			request.setAttribute("orderpage", "id");
		}else if(order.equals("book_name")){
			request.setAttribute("orderpage", "name");
		}else if(order.equals("price")){
			request.setAttribute("orderpage", "price");
		}else if(order.equals("total_quantity")){
			request.setAttribute("orderpage", "quantity");
		}
		request.setAttribute("dirpage", dir);
		if(dir.equals("asc")) {
			request.setAttribute("orderLink", "desc");
		}else {
			request.setAttribute("orderLink", "asc");
		}
		
	    return "admin/book";
	}
	
	@RequestMapping(value = "admin/book", params = "keyword")
	public String bookSearch(@RequestParam(required = true) String keyword, HttpServletRequest request) {
		request.setAttribute("count", homeServiceImpl.searchBookCount(keyword));
		request.setAttribute("books", homeServiceImpl.SearchBook(keyword));
		request.setAttribute("maxpage", 0);
		request.setAttribute("currentpage", 1);
		request.setAttribute("pagesize", 0);
		request.setAttribute("total_profit", statisticsServiceImpl.getProfitThisYear());
		request.setAttribute("total_orders", statisticsServiceImpl.getOrdersCountThisYear());
		request.setAttribute("total_users", statisticsServiceImpl.getUsersCount());
		request.setAttribute("categories", categoryServiceImpl.dsCategory());
		request.setAttribute("publishers", companyServiceImpl.dsCompany());
		request.setAttribute("authors", authorServiceImpl.dsAuthor());
	    return "admin/book";
	}
	
	@RequestMapping(value = "admin/book/save", method = RequestMethod.POST)
	public String bookSave(RedirectAttributes ra, @RequestParam("idBook") int idBook, @RequestParam("bookName") String bookName,
			@RequestParam("bookAuthor") String bookAuthor, @RequestParam("bookCompay") String bookCompay,
			@RequestParam("bookCategory") String bookCategory, @RequestParam("bookQuantity") int bookQuantity,
			@RequestParam("publishDay") @DateTimeFormat(pattern="yyyy-MM-dd") Date publishDay, @RequestParam("bookPrice") int bookPrice,
			@RequestParam("bookDescription") String bookDescription,  @RequestParam("image") MultipartFile image) {
		
		String filename = "";
			try {
				
				if(idBook == 0 && image.isEmpty()) {
					filename = "tieng-anh7.jpg";
				}
				if(image.isEmpty() == false) {
					String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) +"_";
					filename = date + image.getOriginalFilename();
					String path = UpFile.getBasePath() + File.separator + filename;
					image.transferTo(new File(path));
				}
				System.out.println("BẮT ĐẦU OKE");
				
				bookName = bookName.trim();
				BookEntity A = new BookEntity();
				A.setBook_name(bookName);
				// Xu ly Category
				bookCategory = bookCategory.trim();
				if(categoryServiceImpl.checkNameCategory(-1, bookCategory) == false) {
					System.out.println("TRÙNG CATEGORY");
					CategoryEntity C = new CategoryEntity();
					C.setCategory_name(bookCategory);
					categoryServiceImpl.addCategory(C);
					A.setCategory(C);
				}else {
					System.out.println("KHÔNG TRÙNG CATEGORY");
					CategoryEntity C = categoryServiceImpl.getCategorybyName(bookCategory);
					System.out.println("CATEGORY C = "+C);
					A.setCategory(C);
					System.out.println("SET CATEGORY THÀNH CÔNG");
				}
				
				System.out.println("CATEGORY OKE");
				// Xu ly Author
				bookAuthor = bookAuthor.trim();
				if(authorServiceImpl.checkNameAuthor(-1, bookAuthor) == false) {
					AuthorEntity C = new AuthorEntity();
					C.setAuthor_name(bookAuthor);
					authorServiceImpl.addAuthor(C);
					A.setAuthor(C);
				}else {
					AuthorEntity C = authorServiceImpl.getAuthorbyName(bookAuthor);
					A.setAuthor(C);
				}
				
				System.out.println("AUTHOR OKE");
				// Xu ly Company
				bookCompay = bookCompay.trim();
				if(companyServiceImpl.checkNameCompany(-1, bookCompay) == false) {
					CompanyEntity C = new CompanyEntity();
					C.setCompany_name(bookCompay);
					companyServiceImpl.addCompany(C);
					A.setCompany(C);
				}else {
					CompanyEntity C = companyServiceImpl.getCompanybyName(bookCompay);
					A.setCompany(C);
				}
				
				System.out.println("COMPANY OKE");
				bookDescription = bookDescription.trim();
				A.setDescribe_book(bookDescription);
				A.setTotal_quantity(bookQuantity);
				A.setPrice(bookPrice);
				A.setPicture(filename);
				A.setPublish_day(publishDay);
				if(idBook == 0) {
					int result = homeServiceImpl.addBook(A);
					if(result > 0) {
						ra.addFlashAttribute("add_result", 1);
					}else {
						ra.addFlashAttribute("add_result", 2);
					}
				}else {
					A.setId_book(idBook);
					if(image.isEmpty() == true) {
						A.setPicture(homeServiceImpl.getBookbyID(idBook).getPicture());
					}
					int result = homeServiceImpl.updateBook(A);
					if(result > 0) {
						ra.addFlashAttribute("edit_result", 1);
					}else {
						ra.addFlashAttribute("edit_result", 2);
					}
				}
				
			}catch(Exception e) {
				ra.addFlashAttribute("add_result", 3);
			}
			
			getMaxPage();
			if(currentpage > maxpage) {
				if(currentpage != 1)
					currentpage -= 1;
			}
			String od = "";
			if(order.equals("id_book")) {
				od = "id_book";
			}else if(order.equals("book_name")) {
				od = "name";
			}else if(order.equals("price")) {
				od = "price";
			}else if(order.equals("total_quantity")) {
				od = "quantity";
			}
			return "redirect:/admin/book.htm?page="+currentpage+"&order="+od+"&dir="+dir;
		
	}
	
	@RequestMapping(value = "admin/book/delete", params = "idBook", method = RequestMethod.POST)
	public String authorDelete(@RequestParam(required = true) int idBook,  RedirectAttributes ra) {
		if(homeServiceImpl.getBookbyID(idBook) == null) {
			ra.addFlashAttribute("delete_result", 0);
		}else {
			if(homeServiceImpl.checkDeleteBook(idBook) == false) {
				ra.addFlashAttribute("delete_result", -1);
			}else {
				int result = homeServiceImpl.deleteBook(idBook);
				if(result > 0) {
					ra.addFlashAttribute("delete_result", 1);
				}else {
					ra.addFlashAttribute("delete_result", 2);
				}
			}
			
		}
		getMaxPage();
		if(currentpage > maxpage) {
			if(currentpage != 1)
				currentpage -= 1;
		}
		String od = "";
		if(order.equals("id_book")) {
			od = "id_book";
		}else if(order.equals("book_name")) {
			od = "name";
		}else if(order.equals("price")) {
			od = "price";
		}else if(order.equals("total_quantity")) {
			od = "quantity";
		}
		return "redirect:/admin/book.htm?page="+currentpage+"&order="+od+"&dir="+dir;
	}
	
	public int getMaxPage() {
		int bookcount = (int) homeServiceImpl.getBookCount(); // 6
		if(bookcount == 0) {
			hienthi = 1;
		}else if(bookcount < 6) {
			hienthi = bookcount;
			pagesize = 1;
		}
		else if(bookcount < 11) {
			hienthi = 5;
			pagesize = 2;
		}else {
			hienthi = 5;
			pagesize = 3;
		}
		if(bookcount % hienthi == 0) {
			maxpage = bookcount / hienthi;
		}else {
			maxpage = (int)(bookcount / hienthi) + 1;
		}
		return maxpage;
	}
	
}
