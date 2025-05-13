import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "../models/auth.tsp";
import "../models/common.tsp";

using Http;
using OpenAPI;

model SignUpValidationErrorResponse {
	code: integer;
	errors: SignUpValidationError;
}

@tag("auth")
@route("/auth")
namespace SampleService.Auth {
	interface ValidateSignUp {
		@route("/validateSignUp")
		@operationId("post-auth-validate_sign_up")
		@summary("Validate SignUp")
		@post
		post(
			@multipartBody body: SignUpInput,
		): Models.Common.SuccessResponse<SignUpValidationErrorResponse> | Models.Common.BadRequestResponse<SignUpValidationErrorResponse> | Models.Common.InternalServerErrorResponse;
  }

	interface SignUp {
		@route("/signUp")
		@operationId("post-auth-sign_up")
		@summary("SignUp")
		@post
		post(
			@multipartBody body: SignUpInput,
		): Models.Common.SuccessResponse<SignUpValidationErrorResponse> | Models.Common.BadRequestResponse<SignUpValidationErrorResponse> | Models.Common.InternalServerErrorResponse;
  }

	interface SignIn {
		@route("/signIn")
		@operationId("post-auth-sign_in")
		@summary("SignIn")
		@post
		post(
			@body body: SignInInput,
		): {
			@header("Set-Cookie") SetCookie?: string;
			@body body: {};
		} | {
			@statusCode statusCode: 400;
			@body body: {
				errors: string[];
			};
		} | {
			@statusCode statusCode: 500;
			@body body: {
				code: integer;
				message: string;
			};
		};
	}
}
