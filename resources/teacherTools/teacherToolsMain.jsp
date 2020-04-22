<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="springForm" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Locale"%>
<%@ page import="java.util.ResourceBundle"%>
<% 

Locale loc = request.getLocale();
String lang = loc.getDisplayLanguage();

ResourceBundle rb = null;
try {
	rb = ResourceBundle.getBundle("MathSpring",loc);
}
catch (Exception e) {
//	logger.error(e.getMessage());	
}
%>

<!DOCTYPE HTML>
<html>
<head>
    <meta name="theme-color" content="#ffffff">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/img/apple-touch-icon.png">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="${pageContext.request.contextPath}/css/manifest.json">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap/css/style.css">
    <link href="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom/css/spring/jquery-ui-1.10.4.custom.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="<c:url value="/js/bootstrap/css/bootstrap.min.css" />"/>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/ttStyleMain.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"
          rel="stylesheet"/>
    <!-- Datatables Css Files -->
    <link href="https://cdn.datatables.net/1.10.13/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <link href="https://cdn.datatables.net/colreorder/1.3.2/css/colReorder.bootstrap4.min.css" rel="stylesheet"
          type="text/css">
          
    <link rel="stylesheet" href="<c:url value="/css/live_dashboard.css" />"/>

    <jsp:useBean id="random" class="java.util.Random" scope="application"/>

    <style>
        .buttonCustomColor {
            color: #FFFFFF;
        }
    </style>

    <script type="text/javascript" src="<c:url value="/js/bootstrap/js/jquery-2.2.2.min.js" />"></script>
    <!-- js for bootstrap-->
    <script type="text/javascript" src="<c:url value="/js/bootstrap/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/js/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"/>"></script>

    <script type="text/javascript"
            src="<c:url value="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" />"></script>
    <script type="text/javascript"
            src="<c:url value="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap4.min.js" />"></script>
    <script type="text/javascript"
            src="<c:url value="https://cdn.datatables.net/colreorder/1.3.2/js/dataTables.colReorder.min.js" />"></script>
    <script type="text/javascript"
            src="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js" />"></script>
      <script type="text/javascript" src="<c:url value="/js/bootstrap/js/language_es.js" />"></script>
      <script src="<c:url value="https://d3js.org/d3.v4.min.js" />"></script> 
      <script type="text/javascript" src="<c:url value="/js/live_student_details.js" />"></script>  
      <script type="text/javascript" src="<c:url value="/js/dashboard.js" />"></script>
           
    <script type="text/javascript">
        var servletContextPath = "${pageContext.request.contextPath}";
        $(document).ready(function () {
            $('#wrapper').toggleClass('toggled');
            $("#report-wrapper").show();
            $("#report-wrapper2").show();
            $("#form-wrapper").hide();
            handleclickHandlers();
        });
      
        function handleclickHandlers() {
            $("#create_class_form").bootstrapValidator({
                // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    className: {
                        validators: {
                            notEmpty: {
                                message: 'Class name is mandatory field'
                            }
                        }
                    },
                    classGrade: {
                        validators: {
                            notEmpty: {
                                message: 'Class grade is mandatory field'
                            }
                        }
                    },
                    lowEndDiff: {
                        validators: {
                            notEmpty: {
                                message: 'Grade level of problems - Lower is mandatory field'
                            }
                        }
                    }, highEndDiff: {
                        validators: {
                            notEmpty: {
                                message: 'Grade level of problems - Higher is mandatory field'
                            }
                        }
                    }, town: {
                        validators: {
                            notEmpty: {
                                message: 'Town name is a mandatory field'
                            }
                        }
                    }, schoolName: {
                        validators: {
                            notEmpty: {
                                message: 'School name is a mandatory field'
                            }
                        }
                    }, schoolYear: {
                        validators: {

                            between: {
                                min: new Date().getFullYear(),
                                max: 2050,
                                message: 'The academic year should not be greater than 2050 and less than current year'
                            },

                            notEmpty: {
                                message: 'School year is a mandatory field'
                            }
                        }
                    }, gradeSection: {
                        validators: {
                            notEmpty: {
                                message: 'Section name is a mandatory field'
                            }
                        }
                    }
                }
            }).on('success.form.bv', function (e) {
                $("#create_class_form").data('bootstrapValidator').resetForm();
                e.preventDefault();
                var $form = $(e.target);
                var bv = $form.data('bootstrapValidator');
                $.post($form.attr('action'), $form.serialize(), function (result) {
                })
            });

            $("#createClass_handler").click(function () {
                $("#report-wrapper").hide();
                $("#report-wrapper2").hide();
                $("#liveDashboard").hide();
                $("#live_student_details").hide();
                $("#form-wrapper").show();
            });
            
            $("#live_dashboard").click(function () {
                $("#report-wrapper").hide();
                $("#report-wrapper2").hide();
                $("#form-wrapper").hide();
                $("#live_student_details").hide();
                $("#liveDashboard").show();
                loadStudents();
            });

            $(".StudentButton").click(function () {
                $("#report-wrapper").hide();
                $("#report-wrapper2").hide();
                $("#form-wrapper").hide();
                $("#liveDashboard").hide();
                $("#live_student_details").show();
                //getStudentDetails();
                console.log("live_student_details is clicked!");
            });
            
            $('#PageRefresh').click(function () {
                location.reload();
            });
        }

    </script>
