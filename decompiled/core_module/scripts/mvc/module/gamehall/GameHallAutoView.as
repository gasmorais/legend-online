package mvc.module.gamehall
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GameHallEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class GameHallAutoView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _cancelBtn:IconButton;
      
      private var _desTxt:FilterFrameText;
      
      private var _autoType:int;
      
      private var _model:GameHallModel;
      
      public function GameHallAutoView()
      {
         super();
         _model = GameHallManager.instance.model;
         initView();
         initEvent();
         updateAutoHandler();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.core.gameHall.cancelBack");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.renfroce.CancelBtn");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.renfroce.autoCancelDesTxt");
         addChild(_back);
         addChild(_desTxt);
         addChild(_cancelBtn);
      }
      
      private function initEvent() : void
      {
         _cancelBtn.addEventListener("click",cancelHandler);
         _model.addEventListener("UPDATE_AUTO_BATTLE",updateAutoHandler);
      }
      
      private function removeEvent() : void
      {
         _cancelBtn.removeEventListener("click",cancelHandler);
         _model.removeEventListener("UPDATE_AUTO_BATTLE",updateAutoHandler);
      }
      
      private function updateAutoHandler(param1:GameHallEvent = null) : void
      {
         var _loc2_:String = null;
         if(_model.selfTeam && _model.gameId == 4)
         {
            this.visible = _model.selfTeam.autoType != 0;
            _autoType = _model.selfTeam.autoType;
            _loc2_ = LanguageMgr.GetTranslation("gameHall.east.auto" + _autoType);
            _desTxt.text = LanguageMgr.GetTranslation("gameHall.east.fighting",_loc2_);
         }
         else
         {
            this.visible = false;
            _autoType = 0;
            _desTxt.text = "";
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            if(parent && parent.hasOwnProperty("showMMask"))
            {
               parent["showMMask"].call();
            }
         }
         else if(parent && parent.hasOwnProperty("hideMMask"))
         {
            parent["hideMMask"].call();
         }
      }
      
      private function cancelHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [cancelCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = "";
         var _loc5_:String = LanguageMgr.GetTranslation("gameHall.east.auto" + _autoType);
         if(_model.isCaptain)
         {
            _loc6_ = LanguageMgr.GetTranslation("gameHall.east.auto.captainStop",_loc5_);
         }
         else
         {
            _loc6_ = LanguageMgr.GetTranslation("gameHall.east.auto.otherStop",_loc5_);
         }
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_,true,false,false);
      }
      
      private function cancelCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_model.isCaptain)
            {
               GameHallManager.instance.teamCancelAutoBattle(_model.selfTeam.teamId);
            }
            else
            {
               GameHallManager.instance.teamLeave();
            }
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         super.dispose();
         _model = null;
      }
   }
}

