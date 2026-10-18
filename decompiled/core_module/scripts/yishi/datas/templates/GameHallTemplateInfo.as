package yishi.datas.templates
{
   public class GameHallTemplateInfo
   {
      
      public var GameId:int;
      
      public var GameName:String;
      
      public var Group:int;
      
      public var GroupName:String;
      
      public var StartDate:String;
      
      public var StopDate:String;
      
      public var OpenGrade:int;
      
      public var OpenDays:String;
      
      public var ResetDays:String;
      
      public var Count:int;
      
      public var Tag:int;
      
      public var ShowItems:String;
      
      public var Recommend:String;
      
      public function GameHallTemplateInfo()
      {
         super();
      }
      
      public function get isNewGame() : Boolean
      {
         var _loc1_:Boolean = false;
         if(Tag == 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get hasDiffSelect() : Boolean
      {
         var _loc1_:Boolean = false;
         if(difficultyMax > 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get difficultyMax() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         if(ShowItems)
         {
            _loc2_ = ShowItems.split("|");
            _loc1_ = int(_loc2_.length);
         }
         return _loc1_;
      }
   }
}

