package cultureactive
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.culture.CultureConditionInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CultureActiveManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class CultureActiveItem extends Component
   {
      
      private var _data:CultureConditionInfo;
      
      private var _itemBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _receiveBtn:IconButton;
      
      private var _iconBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _rewardNote:Bitmap;
      
      private var _contain:Component;
      
      private var _progressBar:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _receivedImg:Bitmap;
      
      private var _index:int;
      
      public function CultureActiveItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.cultureactive.itemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("cultureactive.nameTxt");
         _progressBar = ComponentFactory.Instance.creatCustomObject("asset.cultureactive.ProgressBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("cultureactive.ProgressLevelTxt");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("cultureactive.receiveBtn");
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.cultureactive.iconBg");
         _icon = ComponentFactory.Instance.creatCustomObject("cultureactive.cultureActiveItemIcon");
         _rewardNote = ComponentFactory.Instance.creatBitmap("asset.cultureactive.rewardNote");
         _receivedImg = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         _contain = new Component();
         _contain.x = 30;
         _contain.y = 100;
         addChild(_itemBg);
         addChild(_nameTxt);
         addChild(_progressBar);
         addChild(_progressTxt);
         addChild(_receiveBtn);
         addChild(_iconBg);
         addChild(_icon);
         addChild(_rewardNote);
         addChild(_contain);
         addChild(_receivedImg);
         _receivedImg.x = 59;
         _receivedImg.y = 473;
         data = null;
      }
      
      private function initEvent() : void
      {
         _receiveBtn.addEventListener("click",__receiveHandler);
      }
      
      private function removeEvent() : void
      {
         if(_receiveBtn)
         {
            _receiveBtn.removeEventListener("click",__receiveHandler);
         }
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set data(param1:CultureConditionInfo) : void
      {
         var _loc6_:Bitmap = null;
         var _loc3_:BaseItemView = null;
         var _loc2_:Array = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         if(!param1)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
         _data = param1;
         ObjectUtils.disposeAllChildren(_contain);
         var _loc7_:Array = _data.rewardItems.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc2_ = _loc7_[_loc5_].split(",");
            _loc6_ = ComponentFactory.Instance.creatBitmap("asset.cultureactive.iconBg");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("cultureactive.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[0];
            _loc4_.count = _loc2_[1];
            _loc4_.showCount = true;
            _loc3_.data = _loc4_;
            _loc6_.x = 7 + int(_loc5_ % 2) * 58;
            _loc6_.y = 125 + int(_loc5_ / 2) * 58;
            _loc3_.x = 11 + int(_loc5_ % 2) * 58;
            _loc3_.y = 129 + int(_loc5_ / 2) * 58;
            _contain.addChild(_loc6_);
            _contain.addChild(_loc3_);
            _loc5_++;
         }
         __updateViewHandler(null);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = int(_data.myCultureCount);
         var _loc3_:int = int(_data.cultureCount < 1 ? 1 : _data.cultureCount);
         _progressTxt.text = _loc4_ + "/" + _loc3_;
         var _loc2_:int = _loc4_ / _loc3_ * 100;
         _progressBar.gotoAndStop(_loc2_);
         _icon.icon = IconFactory.getWholeserverTrain(_data.sonType);
         _receiveBtn.enable = _data.rewardState == 1;
         _receivedImg.visible = _data.rewardState == 2;
         _nameTxt.htmlText = LanguageMgr.GetTranslation("cultureactive.nameTxt" + _data.sonType,_data.cultureCount,_data.cultureGrade);
         if(_index == 1)
         {
            if((_data.sonType == 308 || _data.sonType == 309) && _data.cultureCount <= 1)
            {
               _nameTxt.htmlText = LanguageMgr.GetTranslation("cultureactive.nameTxt1_" + _data.sonType,_data.cultureGrade);
            }
         }
         else if(_index == 2 || _index == 3)
         {
            if(_data.sonType == 308 || _data.sonType == 309)
            {
               _nameTxt.htmlText = LanguageMgr.GetTranslation("cultureactive.nameTxt23_" + _data.sonType,_data.cultureCount,_data.cultureGrade);
            }
         }
         if(_nameTxt.numLines > 1)
         {
            _nameTxt.y = 110;
         }
         else
         {
            _nameTxt.y = 116;
         }
         _icon.tipData = LanguageMgr.GetTranslation("cultureactive.itemTitleTip" + _data.sonType,_data.scoreItem,_data.scoreReward);
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         CultureActiveManager.instance.OperateCultureReq(2,_data.sonType,_index,_data.rewardLevel);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_rewardNote);
         _rewardNote = null;
         ObjectUtils.disposeAllChildren(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeViolentMc(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_receivedImg);
         _receivedImg = null;
         _data = null;
         super.dispose();
      }
   }
}

