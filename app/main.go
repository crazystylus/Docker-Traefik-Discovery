package main

// Copyright (C) 2021  Kartik Sharma

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	apiVersion, err := os.LookupEnv("APIVERSION")
	if !err {
		panic("Env Var APIVERSION not set")
	}
	fmt.Println("Starting gin server")
	gin.SetMode(gin.ReleaseMode)
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.Writer.WriteHeader(http.StatusOK)
		c.Writer.Write([]byte(fmt.Sprintf("<html>\n<h2>Hello %s, This is API v%s</h2>", c.ClientIP(), apiVersion)))
	})
	router.Run("0.0.0.0:8080")
}
