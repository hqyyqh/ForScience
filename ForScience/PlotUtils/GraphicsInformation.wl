(* ::Package:: *)

(* Adapted from Carl Woll's answer here: https://mathematica.stackexchange.com/a/138907/36508 *)

GraphicsInformation;


Begin["`Private`"]


ToNotebook[gr_]:=
  Notebook[
    {
      Cell[BoxData@ToBoxes@InstrumentGraphics[ExtractGraphics/@gr],"Output",ImageSizeMultipliers->{1,1}]
    },
    WindowSize->CurrentValue[EvaluationNotebook[],WindowSize]
  ]


SowRange[k_,dir_]:=(Sow[dir->{##},k];None)&


InstrumentGraphics[gr:{__Graphics}]:=
  MapIndexed[
    Show[
      #1,
      GridLines->{SowRange[#2,"x"],SowRange[#2,"y"]},
      Epilog->{
        Annotation[Rectangle[Scaled@{0,0},Scaled@{1,1}],#2,"pr"],
        Annotation[Rectangle[ImageScaled@{0,0},ImageScaled@{1,1}],#2,"is"]
      }
    ]&,
    gr
  ] 


GraphicsObj=_Graphics|_Legended;


$NullMarker;


GraphicsInformation[gr:{GraphicsObj..}]:=
  Query[Transpose][
    <|
      ImagePadding->Abs[#is-#pr],
      ImageSize->Abs[Subtract@@@#is],
      "PlotRangeSize"->Abs[Subtract@@@#pr],
      PlotRange->{#x,#y}
    |>&/@
      Values@KeySort@<|
        Last@Reap[
          Sow[#[[2]]->#2,#[[1]]]&@@@Cases[
            "Regions"/.FrontEndExecute@ExportPacket[ToNotebook[gr],"BoundingBox",Verbose->True],
            {{_,"is"|"pr"},_}
          ],
          _,
          #-><|#2|>&
        ]
     |>
  ]
GraphicsInformation[gr:GraphicsObj|Null]:=
  First/@GraphicsInformation[{gr}]
GraphicsInformation[gr_List]:=
  With[
    {
      flat=DeleteCases[Null]@Flatten@gr,
      struct=gr/.{Null->$NullMarker[],List->List,Except[_List]->0}
    },
    (
      ApplyStructure[#,struct,List|$NullMarker]/.
        $NullMarker[]->Null
    )&/@
      GraphicsInformation[flat]/;
        MatchQ[flat,{GraphicsObj..}]
  ]


End[]
