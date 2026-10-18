package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class TodayNotAlertFrame extends Frame
   {
      
      public static const P_info:String = "info";
      
      private var _confirmBtn:BaseButton;
      
      private var _cancelBtn:BaseButton;
      
      private var _checkBtm:SelectedCheckButton;
      
      public var _describeTxt:FilterFrameText;
      
      private var _back:Function;
      
      private var _closeFunction:Function;
      
      private var _cancelFun:Function;
      
      private var _usebindPoint:SelectedCheckButton;
      
      private var _notJoinActPromptTxt:FilterFrameText;
      
      private var _noWearyPromptTxtBtn:TextButton;
      
      protected var P_confirmStyle:String = "P_confirmStyle";
      
      protected var P_cancelStyle:String = "P_cancelStyle";
      
      protected var P_checkStyle:String = "P_checkStyle";
      
      protected var P_describeStyle:String = "P_describeStyle";
      
      protected var P_usebindPointStyle:String = "P_usebindPointStyle";
      
      protected var P_notJoinActPromptStyle:String = "P_notJoinActPromptStyle";
      
      private var _confirmStyle:String;
      
      private var _point:int;
      
      private var _cancelStyle:String;
      
      private var _checkStyle:String;
      
      private var _describeStyle:String;
      
      private var _usebindPointStyle:String;
      
      private var _notJoinActPromptStyle:String;
      
      private var _noWearyCallBack:Function;
      
      public function TodayNotAlertFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("public.prompt");
         addEventListener("addedToStage",__addedToStage);
      }
      
      public function set confirmStyle(param1:String) : void
      {
         _confirmStyle = param1;
         onPropertiesChanged(P_confirmStyle);
      }
      
      public function set cancelStyle(param1:String) : void
      {
         _cancelStyle = param1;
         onPropertiesChanged(P_cancelStyle);
      }
      
      public function set checkStyle(param1:String) : void
      {
         _checkStyle = param1;
         onPropertiesChanged(P_checkStyle);
      }
      
      public function set describeStyle(param1:String) : void
      {
         _describeStyle = param1;
         onPropertiesChanged(P_describeStyle);
      }
      
      public function set usebindPointStyle(param1:String) : void
      {
         _usebindPointStyle = param1;
         onPropertiesChanged(P_usebindPointStyle);
      }
      
      public function set notJoinActPromptStyle(param1:String) : void
      {
         if(_notJoinActPromptStyle == param1)
         {
            return;
         }
         _notJoinActPromptStyle = param1;
         onPropertiesChanged(P_notJoinActPromptStyle);
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["info"])
         {
            _changedPropeties["width"] = true;
            _changedPropeties["height"] = true;
         }
         super.onProppertiesUpdate();
         if(_changedPropeties[P_confirmStyle])
         {
            _confirmBtn = ComponentFactory.Instance.creatComponentByStylename(_confirmStyle);
         }
         if(_changedPropeties[P_cancelStyle])
         {
            _cancelBtn = ComponentFactory.Instance.creatComponentByStylename(_cancelStyle);
         }
         if(_changedPropeties[P_checkStyle])
         {
            if(_checkStyle == "")
            {
               ObjectUtils.disposeObject(_checkBtm);
               _checkBtm = null;
            }
            else
            {
               _checkBtm = ComponentFactory.Instance.creatComponentByStylename(_checkStyle);
            }
         }
         if(_changedPropeties[P_describeStyle])
         {
            _describeTxt = ComponentFactory.Instance.creatComponentByStylename(_describeStyle);
         }
         if(_changedPropeties[P_usebindPointStyle])
         {
            ObjectUtils.disposeObject(_usebindPoint);
            _usebindPoint = null;
            if(_usebindPointStyle != "")
            {
               _usebindPoint = ComponentFactory.Instance.creatComponentByStylename(_usebindPointStyle);
               _usebindPoint.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
               if(_notJoinActPromptTxt)
               {
                  _notJoinActPromptTxt.visible = true;
               }
            }
            else if(_notJoinActPromptTxt)
            {
               _notJoinActPromptTxt.visible = false;
            }
         }
         if(_changedPropeties[P_notJoinActPromptStyle])
         {
            _notJoinActPromptTxt = ComponentFactory.Instance.creatComponentByStylename(_notJoinActPromptStyle);
            _notJoinActPromptTxt.text = LanguageMgr.GetTranslation("yishi.view.frame.TodayNotAlertFrame.notJoinActPromptTxt");
         }
      }
      
      public function set usebindPointTxt(param1:String) : void
      {
         if(_usebindPoint)
         {
            _usebindPoint.text = param1;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_confirmBtn)
         {
            addToContent(_confirmBtn);
         }
         if(_cancelBtn)
         {
            addToContent(_cancelBtn);
         }
         if(_checkBtm)
         {
            addToContent(_checkBtm);
         }
         if(_describeTxt)
         {
            addToContent(_describeTxt);
         }
         if(_usebindPoint)
         {
            addToContent(_usebindPoint);
         }
         if(_notJoinActPromptTxt)
         {
            addToContent(_notJoinActPromptTxt);
         }
      }
      
      public function setSelestX(param1:int) : void
      {
         _checkBtm.fieldX = param1;
      }
      
      public function showNoWeary(param1:Function) : void
      {
         _noWearyCallBack = param1;
         _noWearyPromptTxtBtn = ComponentFactory.Instance.creatComponentByStylename("core.CampaignNoWearyFrameTextBtn");
         addToContent(_noWearyPromptTxtBtn);
         _noWearyPromptTxtBtn.text = LanguageMgr.GetTranslation("yishi.view.frame.TodayNotAlertFrame.noWearyPromptTxtBtn");
         _noWearyPromptTxtBtn.addEventListener("click",onTxtBtnClick);
      }
      
      private function onTxtBtnClick(param1:MouseEvent) : void
      {
         _noWearyCallBack();
      }
      
      private function __addedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__addedToStage);
         addEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmkHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",__cancelHandler);
         }
         if(_checkBtm)
         {
            _checkBtm.addEventListener("click",__checkHandler);
         }
         if(_usebindPoint)
         {
            _usebindPoint.selected = true;
            _usebindPoint.addEventListener("click",__useBindPointHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmkHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         if(_checkBtm)
         {
            _checkBtm.removeEventListener("click",__checkHandler);
         }
         if(_usebindPoint)
         {
            _usebindPoint.removeEventListener("click",__useBindPointHandler);
         }
         if(_noWearyPromptTxtBtn != null)
         {
            _noWearyPromptTxtBtn.removeEventListener("click",onTxtBtnClick);
         }
      }
      
      private function __checkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function __confirmkHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         if(_back != null)
         {
            if(_usebindPoint)
            {
               _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
               if(_usebindPoint.selected)
               {
                  _loc2_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
               }
               if(_point > _loc2_)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               _back(_checkBtm && _checkBtm.selected,_usebindPoint.selected);
            }
            else
            {
               _back(_checkBtm && _checkBtm.selected);
            }
         }
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_cancelFun != null)
         {
            _cancelFun(_checkBtm && _checkBtm.selected);
         }
         dispose();
      }
      
      private function __useBindPointHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function layoutContent() : void
      {
         var _loc1_:int = _describeTxt.y;
         _describeTxt.height = _describeTxt.textHeight + 10;
         _loc1_ += _describeTxt.height;
         if(_checkBtm)
         {
            _checkBtm.y = _loc1_ + 8;
         }
         if(_usebindPoint)
         {
            _usebindPoint.y = _loc1_ + 8;
         }
         if(_notJoinActPromptTxt)
         {
            _notJoinActPromptTxt.y = _loc1_ + 42;
         }
         _confirmBtn.y = _loc1_ + 61;
         _cancelBtn.y = _loc1_ + 61;
         _height = _describeTxt.height + 170;
      }
      
      public function show(param1:String, param2:String, param3:Function = null, param4:Function = null, param5:String = "left", param6:int = 1, param7:Boolean = false, param8:int = 0, param9:Boolean = false, param10:int = 2, param11:Function = null) : void
      {
         _back = param3;
         _closeFunction = param4;
         _cancelFun = param11;
         if(!param7)
         {
            _describeTxt.text = param1;
         }
         else
         {
            _describeTxt.htmlText = param1;
         }
         var _loc12_:TextFormat = _describeTxt.getTextFormat();
         _loc12_.align = param5;
         _describeTxt.setTextFormat(_loc12_);
         if(_checkBtm)
         {
            _checkBtm.text = param2;
         }
         if(_usebindPoint && _checkBtm)
         {
            _checkBtm.x = _usebindPoint.x + _usebindPoint.width + 15;
            _checkBtm.y = _usebindPoint.y;
         }
         _point = param8;
         if(param9)
         {
            layoutContent();
            onPropertiesChanged("info");
         }
         LayerManager.Instance.addToLayer(this,param10,true,true,param6);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmkHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         if(_closeFunction != null)
         {
            _closeFunction();
            _closeFunction = null;
         }
         _noWearyCallBack = null;
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _back = null;
         _cancelFun = null;
         ObjectUtils.disposeObject(_noWearyPromptTxtBtn);
         _noWearyPromptTxtBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
      
      public function get usebindPoint() : SelectedCheckButton
      {
         return _usebindPoint;
      }
      
      public function set usebindPoint(param1:SelectedCheckButton) : void
      {
         _usebindPoint = param1;
      }
      
      public function get checkBtm() : SelectedCheckButton
      {
         return _checkBtm;
      }
      
      public function set checkBtm(param1:SelectedCheckButton) : void
      {
         _checkBtm = param1;
      }
      
      public function get cancelBtn() : BaseButton
      {
         return _cancelBtn;
      }
   }
}

