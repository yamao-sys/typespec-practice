// Import or define HttpPart
import "@typespec/http";
using Http;

@summary("Sign Up Input")
model SignUpInput {
  firstName: HttpPart<string>;
    lastName: HttpPart<string>;
    email: HttpPart<string>;
    password: HttpPart<string>;
    birthday?: HttpPart<plainDate>;
    frontIdentification?: HttpPart<bytes>;
    backIdentification?: HttpPart<bytes>;
}

@summary("SignUpValidationError")
model SignUpValidationError {
  firstName?: string[];
  lastName?: string[];
  email?: string[];
  password?: string[];
  birthday?: string[];
  frontIdentification?: string[];
  backIdentification?: string[];
}

@summary("Sign In Input")
model SignInInput {
	email: string;
	password: string;
}
