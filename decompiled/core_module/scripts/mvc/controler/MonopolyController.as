package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class MonopolyController extends FrameController
   {
      
      public static const DICE_MAGIC:int = 1;
      
      public static const ALERT:int = 2;
      
      public static const FRIEND_ASSIST:int = 3;
      
      public static const FINISH_REWARD:int = 4;
      
      public static const GAME_OVER:int = 5;
      
      public static const BATTLE_FAILURE:int = 6;
      
      public static const GAME_LLK:int = 7;
      
      public static const GAME_GEMMAZE:int = 8;
      
      public var curOpenFinishRewardFrame:Boolean;
      
      public function MonopolyController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "monopoly.MonopolyDiceMagicFrame";
            case 2:
               return "monopoly.MonopolyAlertFrame";
            case 3:
               return "monopoly.MonopolyFriendAssistFrame";
            case 4:
               curOpenFinishRewardFrame = true;
               return "monopoly.MonopolyFinishRewardFrame";
            case 5:
               return "monopoly.MonopolyGameOverFrame";
            case 6:
               return "monopoly.MonopolyBattleFailureFrame";
            case 7:
               return "monopoly.MonopolyLlkFrame";
            case 8:
               return "monopoly.MonopolyGemMazeFrame";
            default:
               return "monopoly.MonopolyDiceMagicFrame";
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_frame)
         {
            if(_data && _frame.hasOwnProperty("data"))
            {
               _frame["data"] = _data.frameData;
            }
            _frame["show"]();
         }
      }
      
      public function openFormationFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame");
         _loc1_["show"]();
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         curOpenFinishRewardFrame = false;
         super.exitFrame();
      }
   }
}

