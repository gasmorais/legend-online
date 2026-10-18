package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.petchallenge.PetChallengeModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PetChallengeController extends FrameController
   {
      
      public static const PetReport:int = 1;
      
      public static const PetChallengeFrame:int = 2;
      
      public static const PetFormationFrame:int = 3;
      
      public var classDefineDic:Dictionary = new Dictionary(true);
      
      public var armyPawnDefineDic:Dictionary = new Dictionary(true);
      
      public var childDefineDic:Dictionary = new Dictionary(true);
      
      public var shapePool:Dictionary = new Dictionary(true);
      
      public var model:PetChallengeModel = new PetChallengeModel();
      
      public function PetChallengeController()
      {
         super();
      }
      
      public function openFormationFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetFormationFrame");
         _loc1_["show"]();
      }
      
      public function openChallengeEventFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("petchallenge.PetChallengeEventFrame");
         _loc1_["show"]();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:Object = _data.openType;
         if(1 !== _loc1_)
         {
            return "petchallenge.PetChallengeFrame";
         }
         return "petchallenge.PetChallengeReportFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = null;
         if(!param1 || param1.openType == 2)
         {
            if(ArmyManager.instance.thane.grades < 50)
            {
               _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",50);
            }
            else if(!playerInfo.petList || playerInfo.petList.length <= 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("PetChallengeController.nopet");
            }
            if(_loc2_)
            {
               MessageTipManager.instance().show(_loc2_);
               return;
            }
         }
         super.start(param1);
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
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType == 2)
         {
            _frame.dispose();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

