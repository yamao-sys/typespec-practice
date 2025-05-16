import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "./request-body.tsp";
import "./response.tsp";

import "../common";

using Http;
using OpenAPI;

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
    ): SuccessResponse<SignUpValidationErrorResponse>
    | BadRequestErrorResponse<SignUpValidationErrorResponse>
    | InternalServerErrorResponse;
  }

  interface SignUp {
    @route("/signUp")
    @operationId("post-auth-sign_up")
    @summary("Sign Up")
    @post
    post(
      @multipartBody body: SignUpInput,
    ): SuccessResponse<SignUpValidationErrorResponse>
    | BadRequestErrorResponse<SignUpValidationErrorResponse>
    | InternalServerErrorResponse;
  }

  interface SignIn {
    @route("/signIn")
    @operationId("post-auth-sign_in")
    @summary("Sign In")
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
