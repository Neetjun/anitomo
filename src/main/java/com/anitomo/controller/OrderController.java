package com.anitomo.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order")
public class OrderController
{
    @GetMapping
    public String showOrderForm()
    {
        return "orderForm";
    }

    @GetMapping("result")
    public String showOrderResult()
    {
        return "orderResultForm";
    }
}
