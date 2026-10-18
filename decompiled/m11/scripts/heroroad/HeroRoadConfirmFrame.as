package heroroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.heroroad.HeroRoadInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.HeroRoadTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class HeroRoadConfirmFrame extends Frame implements IManualSize
   {
      
      private var _taskTempId:int;
      
      private var _template:HeroRoadTemplateInfo;
      
      private var _contain:Component;
      
      private var _pointImg:Image;
      
      private var _buyBtn:IconButton;
      
      private var _receiveBtn:IconButton;
      
      private var _receiveNote:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _activeTxt:FilterFrameText;
      
      private var _taskNoteTxt:FilterFrameText;
      
      public function HeroRoadConfirmFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,517,228);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _taskNoteTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadConfirmFrame.taskNoteTxt");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("heroroad.SmallPointImg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.buyConfirmBtn");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.receiveConfirmBtn");
         _receiveNote = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadConfirmFrame.receiveNoteTxt");
         _contain = new Component();
         _contain.x = 0;
         _contain.y = 0;
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadConfirmFrame.priceTxt");
         _activeTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadConfirmFrame.activeTxt");
         addToContent(_pointImg);
         addToContent(_buyBtn);
         addToContent(_receiveBtn);
         addToContent(_receiveNote);
         addToContent(_contain);
         addToContent(_priceTxt);
         addToContent(_activeTxt);
         addToContent(_taskNoteTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyBtn.addEventListener("click",__buyHandler);
         _receiveBtn.addEventListener("click",__receiveHandler);
         NotificationManager.instance.addEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buyBtn.removeEventListener("click",__buyHandler);
         _receiveBtn.removeEventListener("click",__receiveHandler);
         NotificationManager.instance.removeEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _template.BuyNeedPoint)
         {
            RechargeAlertMannager.show();
            return;
         }
         HeroRoadManager.instance.operateHandler(HeroRoadManager.OP_BUYS_REWARD,_taskTempId);
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         HeroRoadManager.instance.operateHandler(HeroRoadManager.OP_TAKE_REWARD,_taskTempId);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc2_:HeroRoadInfo = HeroRoadManager.instance.getItemById(_taskTempId);
         if(!_loc2_)
         {
            dispose();
            return;
         }
         _priceTxt.visible = _loc2_.buysItemsState == 1;
         _pointImg.visible = _loc2_.buysItemsState == 1;
         _buyBtn.visible = _loc2_.buysItemsState == 1;
         _activeTxt.visible = _loc2_.buysItemsState == 0;
         if(_loc2_.masterType == HeroRoadManager.MASTER_DAY)
         {
            _receiveBtn.visible = _loc2_.takeItemsState == 1 || _loc2_.takeItemsState == 2;
            _receiveNote.visible = _loc2_.takeItemsState == 1 || _loc2_.takeItemsState == 2;
            _receiveBtn.enable = _loc2_.takeItemsState == 1;
         }
         else if(_loc2_.masterType == HeroRoadManager.MASTER_VIP)
         {
            _receiveBtn.visible = false;
            _receiveNote.visible = false;
         }
         _priceTxt.text = String(_template.BuyNeedPoint);
         _activeTxt.htmlText = LanguageMgr.GetTranslation("heroroad.HeroRoadBoxItem.activeTxt",_template.Param1);
         var _loc3_:String = "";
         if((_template.MasterType == 6 || _template.MasterType == 7) && _template.QuestType == 2)
         {
            _loc3_ = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.randomTypeTxt");
         }
         if(_template.SonType == 1000)
         {
            titleText = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.titleTxt1",_template.Param2,_loc3_);
            _taskNoteTxt.text = LanguageMgr.GetTranslation("heroroad.HeroRoadConfirmFrame.taskNoteTxt1",_template.Param2);
            _receiveNote.text = LanguageMgr.GetTranslation("heroroad.HeroRoadConfirmFrame.receiveNoteTxt",_template.Param2 - _loc2_.takeNumbers);
         }
         else if(_template.SonType == 1001)
         {
            titleText = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.titleTxt2",_template.Param2,_loc3_);
            _taskNoteTxt.text = LanguageMgr.GetTranslation("heroroad.HeroRoadConfirmFrame.taskNoteTxt2");
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:Array = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         ObjectUtils.disposeAllChildren(_contain);
         _template = TempleteManager.instance.heroRoadTemplateCate.getTemplateByID(_taskTempId);
         var _loc6_:Array = _template.BuysItems.split("|");
         var _loc3_:int = (474 - _loc6_.length * 60) / (_loc6_.length + 1);
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc5_].split(",");
            _loc2_ = ComponentFactory.Instance.creatCustomObject("heroroad.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[0];
            _loc4_.count = _loc1_[1];
            _loc4_.showCount = true;
            _loc2_.data = _loc4_;
            _loc2_.x = 0 + _loc3_ * (_loc5_ + 1) + 60 * _loc5_;
            _loc2_.y = 48;
            _contain.addChild(_loc2_);
            _loc5_++;
         }
         __updateViewHandler(null);
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
      
      public function show(param1:HeroRoadInfo) : void
      {
         _taskTempId = param1.taskTempId;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_contain);
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_receiveNote);
         _receiveNote = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_activeTxt);
         _activeTxt = null;
         ObjectUtils.disposeObject(_taskNoteTxt);
         _taskNoteTxt = null;
         _template = null;
         super.dispose();
      }
   }
}

