# Validator

This directory acts as a demostration of [go-playground/validator](https://github.com/go-playground/validator).

## Output

```bash
go run main.go 
# for _, err := range err.(validator.ValidationErrors):
# invalid value: Age = %!s(uint8=135)
# Age should be lte 130
# invalid value: FavouriteColor = #000-
# FavouriteColor should be iscolor 
# invalid value: City = 
# City should be required 
# Key: '' Error:Field validation for '' failed on the 'email' tag
```