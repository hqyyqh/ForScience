(* ::Package:: *)

Begin["`Private`"]


AppendTo[$DependencyCollectors[_],$Pre111CompatStyles&]


If[!MatchQ[$Pre111CompatStyles,True|False],
  $Pre111CompatStyles=False;
]


VersionAwareTemplateBox[style_,pre111df_,post111df_,o:OptionsPattern[]]:=
  VersionAwareTemplateBox[StyleData[style],pre111df,post111df,o]
VersionAwareTemplateBox[style_StyleData,pre111df_,post111df_,o:OptionsPattern[]]:=
  Cell[style,
    TemplateBoxOptions->{
      DisplayFunction->Pre111StyleSwitch[pre111df,post111df]
    },
    o
  ]


CreateStyleDefinitions[type_]:=
  Notebook[
    {
      Cell[StyleData[StyleDefinitions->FrontEnd`FileName[{"Wolfram"},"Reference.nb",CharacterEncoding->"UTF-8"]]],
      Sequence@@(
        $DocumentationStyles[type]/.{
          Pre111StyleSwitch[old_,new_]/;$Pre111CompatStyles:>
            FEPrivate`If[
              FEPrivate`Less[FEPrivate`$VersionNumber,11.1],
              old,
              new
            ],
          Pre111StyleSwitch[]/;$Pre111CompatStyles:>
            FEPrivate`Less[FEPrivate`$VersionNumber,11.1],
          Pre111StyleSwitch[_,new_]:>new,
          Pre111StyleSwitch[]->False
        }
      )
    }
  ]


AppendTo[$DocumentationTypeData,$DocumentationStyles->{
  Cell[StyleData["Spacer1"],
    TemplateBoxOptions->{
      DisplayFunction->(
        StyleBox[
          GraphicsBox[
            {},
            ImageSize->{#,0},
            BaselinePosition->(Scaled[0]->Baseline)
          ],
          CacheGraphics->False
        ]&
      ),
      InterpretationFunction->(
        InterpretationBox[
          "", 
          Spacer[#]
        ]&
      ),
      Tooltip->None
    }
  ],
  Cell[StyleData["Spacer2"],
    TemplateBoxOptions->{
      DisplayFunction->(
        StyleBox[
          GraphicsBox[
            {},
            ImageSize->{#,#2},
            BaselinePosition->(Scaled[0]->Baseline)
          ],
          CacheGraphics->False
        ]&
      ),
      InterpretationFunction->(
        InterpretationBox[
          "", 
          Spacer[{#,#2}]
        ]&
      ),
      Tooltip->None
    }
  ],
  Cell[StyleData["RefLinkPlain",StyleDefinitions->StyleData["RefLink"]]]
}];


End[]