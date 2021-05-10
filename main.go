package main

import (
	"log"
	"os"
	"github.com/gofiber/fiber/v2"
)

func main() {
	app := fiber.New()

	app.Get("/", func (c *fiber.Ctx) error {
		name, err := os.Hostname()
		if err != nil {
			panic(err)
		}
		//return the hostname of ecs fargate task
		return c.JSON(fiber.Map{"hostname" :  name})
	})

	log.Fatal(app.Listen(":3000"))
}