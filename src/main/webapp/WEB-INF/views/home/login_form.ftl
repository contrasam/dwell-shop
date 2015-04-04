<div class="login-form">
    <h3>Login</h3>
<p>
    <@flash name="login_error"/>
</p>
<form method="POST" action="${context_path}/home/login">
    <input type="email" class="form-control text-box-top-margin" placeholder="Email address" name="email_address" />
    <input type="password" class="form-control text-box-top-margin" placeholder="Enter Password" name="password" />
    <input type="submit" class="btn btn-primary" value="Login"/>
</form>
</div>