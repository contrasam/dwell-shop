<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dwell Shop</title>

    <link rel="favicon" href="${context_path}/images/favicon.ico" />
    <link href="${context_path}/css/bootstrap.css" rel="stylesheet">
    <link href="${context_path}/css/main.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="https://code.jquery.com/jquery-git2.js"></script>
    <script src="${context_path}/js/bootstrap.js"></script>
    <script src="${context_path}/js/main.js"></script>
</head>


<body>

<#include "header.ftl" >

<div class="content">

${page_content}

</div><!-- /.container -->

<#include "footer.ftl" >
</body>

</html>
