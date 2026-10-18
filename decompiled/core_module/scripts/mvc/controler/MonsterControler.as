package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import mvc.FrameController;
   
   public class MonsterControler extends FrameController
   {
      
      public static const LOOK_UP_MONSTER:String = "LOOK_UP_MONSTER";
      
      public var monsterDefineDic:Dictionary;
      
      public var shapePool:Dictionary;
      
      public function MonsterControler()
      {
         super();
         monsterDefineDic = new Dictionary(true);
         shapePool = new Dictionary(true);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == "LOOK_UP_MONSTER")
         {
            return "playerInfo.monsterPropSeeView";
         }
         return "monster.MonsterFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData != null)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function closeChallengeFrame() : void
      {
         for(var _loc1_:String in shapePool)
         {
            shapePool[_loc1_] = null;
            delete shapePool[_loc1_];
         }
      }
      
      public function getShape(param1:int) : Shape
      {
         var _loc3_:Shape = null;
         var _loc2_:Array = shapePool[param1] as Array;
         if(!_loc2_)
         {
            _loc2_ = [];
            shapePool[param1] = _loc2_;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_.pop();
         }
         return _loc3_;
      }
      
      public function saveShape(param1:int, param2:Shape) : void
      {
         if(!param2)
         {
            return;
         }
         if(param2.parent)
         {
            param2.parent.removeChild(param2);
         }
         var _loc3_:Array = shapePool[param1] as Array;
         if(!_loc3_)
         {
            _loc3_ = [];
            shapePool[param1] = _loc3_;
         }
         if(_loc3_.indexOf(param2) < 0)
         {
            _loc3_.push(param2);
         }
      }
   }
}

