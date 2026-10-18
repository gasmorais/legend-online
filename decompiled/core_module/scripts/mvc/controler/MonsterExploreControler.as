package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import flash.utils.Dictionary;
   import mvc.FrameController;
   
   public class MonsterExploreControler extends FrameController
   {
      
      public static const MAIN_FRAME:String = "MAIN_FRAME";
      
      public static const SELECT_PASS_FRAME:String = "SELECT_PASS_FRAME";
      
      public static const FORMATION_FRAME:String = "FORMATION_FRAME";
      
      public static const FAST_FIGHT_FRAME:String = "FAST_FIGHT_FRAME";
      
      public static const WIN_REWARD_FRAME:String = "WIN_REWARD_FRAME";
      
      public var mapDefineDic:Dictionary;
      
      public function MonsterExploreControler()
      {
         super();
         mapDefineDic = new Dictionary();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "MonsterExplore.MonsterExploreFrame";
         if(_data && _data.openType == "MAIN_FRAME")
         {
            _loc1_ = "MonsterExplore.MonsterExploreFrame";
         }
         else if(_data && _data.openType == "SELECT_PASS_FRAME")
         {
            _loc1_ = "MonsterExplore.MonsterExploreSelectPassFrame";
         }
         else if(_data && _data.openType == "FORMATION_FRAME")
         {
            _loc1_ = "MonsterExplore.MonsterExploreFormationFrame";
         }
         else if(_data && _data.openType == "FAST_FIGHT_FRAME")
         {
            _loc1_ = "MonsterExplore.MonsterExploreFastFightFrame";
         }
         else if(_data && _data.openType == "WIN_REWARD_FRAME")
         {
            _loc1_ = "MonsterExplore.MonsterExploreWinRewardFrame";
         }
         return _loc1_;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

