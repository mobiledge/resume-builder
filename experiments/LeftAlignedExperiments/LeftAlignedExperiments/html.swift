//
//  html.swift
//  LeftAlignedExperiments
//
//  Created by Rabin Joshi on 2025-03-27.
//

enum Constant {

    static let htmlString = """
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Awesome PDF Document (HTML)</title>
<style>
    body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        font-size: 12pt;
        margin: 72pt; /* Corresponds to 1-inch margin */
        line-height: 1.4;
        color: #000;
    }
    h1 {
        font-size: 24pt;
        font-weight: bold;
        text-align: center;
        color: #333; /* Dark Gray */
        margin-bottom: 20pt;
    }
    p { margin-bottom: 10pt; }
    ul { margin-left: 20pt; margin-bottom: 10pt; }
    li { margin-bottom: 5pt; }
    .bold-blue { font-weight: bold; color: blue; }

    /* --- Styles for Flexbox Layout --- */
    .item-list {
        margin-top: 15pt;
        width: 100%;
    }
    .item-row {
        display: flex;
        justify-content: space-between;
        padding: 2pt 0;
    }
    .item-header {
        font-weight: bold;
        border-bottom: 1px solid #ccc;
        margin-bottom: 5pt;
    }
    
    /* --- Explicit text alignment within spans --- */
    .item-description {
        text-align: left; /* Explicitly align text to the left within this span */
        /* Optional: Prevent shrinking if needed, though unlikely with space-between */
        /* flex-shrink: 0; */ 
    }
    .item-price {
        text-align: right; /* Explicitly align text to the right within this span */
         /* Optional: Prevent shrinking if needed */
        /* flex-shrink: 0; */
        /* Optional: Give it a minimum width if wrapping is an issue */
        /* min-width: 60px; */ /* Adjust as needed */
    }

</style>
</head>
<body>
<h1>My Awesome PDF Document (HTML)</h1>
<p>
This is a sample document generated from a Swift command-line application
using an offscreen WKWebView to convert HTML to PDF.
</p>
<p>Features demonstrated:</p>
<ul>
    <li>Different font sizes (via CSS)</li>
    <li><span class="bold-blue">Bold text (and blue!)</span></li>
    <li>Colors (via CSS)</li>
    <li>Centered title alignment (via CSS)</li>
    <li>Right alignment using CSS Flexbox with explicit span alignment</li> </ul>

<div class="item-list">
    <div class="item-row item-header">
        <span class="item-description">Item Description</span>
        <span class="item-price">Price</span>
    </div>
    <div class="item-row">
        <span class="item-description">Standard Widget</span>
        <span class="item-price">$19.99</span>
    </div>
    <div class="item-row">
        <span class="item-description">Premium Gadget with a potentially longer name</span>
        <span class="item-price">$125.50</span>
    </div>
    <div class="item-row">
        <span class="item-description">Service Fee</span>
        <span class="item-price">$50.00</span>
    </div>
</div>
</body>
</html>

"""
}