</head>

<body>
<div id="wrapper">
    <!-- Sidebar -->
    <nav class="navbar navbar-inverse navbar-fixed-top" id="topbar-wrapper" role="navigation">
        <ul class="nav sidebar-nav">
            <li class="sidebar-brand">
                <a href="#">
                    <i class="fa fa-tachometer" aria-hidden="true"></i> <%= rb.getString("teacher_tools") %>
                </a>
            </li>
        </ul>
        <ul class="nav navbar-right top-nav buttonCustomColor">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i
                        class="fa fa-user"></i> ${fn:toUpperCase(teacherName)} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li>
                        <a id= "profile_selector" href="#"><i class="fa fa-fw fa-user"></i> <%= rb.getString("profile") %></a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a id="logout_selector" href="<c:out value="${pageContext.request.contextPath}"/>/tt/tt/logout"><i
                                class="fa fa-fw fa-power-off"></i><%= rb.getString("log_out") %></a>
                    </li>
                </ul>
            </li>
        </ul>
    </nav>
    <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
        <ul class="nav sidebar-nav">
            <li>
                <a id="PageRefresh" href="#"><i
                        class="fa fa-fw fa-home"></i> <%= rb.getString("home") %></a>
            </li>
            <li>
                <a id="live_dashboard" href="#"><i
                        class="fa fa-fw fa-line-chart"></i> <%= "Live dashboard"%></a>
            </li>
            <li>
                <a href="#" id="createClass_handler"><i class="fa fa-fw fa-pencil"></i> <%= rb.getString("create_new_class") %></a>
            </li>
            <li>
                <a id="survey_problems_site" href="http://rose.cs.umass.edu/msadmin?${teacherId}"><i class="fa fa-fw fa-pencil"></i><%= rb.getString("create_surveys_and_math_problems") %></a>
            </li>
        </ul>
        <!-- /#sidebar-end -->
    </nav>
    <div id="page-content-wrapper">
        <div id="content-container" class="container-fluid">
        
            <div id="liveDashboard" style="display: none;">
	            <h1 class="studentId">Real-Time Student Dashboard</h1>
	           <!--  <script type="text/javascript" src="./js/dashboard.js"></script> 
	            <script type="text/javascript" src="<c:url value="/js/dashboard.js" />"></script>-->
	            <div id="student_tiles"></div>
        	</div>
        	
        	<div id="live_student_details" style="display: none;text-align:center">
	            <h1>Live Student Details</h1>
	            <h3 id="studentname"></h3>
			    <div class="upperStudentDetail">
					<div id="linechart" class="split left">
					</div>
					<div id="pie_chart" class="split right">
					</div>
				</div>
	             <br>
	             <div id="lowerStudentdetail">
					<div id="bar_chart" class="split left">
					</div>
					<div id="perf_detail" class="split right">
						<div id="last5masteries"></div>
						<br><br>
						<div id="last5efforts"></div>
						<br><br>
						<div id="last2topics"></div>
					</div>
				 </div>
	
	             <br>
	             <div class="refreshStudent">
	             	<button id="refreshButton">Refresh</button>
	             </div>
	             
        	</div>
        	

            <div id="report-wrapper" class="row">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            <c:choose>
                                <c:when test="${noClass == false}">
                                    <small><%= rb.getString("existing_classes") %></small>
                                </c:when>
                                <c:otherwise>
                                    <small><%= rb.getString("no_pre-existing_classes") %></small>
                                </c:otherwise>
                            </c:choose>

                        </h1>
                    </div>
                </div>
                <!-- /.row -->
                <c:if test="${noClass == false}">
                <c:set var="colorpicker" value="${['panel-green','panel-red','panel-primary','panel-yellow']}"/>
                <c:set var="thumbNailPicker" value="${['fa-bar-chart','fa-area-chart','fa-pie-chart','fa-line-chart']}"/>
                <c:forEach var="c" items="${classbean.classes}" varStatus="loop">
                <c:set var="randomColorIndex" value="${random.nextInt(fn:length(colorpicker))}"/>
                <c:set var="randomChartIndex" value="${random.nextInt(fn:length(thumbNailPicker))}"/>
                <c:if test="${(loop.index == 0 || loop.index%4  == 0)}">
                <c:set var="terminator" value="${loop.index + 3}"/>
                <div class="row">
                    </c:if>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel ${colorpicker[randomColorIndex]}">
                            <div class="panel-heading">

                                <div class="row">

                                    <div class="col-xs-3">
                                        <i class="fa ${thumbNailPicker[randomChartIndex]}
										fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">${c.name}</div>
                                    </div>
                                </div>
                            </div>
                            <a href="<c:out value="${pageContext.request.contextPath}"/>/tt/tt/viewClassDetails?teacherId=${teacherId}&classId=${c.classid}">
                                <div class="panel-footer">
                                    <span class="pull-left"><%= rb.getString("view_details") %></span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <c:if test="${loop.index == terminator}">
                    <!-- t div-->
                </div>
                </c:if>
                <c:if test="${loop.last == 'true'}">
                <!-- s div-->
            </div>
            </c:if>
            </c:forEach>
            </c:if>
        </div>
        <div id="report-wrapper2" class="row">
         <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                           <small><%= rb.getString("existing_classes_archived") %></small>
                        </h1>
                    </div>
         </div>
          <c:if test="${noClass == false}">
                <c:set var="colorpicker" value="${['panel-green','panel-red','panel-primary','panel-yellow']}"/>
                <c:set var="thumbNailPicker" value="${['fa-bar-chart','fa-area-chart','fa-pie-chart','fa-line-chart']}"/>
                <c:forEach var="c" items="${classbeanArchived.classes}" varStatus="loop">
                <c:set var="randomColorIndex" value="${random.nextInt(fn:length(colorpicker))}"/>
                <c:set var="randomChartIndex" value="${random.nextInt(fn:length(thumbNailPicker))}"/>
                <c:if test="${(loop.index == 0 || loop.index%4  == 0)}">
                <c:set var="terminator" value="${loop.index + 3}"/>
                <div class="row">
                    </c:if>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel ${colorpicker[randomColorIndex]}">
                            <div class="panel-heading">

                                <div class="row">

                                    <div class="col-xs-3">
                                        <i class="fa ${thumbNailPicker[randomChartIndex]}
										fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">${c.name}</div>
                                    </div>
                                </div>
                            </div>
                            <a href="<c:out value="${pageContext.request.contextPath}"/>/tt/tt/viewClassDetails?teacherId=${teacherId}&classId=${c.classid}">
                                <div class="panel-footer">
                                    <span class="pull-left"><%= rb.getString("view_details") %></span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <c:if test="${loop.index == terminator}">
                    <!-- t div-->
                </div>
                </c:if>
                <c:if test="${loop.last == 'true'}">
                <!-- s div-->
            </div>
            </c:if>
            </c:forEach>
            </c:if>
            </div>
        <div id="form-wrapper" style="display: none;">
            <div class="col-lg-12">
                <h1 class="page-header">
                    <small><%= rb.getString("class_setup") %></small>
                </h1>
            </div>
            <springForm:form id="create_class_form" method="post"
                             action="${pageContext.request.contextPath}/tt/tt/ttCreateClass"
                             modelAttribute="createClassForm">
                <div class="row">
                    <div id="create_class_out" class="col-md-6 col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <%= rb.getString("part_one_class_configuration") %>
                            </div>
                             <div class="panel-body">
                               <div class="form-group">
                                    <label for="classLanguage"><%= rb.getString("class_language") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-education"></i></span>
                                        <springForm:select path="classLanguage" class="form-control" id="classLanguage"
                                                           name="classLanguage">
                                            <springForm:option value=""><%= rb.getString("select_language_for_class") %></springForm:option>
                                            <springForm:option value="en:English"><%= rb.getString("english") %></springForm:option>
                                            <springForm:option value="es:Spanish"><%= rb.getString("spanish") %></springForm:option>
                                        </springForm:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="className"><%= rb.getString("class_name") %></label>
                                    <div class="input-group">
                                    <span class="input-group-addon"><i
                                            class="glyphicon glyphicon-blackboard"></i></span>
                                        <springForm:input path="className" id="className" name="className"
                                                          class="form-control" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="town"><%= rb.getString("town") %></label>
                                    <div class="input-group">
                                    <span class="input-group-addon"><i
                                            class="glyphicon glyphicon-tree-deciduous"></i></span>
                                        <springForm:input path="town" id="town" name="town"
                                                          class="form-control"
                                                          type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="schoolName"><%= rb.getString("school") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-university"></i></span>
                                        <springForm:input path="schoolName" id="schoolName" name="schoolName"
                                                          class="form-control" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="schoolYear"><%= rb.getString("year") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-hourglass"></i></span>
                                        <springForm:input path="schoolYear" id="schoolYear" name="schoolYear"
                                                          class="form-control" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="gradeSection"><%= rb.getString("section") %></label>
                                    <div class="input-group">
                                    <span class="input-group-addon"><i
                                            class="glyphicon glyphicon-menu-hamburger"></i></span>
                                        <springForm:input path="gradeSection" id="gradeSection" name="gradeSection"
                                                          class="form-control" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="classGrade"><%= rb.getString("class_grade") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-education"></i></span>
                                        <springForm:select path="classGrade" class="form-control" id="classGrade"
                                                           name="classGrade">
                                            <springForm:option value=""><%= rb.getString("select_grade") %></springForm:option>
                                            <springForm:option value="5"><%= rb.getString("grade") %> 5</springForm:option>
                                            <springForm:option value="6"><%= rb.getString("grade") %> 6</springForm:option>
                                            <springForm:option value="7"><%= rb.getString("grade") %> 7</springForm:option>
                                            <springForm:option value="8"><%= rb.getString("grade") %> 8</springForm:option>
                                            <springForm:option value="9"><%= rb.getString("grade") %> 9</springForm:option>
                                            <springForm:option value="10"><%= rb.getString("grade") %> 10</springForm:option>
                                            <springForm:option value="adult"><%= rb.getString("adult") %>Adult</springForm:option>
                                        </springForm:select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="lowEndDiff"><%= rb.getString("problem_complexity_lower") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-education"></i></span>
                                        <springForm:select path="lowEndDiff" class="form-control" id="lowEndDiff"
                                                           name="lowEndDiff">
                                            <springForm:option value=""><%= rb.getString("select_complexity") %></springForm:option>
                                            <springForm:option value="below3"><%= rb.getString("three_grades_below") %></springForm:option>
                                            <springForm:option value="below2"><%= rb.getString("two_grades_below") %></springForm:option>
                                            <springForm:option value="below1"><%= rb.getString("one_grades_below") %></springForm:option>
                                            <springForm:option value="below0"><%= rb.getString("no_grades_below") %></springForm:option>
                                        </springForm:select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="highEndDiff"><%= rb.getString("problem_complexity_higher") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i
                                                class="glyphicon glyphicon-education"></i></span>
                                        <springForm:select path="highEndDiff" class="form-control" id="highEndDiff"
                                                           name="highEndDiff">
                                            <springForm:option value=""><%= rb.getString("select_complexity") %></springForm:option>
                                            <springForm:option value="above3"><%= rb.getString("three_grades_above") %></springForm:option>
                                            <springForm:option value="above2"><%= rb.getString("two_grades_above") %></springForm:option>
                                            <springForm:option value="above1"><%= rb.getString("one_grades_above") %></springForm:option>
                                            <springForm:option value="above0"><%= rb.getString("one_grades_above") %></springForm:option>
                                        </springForm:select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="add_students_out" class="col-md-6 col-sm-6">
                        <div id="add_students_out_panel_default" class="panel panel-default">
                            <div class="panel-heading">
                               <%= rb.getString("part_two_student_roster") %>
                            </div>

                            <div class="panel-body">
                                <span class="input-group label label-warning">P.S</span>
                                <label><%= rb.getString("student_name_instructions") %></label>
                            </div>

                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="userPrefix"><%= rb.getString("student_username_prefix") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user-o"></i></span>
                                        <springForm:input path="userPrefix" id="userPrefix" name="userPrefix"
                                                          class="form-control" type="text"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="passwordToken"><%= rb.getString("student_password") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-eye"></i></span>
                                        <springForm:input path="passwordToken" id="passwordToken" name="passwordToken"
                                                          class="form-control" type="password"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="noOfStudentAccountsForClass"><%= rb.getString("number_IDs_to_create") %></label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-location-arrow"></i></span>
                                        <springForm:input path="noOfStudentAccountsForClass"
                                                          id="noOfStudentAccountsForClass"
                                                          name="noOfStudentAccountsForClass" class="form-control"
                                                          type="text"/>
                                    </div>
                                </div>
                                <input type="hidden" name="teacherId" id="teacherId" value="${teacherId}">
                            </div>
                        </div>
                    </div>
                </div>
                <div style="text-align:center;">
                    <button role="button" type="submit" class="btn btn-primary"><%= rb.getString("create_class") %></button>
                </div>
            </springForm:form>
        </div>
    </div>
    <!--#page-container ends-->
</div>
<!--#page-content-wrapper ends-->

<!--Wrapper!-->


</body>
</html>