<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Dwell Shop</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li ><a href="${context_path}/home">Home</a></li>
                <li ><a href="${context_path}/search">Search</a></li>
                <#if logged_in_user??>
                    <li><a href="${context_path}/property">My Properties</a></li>
                    <li><a href="${context_path}/home/logout">Logout</a></li>
                    <p class="navbar-text navbar-right">Signed in as <a href="#" class="navbar-link">${logged_in_user}</a></p>
                <#else>
                    <li><a href="${context_path}/home/login_form">Login</a></li>
                </#if>
            </ul>
            <img src="${context_path}/images/logo.png" class="logo"/>
        </div><!--/.nav-collapse -->
    </div>
</nav>
<header></header>


