package validation

import (
	"fmt"
	"strings"

	"github.com/go-playground/validator/v10"
)

// FormatValidationErrors converts validator.ValidationErrors into a
// human-readable error map keyed by the JSON field name.
func FormatValidationErrors(err error) map[string]string {
	errs, ok := err.(validator.ValidationErrors)
	if !ok {
		return map[string]string{"error": err.Error()}
	}

	out := make(map[string]string, len(errs))
	for _, fe := range errs {
		field := jsonFieldName(fe)
		out[field] = messageForTag(fe)
	}
	return out
}

func jsonFieldName(fe validator.FieldError) string {
	// fe.Field() returns the struct field name; convert to snake_case-ish
	// by lowering the first letter. For most cases the JSON tag matches.
	name := fe.Field()
	if name == "" {
		return fe.StructField()
	}
	return strings.ToLower(name[:1]) + name[1:]
}

func messageForTag(fe validator.FieldError) string {
	field := jsonFieldName(fe)

	switch fe.Tag() {
	case "required":
		return fmt.Sprintf("%s is required", field)
	case "email":
		return "must be a valid email address"
	case "eqfield":
		return fmt.Sprintf("must match %s", strings.ToLower(fe.Param()))
	case "oneof":
		return fmt.Sprintf("must be one of: %s", fe.Param())
	case "min":
		return fmt.Sprintf("must be at least %s characters", fe.Param())
	case "max":
		return fmt.Sprintf("must be at most %s characters", fe.Param())
	case "len":
		return fmt.Sprintf("must be exactly %s characters", fe.Param())
	default:
		return fmt.Sprintf("failed validation: %s", fe.Tag())
	}
}
