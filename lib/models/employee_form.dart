class EmployeeForm {
  String _email;
  String _name;
  String _mobile_no;
  String _user_type;

  EmployeeForm(this._email, this._name, this._mobile_no, this._user_type);

  String toParam() =>
      "?name=$_name&email=$_email&mobile_no=$_mobile_no&user_type=$_user_type";

      
}
