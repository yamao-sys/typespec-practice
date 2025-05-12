import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

using Http;
using OpenAPI;

/**
 * APIs
 */
@service(#{ title: "auth" })
@info(#{ version: "1.0", summary: "" })
namespace auth;

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

@summary("Todo Object")
model Todo {
  id: integer;
  title: string;
  content: string;
}

@summary("StoreTodoValidationError")
model StoreTodoValidationError {
  title?: string[];
  content?: string[];
}

/**
 * validate sign up
 */
@tag("auth")
@route("/auth/validateSignUp")
@post
@summary("Validate SignUp")
op `post-auth-validate_sign_up`(
  @header contentType: "multipart/form-data",

  /**
   * SignUp  Iuput
   */
  @multipartBody body: {
    firstName: HttpPart<string>;
    lastName: HttpPart<string>;
    email: HttpPart<string>;
    password: HttpPart<string>;
    birthday?: HttpPart<plainDate>;
    frontIdentification?: HttpPart<bytes>;
    backIdentification?: HttpPart<bytes>;
  },
): Body<{
  code: integer;
  errors: SignUpValidationError;
}> | {
  @statusCode statusCode: 400;
  @body body: {
    code: integer;
    errors: SignUpValidationError;
  };
} | {
  @statusCode statusCode: 500;
  @body body: {
    code: integer;
    message: string;
  };
};

@tag("auth")
@route("/auth/signUp")
@post
@summary("SignUp")
op `post-auth-sign_up`(
  @header contentType: "multipart/form-data",

  /**
   * SignUp  Iuput
   */
  @multipartBody body: {
    firstName: HttpPart<string>;
    lastName: HttpPart<string>;
    email: HttpPart<string>;
    password: HttpPart<string>;
    birthday?: HttpPart<plainDate>;
    frontIdentification?: HttpPart<bytes>;
    backIdentification?: HttpPart<bytes>;
  },
): Body<{
  code: integer;
  errors: SignUpValidationError;
}> | {
  @statusCode statusCode: 400;
  @body body: {
    code: integer;
    errors: SignUpValidationError;
  };
} | {
  @statusCode statusCode: 500;
  @body body: {
    code: integer;
    message: string;
  };
};

@tag("auth")
@route("/auth/signIn")
@post
@summary("Sign In")
op `post-auth-sign_in`(
  /**
   * SignIn  Input
   */
  @body body: {
    email: string;
    password: string;
  },
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

@tag("auth")
@route("/auth/csrf")
@get
@summary("Get Csrf")
op `get-auth-csrf`(): Body<{
  csrf_token: string;
}> | {
  @statusCode statusCode: 500;
  @body body: {
    code: integer;
    message: string;
  };
};

/**
 * Fetch Todos Schema
 */
@tag("todos")
@route("/todos")
@get
@summary("Fetch Todos")
op `get-todos`(): Body<{
  todos: Todo[];
}> | {
  @statusCode statusCode: 401;
  @body body: {
    code: integer;
    message: string;
  };
} | {
  @statusCode statusCode: 500;
  @body body: {
    code: integer;
    message: string;
  };
};

/**
 * Create Todo Schema
 */
@tag("todos")
@route("/todos")
@post
@summary("Create Todo")
op `post-todos`(
  /**
   * Todo Iuput
   */
  @body body: {
    title: string;
    content: string;
  },
):
  | Body<{
      code: integer;
      errors: StoreTodoValidationError;
    }>
  | {
      @statusCode statusCode: 400;
      @body body: {
        code: integer;
        errors: StoreTodoValidationError;
      };
    }
  | {
      @statusCode statusCode: 401;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 500;
      @body body: {
        code: integer;
        message: string;
      };
    };

/**
 * Delete Todo Schema
 */
@tag("todos")
@route("/todos/{id}")
@delete
@summary("Delete Todo")
op `delete-todo`(@path id: string):
  | Body<{
      code: integer;
      result: boolean;
    }>
  | {
      @statusCode statusCode: 401;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 404;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 500;
      @body body: {
        code: integer;
        message: string;
      };
    };

/**
 * Show Todo Schema
 */
@tag("todos")
@route("/todos/{id}")
@get
@summary("Show Todo")
op `get-todo`(@path id: string):
  | Body<{
      todo: Todo;
    }>
  | {
      @statusCode statusCode: 401;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 404;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 500;
      @body body: {
        code: integer;
        message: string;
      };
    };

/**
 * Update Todo Schema
 */
@tag("todos")
@route("/todos/{id}")
@patch(#{implicitOptionality: true})
@summary("Update Todo")
op `patch-todo`(
  @path id: string,

  /**
   * Todo Iuput
   */
  @body body: {
    title: string;
    content: string;
  },
):
  | Body<{
      code: integer;
      errors: StoreTodoValidationError;
    }>
  | {
      @statusCode statusCode: 400;
      @body body: {
        code: integer;
        errors: StoreTodoValidationError;
      };
    }
  | {
      @statusCode statusCode: 401;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 404;
      @body body: {
        code: integer;
        message: string;
      };
    }
  | {
      @statusCode statusCode: 500;
      @body body: {
        code: integer;
        message: string;
      };
    };
