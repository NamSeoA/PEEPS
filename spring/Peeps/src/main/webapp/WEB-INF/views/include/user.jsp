<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   
        <div class="jumbotron">
            <div id="profile_wrap">
                <img src="<c:url value='/navi/chick.jsp' />">
                <div id="pro_btn">
                    <ul>
                        <li>아이디</li>
                        <li><button id="pro_edit"><a href="#">프로필 편집</a></button></li>
                    </ul>

                    <ul>
                        <li>게시물</li>
                        <li>NN</li>
                        <li>팔로워</li>
                        <li><button id="foll_btn">NN</button></li>
                        <li>팔로잉</li>
                        <li> <button id="foll_btn">NN</button></li>
                    </ul>
                    <div id="pro_name">사용자 이름</div>
                    <div id="pro_bio">사용자 소개글</div>



                </div>

            </div>
        </div>


     