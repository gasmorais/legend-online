package mvc.module.goldroad
{
   import flash.events.EventDispatcher;
   
   public class GoldRoadModel extends EventDispatcher
   {
      
      public static const scaleMax:Number = 1;
      
      public static const scaleMin:Number = 0.7;
      
      public static const dicePrice:int = 10;
      
      public static const questionTempId:int = -1;
      
      public static const COLUMN_NUM:int = 8;
      
      public static const ROW_NUM:int = 7;
      
      public var stepKey:int;
      
      public var score:int;
      
      private var _randomNum:int = 1;
      
      private var _mutiCount:int = 1;
      
      public var dropTempStr:String;
      
      public var vertexArray:Array = [0,9,18,27];
      
      public var rareCellArray:Array = [8,17,26,35];
      
      public var xyArray:Array = [[208,90],[268,92],[324,93],[380,95],[435,93],[495,95],[557,94],[615,93],[665,94],[722,92],[732,117],[740,143],[752,168],[768,194],[780,226],[800,260],[815,305],[832,342],[852,390],[768,390],[688,390],[602,390],[508,390],[418,390],[333,390],[248,390],[165,390],[75,390],[95,342],[112,302],[132,262],[148,228],[160,195],[175,172],[186,142],[200,119]];
      
      private var _GoldRoadGoodList:Vector.<GoldRoadGoodsInfo> = new Vector.<GoldRoadGoodsInfo>();
      
      public var goldRoadRefuseInvitation:Boolean;
      
      public var goldRoadRefuseInvite:Boolean;
      
      public var goldRoadRefuseTeamInvite:Boolean;
      
      public var hasOpenFrame:Boolean = false;
      
      public function GoldRoadModel()
      {
         super();
      }
      
      public function get GoldRoadGoodList() : Vector.<GoldRoadGoodsInfo>
      {
         return _GoldRoadGoodList;
      }
      
      public function set GoldRoadGoodList(param1:Vector.<GoldRoadGoodsInfo>) : void
      {
         _GoldRoadGoodList = param1;
      }
      
      public function get randomNum() : int
      {
         return _randomNum;
      }
      
      public function set randomNum(param1:int) : void
      {
         _randomNum = param1;
      }
      
      public function get mutiCount() : int
      {
         return _mutiCount;
      }
      
      public function set mutiCount(param1:int) : void
      {
         _mutiCount = param1;
      }
      
      public function getXYbyStepKey(param1:int) : Array
      {
         return xyArray[param1];
      }
      
      public function getScale(param1:Number) : Number
      {
         return 0.7 + (param1 - 90) / 1000;
      }
      
      public function getRotationByFace(param1:int) : int
      {
         if(int(param1 / 9) == 1)
         {
            return -6;
         }
         if(int(param1 / 9) == 3)
         {
            return 6;
         }
         return 0;
      }
      
      public function getFrameByFace(param1:int) : int
      {
         if(int(param1 / 9) == 1)
         {
            return 13;
         }
         if(int(param1 / 9) == 3)
         {
            return 8;
         }
         return 3;
      }
   }
}

