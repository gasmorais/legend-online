package child.handbook
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildCallAlertFrame extends Frame
   {
      
      private var callText:FilterFrameText;
      
      private var callHbox:HBox;
      
      private var condictionText:FilterFrameText;
      
      private var confirmBtn:SelectedCheckButton;
      
      private var cancelBtn:SelectedCheckButton;
      
      private var _data:ChildTempInfo;
      
      private var hasMaterial:Boolean = true;
      
      public function ChildCallAlertFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         callText = ComponentFactory.Instance.creatComponentByStylename("ChildCallAlertFrame.callText");
         callHbox = ComponentFactory.Instance.creatComponentByStylename("ChildCallAlertFrame.callHbox");
         condictionText = ComponentFactory.Instance.creatComponentByStylename("ChildCallAlertFrame.condictionText");
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ChildCallAlertFrame.confirmBtn");
         cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ChildCallAlertFrame.cancelBtn");
         addToContent(callText);
         addToContent(callHbox);
         addToContent(condictionText);
         addToContent(confirmBtn);
         addToContent(cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         confirmBtn.addEventListener("click",__confirmBtnHandler);
         cancelBtn.addEventListener("click",__cancelBtnBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         confirmBtn.removeEventListener("click",__confirmBtnHandler);
         cancelBtn.removeEventListener("click",__cancelBtnBtnHandler);
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         if(!hasMaterial)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildCallAlertFrame.callChild.noReachedAlert"));
            return;
         }
         if(_data && model.curGrowthGrade < _data.CallTotalGrowth)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildCallAlertFrame.callChild.noReachedAlert"));
            return;
         }
         ChildSender.callChild(_data.JobType);
         dispose();
      }
      
      private function __cancelBtnBtnHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function set data(param1:ChildTempInfo) : void
      {
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         callHbox.removeAllChild();
         _data = param1;
         if(!_data)
         {
            return;
         }
         callText.text = LanguageMgr.GetTranslation("ChildCallAlertFrame.callText.text",_data.JobName);
         condictionText.text = LanguageMgr.GetTranslation("ChildCallAlertFrame.condictionText.text",_data.CallTotalGrowth);
         if(model.curGrowthGrade >= _data.CallTotalGrowth)
         {
            condictionText.setFrame(2);
         }
         else
         {
            condictionText.setFrame(1);
         }
         var _loc3_:Array = [];
         if(_data.CallNeedItems)
         {
            _loc3_ = _data.CallNeedItems.split("|");
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc8_ = _loc3_[_loc5_];
            _loc6_ = int(_loc8_.split(",")[0]);
            _loc2_ = int(_loc8_.split(",")[1]);
            _loc9_ = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc6_));
            _loc7_ = ComponentFactory.Instance.creatCustomObject("ChildCallAlertFrame.baseItem");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc6_;
            _loc7_.data = _loc4_;
            _loc7_.setItemTextOther(_loc9_ + "/" + _loc2_);
            callHbox.addChild(_loc7_);
            if(_loc9_ < _loc2_)
            {
               hasMaterial = false;
            }
            _loc5_++;
         }
         callHbox.x = 100 - (_loc3_.length - 1) * 30;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
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
         titleText = LanguageMgr.GetTranslation("public.prompt");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(callText);
         callText = null;
         ObjectUtils.disposeObject(condictionText);
         condictionText = null;
         ObjectUtils.disposeObject(callHbox);
         callHbox = null;
         ObjectUtils.disposeObject(confirmBtn);
         confirmBtn = null;
         ObjectUtils.disposeObject(cancelBtn);
         cancelBtn = null;
         super.dispose();
      }
   }
}

