(* ::Package:: *)

Usage[Usage]="[*Usage[```sym```]'''=```usage```'''*] sets the usage message of ```sym``` to [*FormatUsage[sym]*]. If set, a usage section is generated by [*DocumentBuilder*].";


DocumentationHeader[Usage]={
  "FOR-SCIENCE SYMBOL",
  $ForScienceColor,
  "Introduced in 0.56.0"
};


Details[Usage]={
  "[*Usage[sym]*]'''=```usage```''' effectively assigns [*FormatUsage[usage]*] as usage message to ```sym```.",
  "The format specifcations supported are the same as those for [*FormatUsage*].",
  "[*Usage*] is one of the metadata symbols used by [*DocumentationBuilder*]. Others include [*Details*], [*Examples*] and [*SeeAlso*].",
  "Assigning a value to [*Usage[sym]*] causes usage examples to be generated by [*DocumentationBuilder[sym]*].",
  "In [*Usage[sym]*]'''=```usage```''', the definition is attached to ```sym``` as an upvalue."
};


Examples[Usage,"Basic examples"]={
  {
    "Load the ForScience package:",
    ExampleInput[Needs["ForScience`PacletUtils`"]],
    "Assign a formatted usage message to a symbol:",
    ExampleInput[Usage[foo]="foo[a,b] does something cool."],
    "Display the help for the symbol:",
    ExampleInput["?foo"],
    "Create a documentation page for the symbol:",
    ExampleInput[
      DocumentationHeader[foo]={"TEST",Black,""},
      nb=DocumentationBuilder[foo]
    ],
    "Close the notebook again:",
    ExampleInput[NotebookClose[nb]]
  }
};


Examples[Usage,"Properties & Relations"]={
  {
    "For assigning usage messages, [*Usage[sym]*]'''=```usage```''' is equivalent to [*sym::usage=[*FormatUsage[usage]*]*]:",
    ExampleInput[
      bar::usage=FormatUsage["bar[a,b] is great!"],
      Usage[foobar]="foobar[c,d] is even better!",
      "?bar",
      "?foobar"
    ],
    "Generated documentation pages get a usage section only when [*Usage[sym]*] is assigned:",
    ExampleInput[
      DocumentationHeader[bar]={"TEST",Black,""},
      DocumentationHeader[foobar]={"TEST",Black,""},
      nb=DocumentationBuilder[bar],
      nb2=DocumentationBuilder[foobar]
    ],
    "Close the notebook again:",
    ExampleInput[
      NotebookClose[nb],
      NotebookClose[nb2]
    ]
  }
};


SeeAlso[Usage]={FormatUsage,ParseFormatting,DocumentationBuilder,Details,Examples,SeeAlso};
