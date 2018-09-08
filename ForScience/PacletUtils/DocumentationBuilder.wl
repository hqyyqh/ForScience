(* ::Package:: *)

DocumentationBuilder;


Begin["`Private`"]


AppendTo[$DocumentationTypeData,$DocumentationSections->{}];
HoldPattern@AppendTo[$DocumentationSections[type_],sym_]^:=(
  $DocumentationSections[type]=Append[$DocumentationSections[type],sym];
  AppendTo[Options[DocumentationBuilder],Options[sym]];
)


$DocumentationBaseDirectory="Documentation/English/";


Attributes[DocumentationSummary]={HoldFirst};


Attributes[MakeDocumentationContent]={HoldFirst};


DocumentationBuilder::noDoc="Cannot generate documentation page for ``, as DocumentationHeader[`1`] is not set.";


Options[DocumentationBuilder]=Join[{ProgressIndicator->True},Options[DocumentationCachePut]];


Attributes[DocumentationBuilder]={HoldFirst};


DocumentationBuilder[opts:OptionsPattern[]]:=Module[
  {curObj,prog=0},
  With[
    {changed=Length@First[
      Last@Reap[
        If[
          OptionValue@ProgressIndicator,
          PrintTemporary["Building documentation pages..."];Apply@Monitor,
          First
        ]@Hold[
          List@@(Function[
            sym,
            curObj=DocumentationTitle[sym];
            ++prog;
            DocumentationBuilder[
              sym,
              True,
              If[$BuildActive,"CacheDirectory"->"../"<>OptionValue@"CacheDirectory",Unevaluated@Sequence[]],
              opts
            ],
            {HoldFirst}
          ]/@$DocumentedObjects),
          Row@{ProgressIndicator[prog,{0,Length@$DocumentedObjects}]," ",curObj}
        ],
        {DocumentationCacheGet,"Uncached"}
      ],
      {}
    ]>0},
    IndexDocumentation[
      $DocumentationBaseDirectory,
      !changed,
      If[$BuildActive,"CacheDirectory"->"../"<>OptionValue@"CacheDirectory",Unevaluated@Sequence[]],
      FilterRules[{opts},Options@IndexDocumentation]
    ];
  ]
]

DocumentationBuilder[sym_/;DocumentationHeader[sym]=!={},automated:(True|False):False,opts:OptionsPattern[]]:=
With[
  {
    type=DocumentationType@sym
  },
  With[
    {
      cachedFile=DocumentationCacheGet[sym,type,FilterRules[{opts},Options@DocumentationCacheGet]],
      docFile=FileNameJoin@{Directory[],$DocumentationBaseDirectory,DocumentationPath[sym,"IncludeContext"->False]<>".nb"}
    },
    If[cachedFile=!=Null,
      If[automated,
        Quiet@CreateDirectory[DirectoryName@docFile];
        CopyFile[cachedFile,docFile],
        NotebookOpen[cachedFile]
      ],
      Sow[Hold[sym,type],{DocumentationCacheGet,"Uncached"}];
      With[
        {
          title=DocumentationTitle[sym]
        },
        With[
          {
            nb=CreateNotebook[
              StyleDefinitions->Notebook[{
                Cell[StyleData[StyleDefinitions->FrontEnd`FileName[{"Wolfram"},"Reference.nb",CharacterEncoding->"UTF-8"]]],
                Cell[StyleData["Input"],CellContext->Notebook],
                Cell[StyleData["Output"],CellContext->Notebook]
              }],
              Saveable->False,
              Visible->False,
              TaggingRules->{
                "NewStyles"->True,
                "Openers"->{},
                "Metadata"->{
                  "title"->title,
                  "description"->"",
                  "label"->$BuiltPaclet<>" "<>type,
                  "context"->Context@sym,
                  "index"->True,
                  "language"->"en",
                  "paclet"->$BuiltPaclet,
                  "type"->type,
                  "windowtitle"->title,
                  "uri"->DocumentationPath[sym],
                  "summary"->DocumentationSummary[sym,type],
                  "keywords"->{}
                }
              },
              WindowTitle->title
            ]
          },
          NotebookWrite[nb,MakeHeader[sym,type]];
          With[
            {linkedSymbols=DeleteDuplicates@First[
              Last@Reap[
                MakeDocumentationContent[sym,type,nb,opts],
                Hyperlink
              ],
              {}
            ]},
            NotebookWrite[nb,MakeFooter[sym,type]];
            If[automated,
              Quiet@CreateDirectory[DirectoryName@docFile];
              Export[
                docFile,
                Replace[NotebookGet[nb],(Visible->False):>Sequence[],1],
                PageWidth->Infinity
              ];
              NotebookClose[nb];
              DocumentationCachePut[sym,type,docFile,linkedSymbols,FilterRules[{opts},Options@DocumentationCachePut]];,
              SetOptions[nb,Visible->!$BuildActive];
              nb
            ]
          ]
        ]
      ]
    ]
  ]
]
DocumentationBuilder[sym_,_:False,OptionsPattern[]]:=Message[DocumentationBuilder::noDoc,HoldForm[sym]]


End[]
