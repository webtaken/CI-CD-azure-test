package main

import (
	"fmt"
	"os"

	"github.com/gofiber/fiber/v2"
)

func config(key string, def string) string {
	val, ok := os.LookupEnv(key)
	if !ok {
		return def
	}
	return val
}

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		salutation := fmt.Sprintf("Hello, %s", config("USERNAME_APP", "Golang"))
		return c.SendString(salutation)
	})

	app.Listen(fmt.Sprintf(":%s", config("PORT", "3000")))
}
