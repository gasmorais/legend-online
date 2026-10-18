package child.nursingspirit
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildAssistUpgradeTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.StarGroupView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSCallFrame extends Frame
   {
      
      private var _bg:Image;
      
      private var _contentBg:Image;
      
      private var _decsTxt:FilterFrameText;
      
      private var _callDescTxt:FilterFrameText;
      
      private var _supplementDescTxt:FilterFrameText;
      
      private var _propertyTxt1:FilterFrameText;
      
      private var _propertyTxt2:FilterFrameText;
      
      private var _propertyValueTxt1:FilterFrameText;
      
      private var _propertyValueTxt2:FilterFrameText;
      
      private var _starView:StarGroupView;
      
      private var _icon:Image;
      
      private var _arrowsImage:Image;
      
      private var _propValueTxt:FilterFrameText;
      
      private var _enterCallBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _propGoodsTemplateInfo:GoodsTemplateInfo;
      
      private var _hasPropCount:int;
      
      private var _data:ChildData;
      
      private var _currentTemp:ChildAssistUpgradeTempInfo;
      
      private var _nextTemp:ChildAssistUpgradeTempInfo;
      
      private var _needAdvanceLevel:int;
      
      public function ChildNSCallFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.bg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.contentBg");
         _decsTxt = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.decsTxt");
         _callDescTxt = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.callDescTxt");
         _supplementDescTxt = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.supplementDescTxt");
         _propertyTxt1 = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.propertyTxt1");
         _propertyTxt2 = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.propertyTxt2");
         _propertyValueTxt1 = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.propertyValueTxt1");
         _propertyValueTxt2 = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.propertyValueTxt2");
         _icon = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.icon");
         _arrowsImage = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.arrowsImage");
         _propValueTxt = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.propValueTxt");
         _enterCallBtn = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.enterCallBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("childNSCallFrame.upgradeBtn");
         _starView = new StarGroupView();
         _starView.initParams("asset.common.grayStar2",28,"asset.common.lightStar2",28,10);
         _starView.x = 45;
         _starView.y = 60;
         addToContent(_bg);
         addToContent(_contentBg);
         addToContent(_decsTxt);
         addToContent(_callDescTxt);
         addToContent(_supplementDescTxt);
         addToContent(_propertyTxt1);
         addToContent(_propertyTxt2);
         addToContent(_propertyValueTxt1);
         addToContent(_propertyValueTxt2);
         addToContent(_icon);
         addToContent(_arrowsImage);
         addToContent(_propValueTxt);
         addToContent(_enterCallBtn);
         addToContent(_upgradeBtn);
         addToContent(_starView);
         _propGoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208525);
         if(_propGoodsTemplateInfo)
         {
            _icon.tipData = _propGoodsTemplateInfo.TemplateName + ":" + _propGoodsTemplateInfo.Description;
         }
         _decsTxt.text = LanguageMgr.GetTranslation("ChildNSCallFrame.decsTxt.text");
         _propertyTxt1.text = _propertyTxt2.text = LanguageMgr.GetTranslation("ChildNSCallFrame.propertyValueTxt.text");
         _supplementDescTxt.text = LanguageMgr.GetTranslation("ChildNSCallFrame.supplementDescTxt.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_enterCallBtn)
         {
            _enterCallBtn.addEventListener("click",__enterCallBtnHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.addEventListener("click",__enterCallBtnHandler);
         }
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__updateAwakeUpgradeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_enterCallBtn)
         {
            _enterCallBtn.removeEventListener("click",__enterCallBtnHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__enterCallBtnHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__updateAwakeUpgradeHandler);
      }
      
      private function __enterCallBtnHandler(param1:MouseEvent) : void
      {
         if(!_nextTemp)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNsAttValueView.awakeUpgrade.isFull"));
            return;
         }
         if(_hasPropCount < _nextTemp.SoulStoneCost)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSCallFrame.noStone.alert"));
            return;
         }
         if(!checkIsReached(_nextTemp))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSCallFrame.pawnNoReached.alert"));
            return;
         }
         ChildSender.setChildAssist(_data.childId);
      }
      
      private function checkIsReached(param1:ChildAssistUpgradeTempInfo) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1)
         {
            if(_data.growthGrade < _needAdvanceLevel)
            {
               _loc2_ = false;
            }
         }
         return _loc2_;
      }
      
      private function __updateAwakeUpgradeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         refreshView();
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
      
      private function refreshView() : void
      {
         _starView.setStars(_data.childAssistAwakeLevel);
         _hasPropCount = GoodsManager.instance.getBagCountByTempId(1,208525);
         if(_data.childAssistAwakeLevel > 0)
         {
            _enterCallBtn.visible = false;
            _upgradeBtn.visible = true;
            _currentTemp = TempleteManager.instance.childAssistUpgradeTemplateCate.getTemplateByAwakeLevel(_data.childAssistAwakeLevel);
            if(_currentTemp)
            {
               _propertyValueTxt1.text = _currentTemp.Percentage + "%";
            }
            _nextTemp = TempleteManager.instance.childAssistUpgradeTemplateCate.getTemplateByAwakeLevel(_data.childAssistAwakeLevel + 1);
            if(_nextTemp)
            {
               _propertyValueTxt2.text = _nextTemp.Percentage + "%";
               _propValueTxt.text = _hasPropCount + "/" + _nextTemp.SoulStoneCost;
               _callDescTxt.text = LanguageMgr.GetTranslation("ChildNSCallFrame.callDescTxt.text2",_needAdvanceLevel);
            }
            else
            {
               _propertyTxt2.text = "";
               _propertyValueTxt2.text = LanguageMgr.GetTranslation("ChildNSCallFrame.propertyValueTxt2.text");
               _propertyValueTxt2.x = 250;
               _propValueTxt.text = "Max";
               _callDescTxt.text = "";
            }
         }
         else
         {
            _enterCallBtn.visible = true;
            _upgradeBtn.visible = false;
            _propertyValueTxt1.text = "0%";
            _nextTemp = TempleteManager.instance.childAssistUpgradeTemplateCate.getTemplateByAwakeLevel(_data.childAssistAwakeLevel + 1);
            if(_nextTemp)
            {
               _propertyValueTxt2.text = _nextTemp.Percentage + "%";
               _propValueTxt.text = _hasPropCount + "/" + _nextTemp.SoulStoneCost;
               _callDescTxt.text = LanguageMgr.GetTranslation("ChildNSCallFrame.callDescTxt.text1",_needAdvanceLevel);
            }
         }
         if(_nextTemp)
         {
            _needAdvanceLevel = _nextTemp.AdvanceLevel;
         }
         if(checkIsReached(_nextTemp))
         {
            _callDescTxt.setFrame(2);
         }
         else
         {
            _callDescTxt.setFrame(1);
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.frameData)
         {
            data = param1.frameData as ChildData;
         }
         this.titleText = LanguageMgr.GetTranslation("public.prompt");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_decsTxt);
         _decsTxt = null;
         ObjectUtils.disposeObject(_callDescTxt);
         _callDescTxt = null;
         ObjectUtils.disposeObject(_supplementDescTxt);
         _supplementDescTxt = null;
         ObjectUtils.disposeObject(_propertyTxt1);
         _propertyTxt1 = null;
         ObjectUtils.disposeObject(_propertyTxt2);
         _propertyTxt2 = null;
         ObjectUtils.disposeObject(_propertyValueTxt1);
         _propertyValueTxt1 = null;
         ObjectUtils.disposeObject(_propertyValueTxt2);
         _propertyValueTxt2 = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_arrowsImage);
         _arrowsImage = null;
         ObjectUtils.disposeObject(_propValueTxt);
         _propValueTxt = null;
         ObjectUtils.disposeObject(_enterCallBtn);
         _enterCallBtn = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_starView);
         _starView = null;
         super.dispose();
      }
   }
}

