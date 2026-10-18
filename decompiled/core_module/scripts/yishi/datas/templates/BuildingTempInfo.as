package yishi.datas.templates
{
   import flash.display.DisplayObject;
   import yishi.manager.TempleteManager;
   
   public class BuildingTempInfo
   {
      
      public var ID:int;
      
      public var SonType:int;
      
      public var TemplateId:int;
      
      public var Camp:int;
      
      public var BuildingName:String = "";
      
      public var MasterType:int;
      
      public var BuildingGrade:int;
      
      public var NextGradeTemplateId:int;
      
      public var PreTemplateId:String;
      
      public var NextTemplateId:String;
      
      public var PlayerGrades:int;
      
      public var Reputation:int;
      
      public var LumberConsume:int;
      
      public var StoneConsume:int;
      
      public var CrystalsConsume:int;
      
      public var GoldConsume:int;
      
      public var PopuliationConsume:int;
      
      public var UpgradeTime:int;
      
      public var Property1:int;
      
      public var Property2:int;
      
      public var Property3:int;
      
      public var Property4:int;
      
      public var Property5:int;
      
      public var Property6:int;
      
      public var Description:String;
      
      public var Activity:String = "";
      
      public var Icon:String;
      
      public var Depth:int;
      
      public var PosX:int;
      
      public var PosY:int;
      
      public var TitleX:int;
      
      public var TitleY:int;
      
      public var PicPath:String;
      
      public var view:DisplayObject;
      
      public var effect:DisplayObject;
      
      public function BuildingTempInfo()
      {
         super();
      }
      
      public function get nextTemp() : BuildingTempInfo
      {
         return TempleteManager.instance.buildTemplateCate.getTemplateByID(NextGradeTemplateId);
      }
   }
}

