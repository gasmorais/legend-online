package wholerebate
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.WholeRebateManager;
   import mvc.module.wholerebate.WholeRebateModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   
   public class WholeRebateFrame extends Frame
   {
      
      private var _ruleTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _getRebateIconBtn:IconButton;
      
      private var _bg:MutipleImage;
      
      private var _chargeView:ChargeView;
      
      public function WholeRebateFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _ruleTxt = ComponentFactory.Instance.creatComponentByStylename("wholerebate.WholeRebateFrame.ruleTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("wholerebate.WholeRebateFrame.timeTxt");
         _getRebateIconBtn = ComponentFactory.Instance.creatComponentByStylename("wholerebate.WholeRebateFrame.getRebateIconBtn");
         _bg = ComponentFactory.Instance.creatComponentByStylename("wholerebate.WholeRebateFrame.bg");
         _chargeView = ComponentFactory.Instance.creatCustomObject("wholerebate.WholeRebateFrame.chargeView");
         addToContent(_bg);
         addToContent(_chargeView);
         addToContent(_ruleTxt);
         addToContent(_timeTxt);
         addToContent(_getRebateIconBtn);
         _chargeView.visible = false;
         titleText = LanguageMgr.GetTranslation("wholerebate.wholerebateframe.title");
         _ruleTxt.text = LanguageMgr.GetTranslation("wholerebate.wholerebateframe.rule");
         _refreshView(null);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _getRebateIconBtn.addEventListener("click",_getRebateIconBtnClickHandler);
         NotificationManager.instance.addEventListener("WHOLE_REBATE_SHOW",_refreshView);
      }
      
      private function _refreshView(param1:Event) : void
      {
         var _loc2_:WholeRebateModel = WholeRebateManager.instance.model;
         if(!_loc2_.isOpen)
         {
            dispose();
            return;
         }
         _timeTxt.htmlText = LanguageMgr.GetTranslation("wholerebate.wholerebateframe.time",_loc2_.startTime,_loc2_.endTime);
         if(_loc2_.percent > 0)
         {
            _chargeView.visible = true;
            _chargeView.setData();
            _getRebateIconBtn.visible = false;
         }
         else
         {
            _chargeView.visible = false;
            _getRebateIconBtn.visible = true;
         }
      }
      
      private function _getRebateIconBtnClickHandler(param1:MouseEvent) : void
      {
         WholeRebateManager.instance.sendWholeRebateOperate();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("WHOLE_REBATE_SHOW",_refreshView);
         if(_getRebateIconBtn)
         {
            _getRebateIconBtn.removeEventListener("click",_getRebateIconBtnClickHandler);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_ruleTxt);
         ObjectUtils.disposeObject(_timeTxt);
         ObjectUtils.disposeObject(_getRebateIconBtn);
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_chargeView);
         _bg = null;
         _ruleTxt = null;
         _timeTxt = null;
         _chargeView = null;
         _getRebateIconBtn = null;
         super.dispose();
      }
   }
}

