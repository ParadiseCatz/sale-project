var NumberRegex=/^\d+$/;
var CCregex=/^\d{12}$/;
var CCverif=/^\d{3}$/;
var email=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
function validateRegister(form){
	
	var CorrectInput = true;
	if (form.fullname.value=="" || form.username.value=="" || form.email.value=="" || form.password.value=="" || form.confirmpassword.value=="" || form.fulladdress.value=="" || form.postalcode.value=="" || form.phonenumber.value==""){
		alert('Form tidak boleh kosong!');
		return false;
	}
	else
	{
		if (!email.test(form.email.value)){
		alert('Invalid Email');
		form.email.focus();
		CorrectInput=false;
		}
		if (form.password.value!=form.confirmpassword.value){
			alert('Password not match');
			form.password.focus();
			CorrectInput=false;
		}
		if (!NumberRegex.test(form.postalcode.value)){
			alert('Postalcode harus berupa angka')
			form.postalcode.focus();
			CorrectInput=false;
		}
		if (!NumberRegex.test(form.phonenumber.value)){
			alert('Phone Number harus berupa angka')
			form.postalcode.focus();
			CorrectInput=false;
		}
		return CorrectInput;
	}
}	

function validateConfirmPurchase(form){
	var CorrectInput = true;
	if (form.consignee.value=="" || form.fulladdress.value=="" || form.postalcode.value=="" || form.phonenumber.value=="" || form.creditcardnumber.value=="" || form.creditcardverification.value==""){
		alert('Form tidak boleh kosong!');
		return false;
	}
	else
	{
		if (!NumberRegex.test(form.postalcode.value)){
			alert('Postalcode harus berupa angka')
			form.postalcode.focus();
			CorrectInput=false;
		}
		if (!NumberRegex.test(form.phonenumber.value)){
			alert('Phone Number harus berupa angka')
			form.phonenumber.focus();
			CorrectInput=false;
		}
		if (!CCregex.test(form.creditcardnumber.value)){
			alert('Invalid Credit Card Number')
			form.creditcardnumber.focus();
			CorrectInput=false;
		}
		if (!CCverif.test(form.creditcardverification.value)){
			alert('Invalid Credit Card Verification')
			form.creditcardnumber.focus();
			CorrectInput=false;
		}
	}
	if (CorrectInput==true){
		var confirmation=confirm("Apakah data yang Anda masukkan benar?");
		if (confirmation==true){
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		return false;
	}
}

function validateAddProduct(form){
	CorrectInput=true;
	if (form.Name.value=="" || form.Description.value=="" || form.Price.value==""){
		alert("Form tidak boleh kosong!");
		return false;
	}
	else
	if (form.File.value==''){
		alert("Harap upload gambar");
		return false;
	}
	else
	{
		var FilePath=form.File.value;
		var UploadExtension=FilePath.substring(FilePath.lastIndexOf('.')+1).toLowerCase();
		if (UploadExtension=="jpg" || UploadExtension=="jpeg" || UploadExtension=="png" || UploadExtension=="bmp"){
			CorrectInput=true;
		}
		else
		{
			alert("Ekstensi File yang diizinkan hanya JPG,JPEG,BMP, dan PNG");
			CorrectInput=false;
		}
		if (!NumberRegex.test(form.Price.value)){
			alert("Harga harus berupa angka")
			CorrectInput=false;
		}
		return CorrectInput;
	}
}
