package dragontitan.inject
{
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.BasePanelComponent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanInjectInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanInjectView extends BasePanelComponent
   {
      
      private var _gridBg:Image;
      
      private var _titanImg:Bitmap;
      
      private var _nameText:FilterFrameText;
      
      private var _injectExplain:FilterFrameText;
      
      private var _succedRateTxt:FilterFrameText;
      
      private var _spiritBtn:IconButton;
      
      private var _downArrow:Bitmap;
      
      private var _progress:ProgressCommon;
      
      private var _headIcon:BaseIconView;
      
      private var _injectStateIcon:Bitmap;
      
      private var _skillIcon:BaseIconView;
      
      private var _circles:Vector.<Bitmap>;
      
      private var _numbers:Vector.<Sprite>;
      
      private var _numberBmp:BitmapData;
      
      private var _costTxt:FilterFrameText;
      
      private var _currentTxt:FilterFrameText;
      
      private var _costCountTxt:FilterFrameText;
      
      private var _currentPackTxt:FilterFrameText;
      
      private var _rewardCountTxt:FilterFrameText;
      
      private var _itemBmpCost:Image;
      
      private var _itemBmpPack:Image;
      
      private var _attPanel:DragonTitanInjectAttPanel;
      
      private var _levelTip:DragonTitanInjectLevelTip;
      
      private var _desView:DragonTitanInjectDesc;
      
      private var _currentExpView:DisplayObject;
      
      private var _tipComponentLeft:Component;
      
      private var _tipComponentRight:Component;
      
      private var _injectInfo:DragonTitanInjectInfo;
      
      private const MAX_LEVEL:int = 10;
      
      private var _currentTitanId:int = -1;
      
      public function DragonTitanInjectView()
      {
         super();
         this.mouseEnabled = false;
         this.x = 189;
         this.y = 36;
         __updateView();
      }
      
      override protected function initView() : void
      {
         var _loc3_:Sprite = null;
         var _loc6_:Bitmap = null;
         var _loc4_:int = 0;
         _tipComponentLeft = getTipComponent(95);
         _tipComponentRight = getTipComponent(290);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208059);
         _tipComponentLeft.tipData = _loc1_.Description;
         _tipComponentRight.tipData = _loc1_.Description;
         _gridBg = addCreatComponentByStylename("dragontitan.gridBg");
         _headIcon = addCreatCustomObject("dragontitan.spirit.headIcon");
         _injectStateIcon = addCreatBitmap("asset.dragontitan.reinject");
         _skillIcon = addCreatCustomObject("dragontitan.spirit.skillIcon");
         _nameText = addCreatComponentByStylename("DragonTitanFrame.spiritTitanName");
         _injectExplain = addCreatComponentByStylename("DragonTitan.injectExplain");
         _succedRateTxt = addCreatComponentByStylename("DragonTitanFrame.succedRateTxt");
         _spiritBtn = addCreatComponentByStylename("dragontitan.firstSpiritBtn");
         _downArrow = addCreatBitmap("asset.dragontitan.downArrow");
         _progress = addCreatComponentByStylename("dragontitan.progressCommon");
         _numberBmp = creatBitmapData("asset.dragontitan.number");
         _costTxt = addCreatComponentByStylename("DragonTitanFrame.costItemTxt");
         _costTxt.text = LanguageMgr.GetTranslation("DragonTitanInjectView.initView.costTxt",_loc1_.TemplateName);
         _currentTxt = addCreatComponentByStylename("DragonTitanFrame.currentItemTxt");
         _currentTxt.text = LanguageMgr.GetTranslation("DragonTitanInjectView.initView.currentTxt",_loc1_.TemplateName);
         _costCountTxt = addCreatComponentByStylename("DragonTitanFrame.costItemCountTxt");
         _currentPackTxt = addCreatComponentByStylename("DragonTitanFrame.currentItemCountTxt");
         _rewardCountTxt = addCreatComponentByStylename("DragonTitanFrame.rewardCountTxt");
         _itemBmpCost = addCreatComponentByStylename("dragontitan.spiritItemLittle");
         _itemBmpPack = addCreatComponentByStylename("dragontitan.spiritItemLittle");
         _itemBmpPack.x = 400;
         _circles = new Vector.<Bitmap>(10);
         _numbers = new Vector.<Sprite>(10);
         var _loc2_:int = 38;
         var _loc5_:int = 48;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc6_ = addCreatBitmap("asset.dragontitan.cricle");
            _loc6_.x = _loc2_ + _loc4_ * _loc5_ - _loc6_.width * 0.5;
            _loc6_.y = 200;
            _circles[_loc4_] = _loc6_;
            _loc3_ = new Sprite();
            NumberViewUtils.refreshValue(_loc4_ + 1,_loc3_,_numberBmp,16,20,8,16,"1234567890");
            _loc3_.x = _loc6_.x + (_loc6_.width - _loc3_.width) * 0.5;
            _loc3_.y = _loc6_.y + (_loc6_.height - _loc3_.height) * 0.5;
            addChild(_loc3_);
            _numbers[_loc4_] = _loc3_;
            _loc4_++;
         }
         _attPanel = new DragonTitanInjectAttPanel();
         _desView = new DragonTitanInjectDesc();
         _levelTip = new DragonTitanInjectLevelTip();
         _levelTip.x = 100;
         this.addChild(_levelTip);
      }
      
      private function getTipComponent(param1:int) : Component
      {
         var _loc3_:Component = new Component();
         _loc3_.x = param1;
         _loc3_.y = 263;
         _loc3_.width = 130;
         _loc3_.height = 20;
         _loc3_.tipStyle = "faterotary.FateStoneIcon_Tip";
         var _loc2_:Graphics = _loc3_.graphics;
         _loc2_.beginFill(0,0.1);
         _loc2_.drawRect(0,0,130,20);
         _loc2_.endFill();
         addChild(_loc3_);
         return _loc3_;
      }
      
      override protected function initEvent() : void
      {
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,__updateView);
         MsgMan.addObserver("TITAN_FAME_CLICK_SKILL",this,selectSkill);
         addEvent(GoodsManager.instance,"BAG_FULL",__onBagUpdate);
         if(_spiritBtn)
         {
            addEvent(_spiritBtn,"click",__spiritClickHanlder);
         }
      }
      
      private function __onBagUpdate(param1:Object) : void
      {
         __updateView();
      }
      
      private function selectSkill(param1:String = null, param2:Object = null) : void
      {
         _injectInfo = null;
         __updateView(null,null);
      }
      
      protected function __spiritClickHanlder(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(!GoodsManager.instance.isBagGoodsEnough(208059,parseInt(_costCountTxt.text)))
         {
            _loc3_ = LanguageMgr.GetTranslation("DragonTitanChargeView.itemNotEnough");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(injectInfo.isActive)
         {
            if(injectInfo.isUpTop)
            {
               _loc2_ = LanguageMgr.GetTranslation("DragonTitanChargeView.circleToTop");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            DragonTitanManager.instance.sendTitanRequest(5,injectInfo.titianId);
         }
         else
         {
            DragonTitanManager.instance.sendTitanRequest(4,injectInfo.titianId);
         }
      }
      
      public function __updateView(param1:String = null, param2:Object = null) : void
      {
         var _loc8_:String = null;
         var _loc11_:Array = null;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc14_:GoodsInfo = null;
         var _loc4_:String = null;
         var _loc13_:SkillTempInfo = null;
         var _loc6_:int = 0;
         _injectInfo = null;
         _currentTitanId = DragonTitanManager.instance.model.viewTitanId;
         var _loc5_:DragonTitanTempInfo = injectInfo.titanTempInfo;
         if(_loc5_)
         {
            _loc8_ = _loc5_.AvatarPath;
            if(_loc5_.isActive)
            {
               _loc11_ = ConfigInfoManager.instance.getKeyToArr2("titan_reinject_reward",",");
               _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc11_[0]);
               _skillIcon.icon = IconFactory.getCommonIconPath(_loc8_);
               _loc14_ = new GoodsInfo();
               _loc14_.templateId = _loc11_[0];
               _loc14_.count = _loc11_[1];
               _skillIcon.icon = _loc7_.iconPath;
               _skillIcon.tipData = _loc14_;
               _skillIcon.tipStyle = "yishi.view.tips.goods.PropTips";
               _skillIcon.tipDirctions = "7,5,4,6,1,2,0,3";
               _headIcon.visible = false;
               _injectStateIcon.visible = true;
               _loc4_ = LanguageMgr.GetTranslation("DragonTitanInjectView.updateView.nameText");
               _nameText.text = _loc4_;
               _rewardCountTxt.visible = true;
               _rewardCountTxt.text = _loc11_[1];
               _rewardCountTxt.x = _skillIcon.x + 60 - _rewardCountTxt.width - 2;
            }
            else
            {
               _loc13_ = injectInfo.skillTempInfo;
               _skillIcon.icon = IconFactory.getTecIconByIcon(_loc13_.Icons);
               _skillIcon.tipData = _loc13_;
               _skillIcon.tipStyle = "yishi.view.tips.goods.SkillTips";
               _skillIcon.tipDirctions = "4,6,5,7,0,1,2,3";
               _nameText.text = _loc5_.TemplateName;
               _headIcon.visible = true;
               _injectStateIcon.visible = false;
               if(_headIcon.icon != _loc8_)
               {
                  _headIcon.icon = IconFactory.getCommonIconPath(_loc8_);
                  _headIcon.tipData = injectInfo.titianId;
                  _headIcon.tipStyle = "yishi.view.tips.DragonTitanTips";
                  _headIcon.isFollowMouse = false;
                  _headIcon.tipDirctions = "4,5,6,0,1,2,3,7";
               }
               _rewardCountTxt.visible = false;
            }
         }
         if(_currentExpView && _currentExpView.parent)
         {
            _currentExpView.parent.removeChild(_currentExpView);
         }
         if(injectInfo.isActive)
         {
            _currentExpView = _desView;
            _desView.updateView(injectInfo);
            _spiritBtn.iconStyle = "asset.dragontitan.reinjectBtn";
            _spiritBtn.iconInnerRectString = "20,90,9,25,13";
            _injectExplain.text = LanguageMgr.GetTranslation("DragonTitanInjectView.updateView.explain1");
         }
         else
         {
            _currentExpView = _attPanel;
            _attPanel.updateView(injectInfo);
            _spiritBtn.iconStyle = "asset.dragontitan.firstSpiritBtn";
            _spiritBtn.iconInnerRectString = "14,99,9,25,13";
            _injectExplain.text = LanguageMgr.GetTranslation("DragonTitanInjectView.updateView.explain2");
         }
         addChild(_currentExpView);
         var _loc12_:int = int(injectInfo.injectGrade);
         _progress.value = _loc12_ / (10 - 1);
         _loc6_ = 0;
         while(_loc6_ < 10)
         {
            _circles[_loc6_].filters = _loc6_ >= _loc12_ ? [UIFilter.getGrayFilter()] : null;
            _loc6_++;
         }
         _currentPackTxt.text = GoodsManager.instance.getGoodsNumByTempId(208059).toString();
         var _loc3_:UpgradeTemplateInfo = injectInfo.nextUpgradeInfo;
         var _loc10_:String = "0";
         var _loc9_:String = LanguageMgr.GetTranslation("DragonTitanInjectView.updateView.rateTxt1");
         _levelTip.visible = false;
         if(_loc3_)
         {
            if(!injectInfo.isUpTop)
            {
               _loc10_ = _loc3_.Data.toString();
               _loc9_ = LanguageMgr.GetTranslation("DragonTitanInjectView.updateView.rateTxt2") + _loc3_.ActiveObject + "%</font>";
               if(injectInfo.injectGrade != 10)
               {
                  _levelTip.visible = true;
                  _levelTip.updateView(injectInfo,_circles[injectInfo.injectGrade]);
               }
            }
         }
         _costCountTxt.text = _loc10_;
         _succedRateTxt.htmlText = _loc9_;
      }
      
      private function get injectInfo() : DragonTitanInjectInfo
      {
         if(!_injectInfo)
         {
            _injectInfo = DragonTitanManager.instance.model.getTaitanInjectInfo(_currentTitanId);
         }
         return _injectInfo;
      }
      
      override protected function removeEvent() : void
      {
         MsgMan.removeObserver("DragonTitanEvent.TITAN_DATA",this,__updateView);
         MsgMan.removeObserver("TITAN_FAME_CLICK_SKILL",this,selectSkill);
      }
      
      override public function dispose() : void
      {
         if(_gridBg)
         {
            ObjectUtils.disposeObject(_gridBg);
         }
         _gridBg = null;
         if(_titanImg)
         {
            ObjectUtils.disposeObject(_titanImg);
         }
         _titanImg = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_titanImg)
         {
            ObjectUtils.disposeObject(_titanImg);
         }
         _titanImg = null;
         if(_succedRateTxt)
         {
            ObjectUtils.disposeObject(_succedRateTxt);
         }
         _succedRateTxt = null;
         if(_spiritBtn)
         {
            ObjectUtils.disposeObject(_spiritBtn);
         }
         _spiritBtn = null;
         if(_downArrow)
         {
            ObjectUtils.disposeObject(_downArrow);
         }
         _downArrow = null;
         if(_progress)
         {
            ObjectUtils.disposeObject(_progress);
         }
         _progress = null;
         if(_headIcon)
         {
            ObjectUtils.disposeObject(_headIcon);
         }
         _headIcon = null;
         if(_injectStateIcon)
         {
            ObjectUtils.disposeObject(_injectStateIcon);
         }
         _injectStateIcon = null;
         if(_skillIcon)
         {
            ObjectUtils.disposeObject(_skillIcon);
         }
         _skillIcon = null;
         var _loc1_:int = 0;
         if(_numbers != null)
         {
            while(_loc1_ < _numbers.length)
            {
               ObjectUtils.disposeObject(_numbers[_loc1_]);
               _loc1_++;
            }
            _numbers.length = 0;
            _numbers = null;
         }
         if(_circles)
         {
            _loc1_ = 0;
            _loc1_;
            while(_loc1_ < _circles.length)
            {
               ObjectUtils.disposeObject(_circles[_loc1_]);
               _loc1_++;
            }
            _circles.length = 0;
            _circles = null;
         }
         if(_numberBmp)
         {
            ObjectUtils.disposeObject(_numberBmp);
         }
         _numberBmp = null;
         if(_costTxt)
         {
            ObjectUtils.disposeObject(_costTxt);
         }
         _costTxt = null;
         if(_currentTxt)
         {
            ObjectUtils.disposeObject(_currentTxt);
         }
         _currentTxt = null;
         if(_costCountTxt)
         {
            ObjectUtils.disposeObject(_costCountTxt);
         }
         _costCountTxt = null;
         if(_rewardCountTxt)
         {
            ObjectUtils.disposeObject(_rewardCountTxt);
         }
         _rewardCountTxt = null;
         if(_currentPackTxt)
         {
            ObjectUtils.disposeObject(_currentPackTxt);
         }
         _currentPackTxt = null;
         if(_itemBmpCost)
         {
            ObjectUtils.disposeObject(_itemBmpCost);
         }
         _itemBmpCost = null;
         if(_itemBmpPack)
         {
            ObjectUtils.disposeObject(_itemBmpPack);
         }
         _itemBmpPack = null;
         if(_attPanel)
         {
            ObjectUtils.disposeObject(_attPanel);
         }
         _attPanel = null;
         if(_levelTip)
         {
            ObjectUtils.disposeObject(_levelTip);
         }
         _levelTip = null;
         if(_desView)
         {
            ObjectUtils.disposeObject(_desView);
         }
         _desView = null;
         if(_currentExpView)
         {
            ObjectUtils.disposeObject(_currentExpView);
         }
         _currentExpView = null;
         if(_injectInfo)
         {
            ObjectUtils.disposeObject(_injectInfo);
         }
         _injectInfo = null;
         if(_tipComponentLeft)
         {
            ObjectUtils.disposeObject(_tipComponentLeft);
         }
         _tipComponentLeft = null;
         if(_tipComponentRight)
         {
            ObjectUtils.disposeObject(_tipComponentRight);
         }
         _tipComponentRight = null;
         super.dispose();
      }
   }
}

