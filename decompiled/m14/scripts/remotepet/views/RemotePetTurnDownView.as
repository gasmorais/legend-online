package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetModel;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class RemotePetTurnDownView extends Component
   {
      
      private var _arr:Array = [1,2,3,7];
      
      private var _currText:FilterFrameText;
      
      private var _maxText:FilterFrameText;
      
      private var _toReady:IconButton;
      
      private var _enterWar:IconButton;
      
      private var _petBack:Bitmap;
      
      private var _hBox:HBox;
      
      private var _petList:Vector.<RemotePetTurnSingleItemView>;
      
      private var _lastClickTime:int = 0;
      
      public function RemotePetTurnDownView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemotePetTurnSingleItemView = null;
         _petList = new Vector.<RemotePetTurnSingleItemView>(4);
         _petBack = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetTurnDownView.petBack");
         _currText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnDownView.currText");
         _maxText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnDownView.maxText");
         _toReady = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnDownView.toReadyBtn");
         _enterWar = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnDownView.enterWarBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetTurnDownView.hBox");
         addChild(_petBack);
         addChild(_hBox);
         addChild(_currText);
         addChild(_maxText);
         addChild(_toReady);
         addChild(_enterWar);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new RemotePetTurnSingleItemView(_loc2_);
            _loc1_.data = model.petListInfo.petList[_arr[_loc2_]];
            _hBox.addChild(_loc1_);
            _petList.push(_loc1_);
            _loc2_++;
         }
         __commitHandler(null);
      }
      
      private function __toReadyHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.remotePetController.startFrameByType(1);
      }
      
      private function __enterWarHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc2_;
         if(model.turnInfo.currTurn < model.maxMopupTurn)
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",5,1);
            return;
         }
         RemotePetManager.instance.sendFight(model.turnInfo.currTurn,false);
      }
      
      private function addEvent() : void
      {
         model.addEventListener("COMMIT",__commitHandler);
         _toReady.addEventListener("click",__toReadyHandler);
         _enterWar.addEventListener("click",__enterWarHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("COMMIT",__commitHandler);
         _toReady.removeEventListener("click",__toReadyHandler);
         _enterWar.removeEventListener("click",__enterWarHandler);
      }
      
      private function __commitHandler(param1:RemotePetEvent) : void
      {
         var _loc2_:int = int(model.turnInfo.currTurn);
         if(_loc2_ >= 100)
         {
            _loc2_ = 100;
         }
         _currText.text = LanguageMgr.GetTranslation("remotepet.currText") + " " + _loc2_;
         _maxText.text = LanguageMgr.GetTranslation("remotepet.maxText") + " " + model.turnInfo.maxTurn;
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_petBack);
         _petBack = null;
         ObjectUtils.disposeObject(_currText);
         _currText = null;
         ObjectUtils.disposeObject(_maxText);
         _maxText = null;
         ObjectUtils.disposeObject(_toReady);
         _toReady = null;
         ObjectUtils.disposeObject(_enterWar);
         _enterWar = null;
         if(_hBox)
         {
            _hBox.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         _petList = null;
         super.dispose();
      }
   }
}

