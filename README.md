# SA.CodeView
WinForms code editor with syntax highlighting

SA.CodeView is light-weight viewer and editor with syntax highlighting. It can be used as single-line text field or as fully functioned editor. It was initially developed for some application but then was segregated as standalone open-source library.

## Features
* **Line Numbers**. Just Set ShowLineNumbers = true.
* **"Find Text" window**. Invoke ShowFind() method from your code.

![ShowFind window](https://github.com/ygavrishov/SA.CodeView/blob/master/Screenshots/find-window.png)

* **Current line highlighting**. Turn on HighlightCurrentLine property.

![Current line highlighting](https://github.com/ygavrishov/SA.CodeView/blob/master/Screenshots/current-line-highlihting.png)

* **Ability to change background and border for some text fragments**. Spans can be used for this purpose. The span is part of the text with specified background and border color. Add items to Spans collection to use this feature:
```csharp
	codeViewer.Text = "Span sample";
	codeViewer.Spans.Add(Brushes.LightGreen, 0, 2, 7);
```

![Spans sample](https://github.com/ygavrishov/SA.CodeView/blob/master/Screenshots/spans-sample.png)

* **Syntax highlighting**. SA.CodeView has expandable system of different languages support. It also supports predefined support of XML and different dialects of SQL. To enable syntax highlighting select on of predefined languages: 
```csharp
	codeViewer.Language = PredefinedLanguage.MsSql;
```

![Syntax highlighting](https://github.com/ygavrishov/SA.CodeView/blob/master/Screenshots/syntax-highlighting.png)

or implement your own implementation.
