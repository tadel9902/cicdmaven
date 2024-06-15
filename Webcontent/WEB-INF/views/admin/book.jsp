<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix = 'c' %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BOOK ADMIN</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"
    />

    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="<c:url value = '/include/css/bootstrap.css' />" />
    <link rel="stylesheet" href="<c:url value = '/include/css/toast.css' />" />
    <link rel="stylesheet" href="<c:url value = '/include/css/app.css' />" />
    <link rel="stylesheet" href="<c:url value = '/include/css/admin/book_admin.css' />" />
    <link rel="icon" href="<c:url value = '/images/favico.png' />" sizes="32x32" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="<c:url value = '/include/js/jquery.twbsPagination.js' />" type="text/javascript"></script>
  </head>

  <body>
    <div id="app doan">
      <div class="background_black" id="background_black">
        <!-- Xu ly xoa book -->
        <form method="post" action="<c:url value = '/admin/book/delete.htm' />" class="confirm_container remove_class bg-white">
          <input type="hidden" name="idBook" value="xxx">
          <div
            class="confirm_header text-white bg-primary"
            style="padding: 10px; font-weight: 700"
          >
            <i class="fas fa-check-circle" style="color: #47f764"></i>
            Xác Nhận Xóa
          </div>
          <div
            class="confirm_content"
            style="padding: 10px; text-align: center"
          >
            Bạn chắc chắn muốn xóa sách có id: <b>2</b>
          </div>
          <div class="confirm_buttons">
            <button
              class="btn btn-success me-1 mb-2 btn_xacnhan_xoa"
              style="margin: 0px 10px"
              type="submit"
            >
              Xác Nhận
            </button>
            <button
              class="btn btn-danger me-1 mb-2 btn_huy_xoa"
              style="margin: 0px 10px"
              type="button"
            >
              Hủy
            </button>
          </div>
        </form>
        <!-- Ket thuc xu ly xoa book -->

        <!-- Xu ly add Book -->
        <form class="row col-7 add_book_class" method="post" enctype="multipart/form-data" action="<c:url value = '/admin/book/save.htm' />" style="background-color: #f2f7ff; border-radius: 3px 3px 0 0;padding: 0 !important; box-shadow: 0 4px 8px #62b0fd, 0 4px 12px rgb(0 0 0 / 8%);">
          <!-- Value = 0 thì thêm (ADD) còn > 0 thì sửa (EDIT)  -->
              <input type="hidden" name="idBook" value="0" />
          <div
            class="bg-primary"
            style="
              display: flex;
              align-items: center;
              justify-content: space-between;
              padding: 15px 20px;
            "
          >
            <div class="text-white add_book_class_header">Thêm Sách</div>
            <i
              class="far fa-times-circle btn-close-from"
              id="add_book_exit"
              style="color: white; font-size: 25px"
            ></i>
          </div>
          <div class="row" style="margin: 10px">
            <div class="col-7">
              <div style="margin-bottom: 20px">
                <label class="form-label"
                  >Tên Sách</label
                >
                <input
                  class="form-control"
                  id="bookname_input"
                  name="bookName"
                  type="text"
                  placeholder="VD: Đắc Nhân Tâm"
                />
                <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Tên sách đang để trống</p>
              </div>

              <div
                style="
                  display: flex;
                  justify-content: space-between;
                  margin-bottom: 20px;
                "
              >
                <div style="position: relative;">
                  <label class="form-label"
                    >Tác giả</label
                  >
                  <input
                    class="form-control"
                    id="bookauthor_input"
                    name="bookAuthor"
                    type="text"
                    placeholder="VD: Nguyễn Nhật Ánh"
                  />
                  <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Tên tác giả không được để trống</p>
                  <select multiple id="author_select" class="form-control box-options" style="position: absolute;z-index: 1;display: none;">
					<c:forEach var = "item" items = "${authors}">
						<option value="${item.author_name}">${item.author_name}</option>
					</c:forEach>
				  </select>
                </div>
                <div style="position: relative;">
                  <label class="form-label"
                    >Nhà Xuất Bản</label
                  >
                  <input
                    class="form-control"
                    id="bookcompany_input"
                    name="bookCompay"
                    placeholder="VD: Kim Đồng"
                  />
                  <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Tên NXB đang để trống</p>
                  <select for="publisher" multiple="" id="publisher_select" class="form-control box-options" style="position: absolute;display: none;">
					<c:forEach var = "item" items = "${publishers}">
						<option value="${item.company_name}">${item.company_name}</option>
					</c:forEach>
				  </select>
                </div>
              </div>

              <div
                style="
                  display: flex;
                  justify-content: space-between;
                  margin-bottom: 10px;
                "
              >
                <div class = "div_input_category" style="position: relative;">
                  <label class="form-label"
                    >Danh mục sách</label
                  >
                  <input
                    class="form-control"
                    id="bookcategory_input"
                    name="bookCategory"
                    placeholder="VD: Sách thiếu nhi"
                  />
                  <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Tên thể loại đang để trống</p>
                  <select for="category" multiple="" id="category_select" class="form-control box-options" style="position: absolute;display: none;">
					<c:forEach var = "item" items = "${categories}">
						<option value="${item.category_name}">${item.category_name}</option>
					</c:forEach>
				  </select>
                </div>
                <div>
                  <label class="form-label"
                    >Số lượng</label
                  >
                  <input
                    class="form-control"
                    id="bookquantity_input"
                    name="bookQuantity"
                    type="number"
                    placeholder="VD: 1000"
                  />
                  <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Số lượng đang để trống hoặc < 0</p>
                </div>
              </div>

              <div
                style="
                  display: flex;
                  justify-content: space-between;
                  margin-bottom: 10px;
                "
              >
                <div>
                  <label class="form-label" for="basic-form-dob"
                    >Ngày xuất bản</label
                  >
                  <input
                    class="form-control"
                    id="datepickerfrom"
                    name="publishDay"
                    type="date"
                  />
                  <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Ngày XB đang để trống</p>
                </div>
                <div>
                  <label class="form-label"
                    >Giá</label
                  >
                  <input
                    class="form-control"
                    id="bookprice_input"
                    name="bookPrice"
                    type="number"
                    placeholder="VD: 1,000,000đ"
                  />
                  <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Giá sách đang để trống hoặc < 0</p>
                </div>
              </div>

              <div style="margin-bottom: 5px">
                <label class="form-label" for="exampleFormControlTextarea1"
                  >Mô tả sản phẩm</label
                >
                <textarea
                  class="form-control"
                  id="bookdescription_input"
                  name="bookDescription"
                  rows="3"
                ></textarea>
                <p class = "text-danger" style="font-size: 14px;font-weight: bold;display:none;margin-bottom: 0px;">Hãy nhập mô tả sản phẩm</p>
              </div>
            </div>
            <div class="col-5">
              <div style="margin-bottom: 20px">
                <label class="form-label">Upload Image</label>
                <input class="form-control" accept="image/*" type="file" name="image" id="upload" onchange="upfile()" />
              </div>

              <div class="image_upload" style="height: 64%">
                <img id = "image_before_upload"
                  src="<c:url value = '/images/upload.png' />"
                  alt=""
                  style="width: auto; height: 100%; max-height: 350px;"
                />
              </div>
            </div>
          </div>

          <div style="text-align: center; margin-bottom: 10px">
            <button type="button" class="btn btn-primary btn_add_book_submit">
              Xác Nhận
            </button>
          </div>
          </form>
        </div>
      </div>
      <!-- Ket thuc xu ly addBook -->

      <!-- Xu ly toast -->
      <div class="toast_class"></div>
      <!-- Ket thuc xu ly toast -->
      <div id="sidebar" class="active">
        <div class="sidebar-wrapper active">
          <div class="sidebar-header">
            <div class="d-flex justify-content-between">
              <div class="logo">
                <a href="<c:url value = '/admin/statistics.htm' />" style="text-decoration: none"
                  ><img
                    src="<c:url value = '/images/logo.png' />"
                    style="height: 40px"
                    alt="Logo"
                    srcset=""
                  />
                  <span style="font-size: 25px">BOOKSTORE</span></a
                >
              </div>
            </div>
          </div>
          <div class="sidebar-menu">
            <ul class="menu">
              <li class="sidebar-title">Danh Mục Quản Lý</li>

              <li class="sidebar-item">
                <a href="<c:url value = '/admin/statistics.htm' />" class="sidebar-link">
                  <i class="fas fa-chart-bar"></i>
                  <span>Statistics</span>
                </a>
              </li>

              <li class="sidebar-item active">
                <a href="<c:url value = '/admin/book.htm' />" class="sidebar-link">
                 <i class="fas fa-book"></i>
                  <span>Books</span>
                </a>
              </li>

              <li
                class="sidebar-item">
                <a href="<c:url value = '/admin/order.htm' />" class='sidebar-link'>
                    <i class="fas fa-cart-plus"></i>
                    <span>Orders</span>
                </a>
            </li>

              <li class="sidebar-item">
                <a href="<c:url value = '/admin/review.htm' />" class="sidebar-link">
                  <i class="fas fa-feather"></i>
                  <span>Review</span>
                </a>
              </li>

              <li class="sidebar-item">
                <a href="<c:url value = '/admin/customer.htm' />" class="sidebar-link">
                  <i class="fas fa-user-circle"></i>
                  <span>Customer</span>
                </a>
              </li>

              <li class="sidebar-item">
                <a href="<c:url value = '/admin/author.htm' />" class="sidebar-link">
                  <i class="fas fa-user-astronaut"></i>
                  <span>Author</span>
                </a>
              </li>

              <li class="sidebar-item">
                <a href="<c:url value = '/admin/category.htm' />" class="sidebar-link">
                  <i class="fas fa-bookmark"></i>
                  <span>Category</span>
                </a>
              </li>

              <li class="sidebar-item">
                <a href="<c:url value = '/admin/publisher.htm' />" class="sidebar-link">
                  <i class="fas fa-house-user"></i>
                  <span>Publisher</span>
                </a>
              </li>
            </ul>
          </div>
          <button class="sidebar-toggler btn x">
            <i data-feather="x"></i>
          </button>
        </div>
      </div>
      <div id="main">
        <div class="page-content">
          <section class="row">
            <div class="col-12 col-lg-12">
              <div class="row">
                <div class="col-6 col-lg-3 col-md-6">
                  <div class="card">
                    <div class="card-body px-3 py-4-5">
                      <div class="row">
                        <div class="col-md-4">
                          <div class="stats-icon purple">
                            <i class="fas fa-money-bill-alt text-c-red f-18"></i>
                          </div>
                        </div>
                        <div class="col-md-8">
                          <h6 class="text-muted font-semibold">
                            Total Profit
                          </h6>
                          <h6 class="font-extrabold mb-0"><fmt:formatNumber type="number" pattern="##,###" value="${total_profit}" /> đ</h6>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-6 col-lg-3 col-md-6">
                  <div class="card">
                    <div class="card-body px-3 py-4-5">
                      <div class="row">
                        <div class="col-md-4">
                          <div class="stats-icon blue">
                            <i class="fas fa-database text-c-blue f-18"></i>
                          </div>
                        </div>
                        <div class="col-md-8">
                          <h6 class="text-muted font-semibold">Total Oders</h6>
                          <h6 class="font-extrabold mb-0">${total_orders}</h6>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-6 col-lg-3 col-md-6">
                  <div class="card">
                    <div class="card-body px-3 py-4-5">
                      <div class="row">
                        <div class="col-md-4">
                          <div class="stats-icon green">
                            <i class="fas fa-dollar-sign text-c-green f-18"></i>
                          </div>
                        </div>
                        <div class="col-md-8">
                          <h6 class="text-muted font-semibold">Total Users</h6>
                          <h6 class="font-extrabold mb-0">${total_users}</h6>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-6 col-lg-3 col-md-6">
                  <div class="card">
                    <div class="card-body px-3 py-4-5">
                      <div class="row">
                        <div class="col-md-4">
                          <div class="stats-icon red">
                            <i class="fas fa-user text-c-yellow f-18"></i>
                          </div>
                        </div>
                        <div class="col-md-8">
                          <h6 class="text-muted font-semibold">Login Info</h6>
                          <h6 class="font-extrabold mb-0"><a href="<c:url value ='/account/login.htm' />">${username}</a> | 
                          	<span><a href="<c:url value ='/account/logout.htm' />">Logout</a></span>
                          </h6>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Phan tim kiem -->
              <div class="row">
                <div class="col-12">
                  <div class="col-lg-12 stretch-card" style="padding: 0">
                    <div class="card">
                      <div class="card-body">
                        <h4
                          class="card-title"
                          style="margin-bottom: 0 !important"
                        >
                          Tìm kiếm sách nhanh
                        </h4>
                        <form action="" id = "form_search_submit">
                          <div class="input-group" style="padding: 10px 0px">
                            <input
                              type="search"
                              class="form-control rounded"
                              placeholder="Search"
                              name="keyword"
                              aria-label="Search"
                              aria-describedby="search-addon"
                            />
                            <button
                              type="submit"
                              class="btn btn-outline-primary"
                            >
                              search
                            </button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Ket thuc tim kiem  -->

              <div class="row">
                <div class="col-12">
                  <div class="col-lg-12 stretch-card" style="padding: 0">
                    <div class="card">
                      <div class="card-body">
                        <div
                          style="
                            display: flex;
                            align-items: center;
                            justify-content: space-between;
                          "
                        >
                          <h4
                            class="card-title"
                            style="margin-bottom: 0 !important"
                          >
                            Danh sách sách hiện có
                          </h4>
                          <button
                            id="info"
                            class="btn btn-success btn_edit_book add_book_sign"
                          >
                            <i class="fas fa-plus"></i>
                            Thêm Sách
                          </button>
                        </div>

                        <div class="table-responsive pt-3">
                          <table class="table table-bordered text-center">
                            <thead>
                              <tr>
                                <th><a href="<c:url value = '/admin/book.htm?page=${currentpage}&order=id&dir=${orderLink}' />">ID</a></th>
                                <th><a href="<c:url value = '/admin/book.htm?page=${currentpage}&order=name&dir=${orderLink}' />">Name</a></th>
                                <th>Picture</th>
                                <th><a href="<c:url value = '/admin/book.htm?page=${currentpage}&order=price&dir=${orderLink}' />">Price</a></th>
                                <th><a href="<c:url value = '/admin/book.htm?page=${currentpage}&order=quantity&dir=${orderLink}' />">Total Quantity</a></th>
                                <th>Thay Đổi</th>
                              </tr>
                            </thead>
                            <tbody>
                            
                            <c:forEach var = "item" items = "${books}">
				            	<tr class="table-white">
                                <td>${item.id_book}</td>
                                <td>${item.book_name}</td>
                                <td>
                                  <img
                                    src="<c:url value = '/images/${item.picture}' />"
                                    alt=""
                                    style="height: 120px; width: auto"
                                  />
                                </td>
                                <td><fmt:formatNumber type="number" pattern="##,###" value="${item.price}" /> đ</td>
                                <td>${item.total_quantity}</td>
                                <td class="align-middle text-center">
                                  <button
                                    type="button"
                                    class="btn btn-warning m-1 btn_edit_book"
                                  >
                                    <input type="hidden" name="idBook" value="${item.id_book}"/>
                                    <i class="far fa-edit"></i>
                                  </button>
                                  <button
                                    type="button"
                                    class="btn btn-danger btn_delete_book"
                                  >
                                  <input
                                    type="hidden"
                                    name="idBook"
                                    value="${item.id_book}"
                                  />
                                    <i
                                      style="color: white"
                                      class="fa fa-trash-alt"
                                    ></i>
                                  </button>
                                </td>
                              </tr>
            				</c:forEach>
                            </tbody>
                          </table>
                        </div>
                       <!-- Xu ly phan trang -->
						<div class="container"
							style="margin-top: 10px; display: flex; justify-content: center; align-items: center;">
							<div>Số lượng: ${count}</div>
							<nav aria-label="Page navigation">
								<ul class="pagination" id="pagination"
									style="margin: 0 20px;"></ul>
							</nav>
						</div>
						<!-- Ket thuc xu ly phan trang -->
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
			<form action="<c:url value = '/admin/book.htm' />" id = "form_page">
    		<input type="hidden" value = "1" id = "page_input" name = "page">
    		<input type="hidden" value = "${orderpage}" name = "order">
    		<input type="hidden" value = "${dirpage}" name = "dir">
    	</form>
      </div>

    <script type="text/javascript">
    
    var form_page = document.querySelector("#form_page");
  	var page_input = document.querySelector("#page_input");
  	console.log(form_page);
  	var currentpage = ${currentpage};
  	var pagesize = ${pagesize};
	var maxpage = ${maxpage};
	$(function () {
    window.pagObj = $('#pagination').twbsPagination({
    	totalPages: maxpage,
        visiblePages: pagesize,
        startPage: currentpage,
        onPageClick: function (event, page) {
            if(currentpage !== page){
              page_input.setAttribute("value", page);
              console.info(page + ' (from options)');
              form_page.submit();
            }
        }
    })
});
    
    
    var add_book_exit = document.querySelector("#add_book_exit");
    var add_book_class = document.querySelector(".add_book_class");
    var remove_class = document.querySelector(".remove_class");
    var btn_add_book_submit = document.querySelector(".btn_add_book_submit");
    var btn_delete_book = document.querySelectorAll(".btn_delete_book");
    var confirm_content = document.querySelector(".confirm_content");

    console.log(add_book_exit);
    var background_black = document.querySelector("#background_black");
    add_book_exit.addEventListener("click", () => {
      background_black.style.display = "none";
      add_book_class.style.display = "none";
      console.log("CLICK");
    });
    
    function loadBookEdit(id_book_edit){
    	for(var i = 0; i<book_arr.length; i++){
    		if(book_arr[i]["idBook"] === id_book_edit){
    			author_select.style.display = "none";
    			category_select.style.display = "none";
    			publisher_select.style.display = "none";
    			$("#bookname_input").val(book_arr[i]["bookName"]);
    			$("#bookauthor_input").val(book_arr[i]["bookAuthor"]);
    			$("#bookcompany_input").val(book_arr[i]["bookCompany"]);
    			$("#bookcategory_input").val(book_arr[i]["bookCategory"]);
    			$("#datepickerfrom").val(book_arr[i]["publish_day"]);
    			$("#bookprice_input").val(book_arr[i]["price"]);
    			$("#image_before_upload").attr("src", "<c:url value = '/images/"+book_arr[i]["picture"]+"'/>");
    			$("#upload").attr("value", book_arr[i]["picture"]);
    			$("#bookquantity_input").val(book_arr[i]["total_quantity"]);
    			$("#bookdescription_input").val(book_arr[i]["describe_book"]);
    			return;
    		}
    	}
    }
    
    function removeBookEdit(){
    			$("#bookname_input").val("");
    			$("#bookauthor_input").val("");
    			$("#bookcompany_input").val("");
    			$("#bookcategory_input").val("");
    			$("#datepickerfrom").val("");
    			$("#bookprice_input").val("");
    			$("#bookquantity_input").val("");
    			$("#bookdescription_input").val("");
    			author_select.style.display = "none";
    			category_select.style.display = "none";
    			publisher_select.style.display = "none";
    }

    btn_edit_book = document.querySelectorAll(".btn_edit_book");
    console.log(btn_edit_book);
    btn_edit_book.forEach((element) => {
      element.addEventListener("click", () => {
        console.log("GOOD");
        var add_book_class_header = document.querySelector(
          ".add_book_class_header"
        );
        if (element.classList.contains("add_book_sign")) {
          add_book_class_header.innerHTML = "Thêm Sách";
          add_book_class.children[0].setAttribute("value", 0);
          removeBookEdit();
        } else {
          add_book_class_header.innerHTML = "Chỉnh Sửa Sách";
          var id_edit = element.children[0].getAttribute("value");
          add_book_class.children[0].setAttribute("value", id_edit);
          loadBookEdit(id_edit);
        }
        background_black.style.display = "block";
        add_book_class.style.display = "block";
      });
    });


    btn_delete_book.forEach((element) => {
      element.addEventListener("click", () => {
        var id_delete = element.children[0].getAttribute("value");
        remove_class.children[0].setAttribute("value", id_delete);
        confirm_content.innerHTML =
          "Bạn chắc chắn muốn xóa sách có id: <b>" + id_delete + "</b>";
        background_black.style.display = "block";
        remove_class.style.display = "block";
      });
    });

    var btn_xacnhan_xoa = document.querySelector(".btn_xacnhan_xoa");
    btn_xacnhan_xoa.addEventListener("click", () => {
      // Xoa sach thanh cong

    });

    var btn_huy_xoa = document.querySelector(".btn_huy_xoa");
    btn_huy_xoa.addEventListener("click", () => {
      background_black.style.display = "none";
      remove_class.style.display = "none";
    });
    
    
    // IMAGE
   function upfile(){
            var fileselected = document.querySelector("#upload").files;
            if(fileselected.length > 0){
                var fileToLoad = fileselected[0];
                var fileReader = new FileReader();
                fileReader.onload = function(fileLoaderEvent){
                    var scrData = fileLoaderEvent.target.result;
                    var newImage = document.querySelector("#image_before_upload");
                    newImage.src = scrData;
                }
                fileReader.readAsDataURL(fileToLoad)
            }
        }
    
    
    
    var author_select = document.querySelector("#author_select");
    var bookauthor_input = document.querySelector("#bookauthor_input");
    var category_select = document.querySelector("#category_select");
    var bookcategory_input = document.querySelector("#bookcategory_input");
    var publisher_select = document.querySelector("#publisher_select");
    var bookcompany_input = document.querySelector("#bookcompany_input");
    var div_input_category = document.querySelector(".div_input_category");
    
    
    var bookname_input = document.querySelector("#bookname_input");
	var datepickerfrom = document.querySelector("#datepickerfrom");
	var bookprice_input = document.querySelector("#bookprice_input");
	var bookdescription_input = document.querySelector("#bookdescription_input");
	var bookquantity_input = document.querySelector("#bookquantity_input");
	
	
	bookname_input.addEventListener("focus", () => {
		author_select.style.display = "none";
		category_select.style.display = "none";
		publisher_select.style.display = "none";
	})
	
	datepickerfrom.addEventListener("focus", () => {
		author_select.style.display = "none";
		category_select.style.display = "none";
		publisher_select.style.display = "none";
	})
	
	bookdescription_input.addEventListener("focus", () => {
		author_select.style.display = "none";
		category_select.style.display = "none";
		publisher_select.style.display = "none";
	})
	
	bookprice_input.addEventListener("focus", () => {
		author_select.style.display = "none";
		category_select.style.display = "none";
		publisher_select.style.display = "none";
	})
	
	bookquantity_input.addEventListener("focus", () => {
		author_select.style.display = "none";
		category_select.style.display = "none";
		publisher_select.style.display = "none";
	})
	
    btn_add_book_submit.addEventListener("click", () => {
    	var check = true;
    	if(bookname_input.value.trim().length == 0){
    		bookname_input.parentElement.children[2].style.display = "block";
    		bookname_input.style.border = "1px solid red";
    		check = false;
    	}else{
    		bookname_input.parentElement.children[2].style.display = "none";
    		bookname_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(bookprice_input.value.trim().length == 0 || bookprice_input.value < 0){
    		bookprice_input.parentElement.children[2].style.display = "block";
    		bookprice_input.style.border = "1px solid red";
    		check = false;
    	}else{
    		bookprice_input.parentElement.children[2].style.display = "none";
    		bookprice_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(datepickerfrom.value.trim().length == 0){
    		datepickerfrom.parentElement.children[2].style.display = "block";
    		datepickerfrom.style.border = "1px solid red";
    		check = false;
    	}else{
    		datepickerfrom.parentElement.children[2].style.display = "none";
    		datepickerfrom.style.border = "1px solid #dce7f1";
        }
    	
    	if(bookdescription_input.value.trim().length == 0){
    		bookdescription_input.parentElement.children[2].style.display = "block";
    		bookdescription_input.style.border = "1px solid red";  
    		check = false;
    	}else{
    		bookdescription_input.parentElement.children[2].style.display = "none";
    		bookdescription_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(bookquantity_input.value.trim().length == 0 || bookquantity_input.value < 0){
    		bookquantity_input.parentElement.children[2].style.display = "block";
    		bookquantity_input.style.border = "1px solid red"; 
    		check = false;
    	}else{
    		bookquantity_input.parentElement.children[2].style.display = "none";
    		bookquantity_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(bookauthor_input.value.trim().length == 0){
    		bookauthor_input.parentElement.children[2].style.display = "block";
    		bookauthor_input.style.border = "1px solid red"; 
    		check = false;
    	}else{
    		bookauthor_input.parentElement.children[2].style.display = "none";
    		bookauthor_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(bookcategory_input.value.trim().length == 0){
    		bookcategory_input.parentElement.children[2].style.display = "block";
    		bookcategory_input.style.border = "1px solid red";
    		check = false;
    	}else{
    		bookcategory_input.parentElement.children[2].style.display = "none";
    		bookcategory_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(bookcompany_input.value.trim().length == 0){
    		bookcompany_input.parentElement.children[2].style.display = "block";
    		bookcompany_input.style.border = "1px solid red";
    		check = false;
    	}else{
    		bookcompany_input.parentElement.children[2].style.display = "none";
    		bookcompany_input.style.border = "1px solid #dce7f1";
        }
    	
    	if(check == true){
    		add_book_class.submit();
    	}
    	
    });


	bookauthor_input.addEventListener("focus", () => {
			author_select.style.display = "flex";
			category_select.style.display = "none";
			publisher_select.style.display = "none";
	})
    
    bookauthor_input.addEventListener("input", (e) => {
    	console.log("OKEE");
    	bookauthor_input.value = e.target.value;
    	author_select.innerHTML = SearchAuthor(e.target.value);
    	
    })
    	
    author_select.addEventListener('change', (e) => {
    	bookauthor_input.value = e.target.value;
    	author_select.style.display = "none";
	});
    
    
    bookcategory_input.addEventListener("focus", () => {
    	category_select.style.display = "flex";
    	publisher_select.style.display = "none";
		author_select.style.display = "none";
    })
    
    bookcategory_input.addEventListener("input", (e) => {
    	bookcategory_input.value = e.target.value;
    	category_select.innerHTML = SearchCategory(e.target.value);
    })
    
    category_select.addEventListener('change', (e) => {
    	bookcategory_input.value = e.target.value
    	category_select.style.display = "none";
	});
    
    bookcompany_input.addEventListener("focus", () => {
    	publisher_select.style.display = "flex";
    	category_select.style.display = "none";
    	author_select.style.display = "none";
	})
    	
    publisher_select.addEventListener('change', (e) => {
    	bookcompany_input.value = e.target.value;
    	publisher_select.style.display = "none";
	});
    
    bookcompany_input.addEventListener("input", (e) => {
    	bookcompany_input.value = e.target.value;
    	publisher_select.innerHTML = SearchCompany(e.target.value);
    })
    
    
    
    var categories = [
    	<c:forEach var = "item" items = "${categories}">
    	    {category_id : '${item.category_id}',
    	    	category_name: '${item.category_name}'
    	    },
    	    </c:forEach>  
    	];
    
    
    var author_arr = [
    	<c:forEach var = "item" items = "${authors}">
    	    {id_author : '${item.id_author}',
    	    	author_name: '${item.author_name}'
    	    },
    	    </c:forEach>  
    	];
    
    var company_arr = [
    	<c:forEach var = "item" items = "${publishers}">
    	    {id_company : '${item.id_company}',
    	    	company_name: '${item.company_name}'
    	    },
    	    </c:forEach>  
    	];
    
    var book_arr = [
    	<c:forEach var = "item" items = "${books}">
    	    {idBook : '${item.id_book}',
    	    	bookName: '${item.book_name}',
    	    	describe_book: '${item.describe_book}',
    	    	picture: '${item.picture}',
    	    	price: '${item.price}',
    	    	publish_day: '${item.publish_day}',
    	    	total_quantity: '${item.total_quantity}',
    	    	bookAuthor: '${item.author.author_name}',
    	    	bookCategory: '${item.category.category_name}',
    	    	bookCompany: '${item.company.company_name}',
    	    	
    	    },
    	    </c:forEach>  
    	];
    	
    	console.log("ct = "+ categories[0]['category_id'])
    	function SearchCategory(category_name_search){
    		var div = document.createElement("div");
    		for(var i = 0; i<categories.length; i++){
        		if(categories[i]['category_name'].toLowerCase().indexOf(category_name_search.toLowerCase()) !== -1){
        			var option = document.createElement("option");
        			var bookname = categories[i]['category_name'];
        			option.value = bookname;
        			option.innerHTML = bookname;
        			div.appendChild(option);
        		}
        	}
    		return div.innerHTML;
    	}
	    	
	    		function SearchAuthor(author_name_search){
	    		var div = document.createElement("div");
	    		for(var i = 0; i<author_arr.length; i++){
	        		if(author_arr[i]['author_name'].toLowerCase().indexOf(author_name_search.toLowerCase()) !== -1){
	        			var option = document.createElement("option");
	        			var authorname = author_arr[i]['author_name'];
	        			option.value = authorname;
	        			option.innerHTML = authorname;
	        			div.appendChild(option);
	        		}
	        	}
	    		return div.innerHTML;
	    	}	
	    	
    	
    	
    	function SearchCompany(company_name_search){
    		var div = document.createElement("div");
    		for(var i = 0; i<company_arr.length; i++){
        		if(company_arr[i]['company_name'].toLowerCase().indexOf(company_name_search.toLowerCase()) !== -1){
        			var option = document.createElement("option");
        			var companyname = company_arr[i]['company_name'];
        			option.value = companyname;
        			option.innerHTML = companyname;
        			div.appendChild(option);
        		}
        	}
    		return div.innerHTML;
    	}
    	
    	
    	function createToastHTML(message, type, color, icon){ //#47f764
    		var toast_class = document.querySelector(".toast_class");
    		var div = document.createElement("div");
    		var html = "<div class = 'toast_to_left' style='position:relative; height: 90px;margin-bottom: 10px;'>"+
	    	    "<div class='toast_container' style = 'border-left: 8px solid "+color+" !important;'>"+
	            "<i class='"+icon+" toast_icon' style = 'color: "+color+" !important;'></i>"+
	            "<div class='toast_content'>"+
	              "<span style='font-weight: 700; color: "+color+";'>"+type+"</span>"+
	              "<span class='toast_content_name' style='color: #656565'>"+message+"</span>"+
	           " </div>"+
	            "<div>"+
	              "<i class='fa fa-times toast_close' style='font-size: 20px; cursor: pointer; color: #656565'aria-hidden='true'></i>"+
	            "</div></div></div>";
	            div.innerHTML = html;
            toast_class.appendChild(div);
	  		var toast_noi_dung = div.querySelector(".toast_content_name");
	  	    var toast_container = div.querySelector(".toast_container");
	  	    
  			setTimeout(() => {
  			    toast_container.classList.remove("toast_to_left");
  			    toast_container.classList.add("toast_to_right");
  			}, 2000);
  			
  			setTimeout(() => {
  			    div.remove();
  			}, 3000);

			  	var toast_close = div.querySelector(".toast_close");
			  	console.log(toast_close);
			  	toast_close.addEventListener("click", () => {
			    	div.remove();
			  	});
    	}
    	
    	
    	var result = '${edit_result}';
    	if(result != ""){
    		if(result == '1'){
	    		// Toast thành công
		  		createToastHTML("Chỉnh sửa sách thành công.", "SUCCESS", "#47f764", "fas fa-check-circle");
	    	}else if(result == '2'){
	    		// Toast thất bại
		  		createToastHTML("Chỉnh sửa sách thất bại.", "ERROR", "#DC3545", "fas fa-exclamation-triangle");
	    	}
    	}
    	
    	var result = '${delete_result}';
    	if(result != ""){
    		if(result == '1'){
	    		// Toast thành công
		  		createToastHTML("Xóa sách thành công.", "SUCCESS", "#47f764", "fas fa-check-circle");
	    	}else if(result == '2'){
	    		// Toast thất bại
		  		createToastHTML("Xóa sách thất bại.", "ERROR", "#DC3545", "fas fa-exclamation-triangle");
	    	}else if(result == '-1'){
	    		// Toast thất bại
		  		createToastHTML("Không thể xóa sách đã tồn tại trong chi tiết đơn hàng hoặc giỏ hàng hoặc đã được đánh giá.", "ERROR", "#DC3545", "fas fa-exclamation-triangle");
	    	}
    	}
    	
    	var result = '${add_result}';
    	if(result != ""){
    		if(result == '1'){
	    		// Toast thành công
		  		createToastHTML("Thêm sách thành công.", "SUCCESS", "#47f764", "fas fa-check-circle");
	    	}else if(result == '2'){
	    		// Toast thất bại
		  		createToastHTML("Thêm sách thất bại.", "ERROR", "#DC3545", "fas fa-exclamation-triangle");
	    	}else if(result == '3'){
	    		// Toast thất bại
		  		createToastHTML("Lỗi upload File.", "ERROR", "#DC3545", "fas fa-exclamation-triangle");
	    	}
    	}
    	
    	
    	// COOKIE
        document.documentElement.scrollTop = getCookie("ScrollY");

         window.addEventListener("scroll", () => {
            var x = pageYOffset;
            document.cookie = "ScrollY="+x;
         });

         function getCookie(cname) {
            let name = cname + "=";
            let decodedCookie = decodeURIComponent(document.cookie);
            let ca = decodedCookie.split(';');
            for(let i = 0; i <ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') {
                c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
                }
            }
            return "";
        }
 
    	
</script>
    <script type="text/javascript" src="<c:url value = '/include/js/admin/book_admin.js' />"></script>
  </body>
</html>

    