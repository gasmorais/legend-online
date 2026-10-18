package theseus.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusTreasureCoreInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.StarBar;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureCoreFrame extends Frame
   {
      
      private static const SKILL:int = 3;
      
      private var _bg:Bitmap;
      
      private var _iconBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _item1:BaseItemView;
      
      private var _item2:BaseItemView;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _lvTxt:FilterFrameText;
      
      private var _profileBmp:Bitmap;
      
      private var _starBar:StarBar;
      
      private var _growupBtn:IconButton;
      
      private var _itemLock:Bitmap;
      
      private var _breakBtn:IconButton;
      
      private var _skillList:Array = [];
      
      public function TreasureCoreFrame()
      {
         super();
         initView();
         refreshView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("TreasureCoreFrame.titleText.text");
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.coreFrameBg");
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.theseus.coreBg");
         _icon = ComponentFactory.Instance.creatCustomObject("TreasureCoreFrame.icon");
         _item1 = ComponentFactory.Instance.creatCustomObject("TreasureCoreFrame.itemView1");
         _item2 = ComponentFactory.Instance.creatCustomObject("TreasureCoreFrame.itemView2");
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("TreasureCoreFrame.txt1");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("TreasureCoreFrame.txt2");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("TreasureCoreFrame.lvTxt");
         _profileBmp = ComponentFactory.Instance.creatBitmap("asset.theseus.treasureQuality");
         _starBar = new StarBar(6,0,"asset.theseus.EmptyStarBg","asset.theseus.FullStarBg");
         _starBar.x = 185;
         _starBar.y = 269;
         _growupBtn = ComponentFactory.Instance.creatComponentByStylename("TreasureCoreFrame.growupBtn");
         _itemLock = ComponentFactory.Instance.creatBitmap("asset.theseus.itemLock");
         _breakBtn = ComponentFactory.Instance.creatComponentByStylename("TreasureCoreFrame.breakBtn");
         addToContent(_bg);
         addToContent(_iconBg);
         addToContent(_icon);
         addToContent(_item1);
         addToContent(_item2);
         addToContent(_txt1);
         addToContent(_txt2);
         addToContent(_lvTxt);
         addToContent(_profileBmp);
         addToContent(_starBar);
         addToContent(_growupBtn);
         addToContent(_itemLock);
         addToContent(_breakBtn);
         _breakBtn.visible = false;
         _icon.mask = createSprite();
         _iconBg.x = 160;
         _iconBg.y = 54;
         _profileBmp.x = 105;
         _profileBmp.y = 272;
         initSkillItem();
      }
      
      public function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(203,98,39);
         _loc1_.graphics.endFill();
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _growupBtn.addEventListener("click",__growupBtnClickHandler);
         _breakBtn.addEventListener("click",__growupBtnClickHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _growupBtn.removeEventListener("click",__growupBtnClickHandler);
         _breakBtn.removeEventListener("click",__growupBtnClickHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",__updateHandler);
      }
      
      private function __updateHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __growupBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Boolean = true;
         var _loc4_:int = int(RoyaltyBossManager.instance.model.royaltyLevel);
         var _loc5_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc4_);
         if(_loc5_ && coreInfo.Level >= _loc5_.OpenCoreTreasureHoke)
         {
            _loc3_ = false;
         }
         var _loc2_:int = int(SecretAdventerManager.Instance.model.frameInfo.passMapId);
         if(coreInfo.SecretLevel > _loc2_)
         {
            _loc3_ = false;
         }
         if(!_loc3_)
         {
            if(nextCoreInfo)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("TreasureCoreFrame.isGrowup.text"));
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("TreasureCoreFrame.isGrowup.text2"));
            }
            return;
         }
         TheseussoulManager.Instance.doSomething(5);
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
      
      public function refreshView() : void
      {
         if(!coreInfo)
         {
            return;
         }
         _icon.icon = IconFactory.getSevenYearIconPath(coreInfo.Icon);
         _lvTxt.text = LanguageMgr.GetTranslation("public.level2",coreInfo.Level);
         _starBar.progress = coreInfo.Profile;
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = coreInfo.StrengthenItem;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_loc5_.templateInfo)
         {
            _item1.data = _loc5_;
            _loc1_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc5_.templateId));
            _loc2_ = _loc1_ >= coreInfo.StrengthenItemNum ? 1 : 2;
            _txt1.setFrame(_loc2_);
            _txt1.text = _loc1_ + " / " + coreInfo.StrengthenItemNum;
         }
         var _loc3_:int = -1;
         _loc5_ = new GoodsInfo();
         _loc5_.templateId = coreInfo.BreachItem;
         if(_loc5_.templateInfo)
         {
            _itemLock.visible = false;
            _growupBtn.visible = false;
            _breakBtn.visible = true;
            _item2.data = _loc5_;
            _loc3_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc5_.templateId));
            _loc2_ = _loc3_ >= coreInfo.BreachItemNum ? 1 : 2;
            _txt2.setFrame(_loc2_);
            _txt2.text = _loc3_ + " / " + coreInfo.BreachItemNum;
         }
         else
         {
            _itemLock.visible = true;
            _growupBtn.visible = true;
            _breakBtn.visible = false;
            _txt2.text = "";
         }
         var _loc4_:Boolean = false;
         if(_loc1_ >= coreInfo.StrengthenItemNum)
         {
            if(_loc3_ <= -1)
            {
               _loc4_ = true;
            }
            else if(_loc3_ >= coreInfo.BreachItemNum)
            {
               _loc4_ = true;
            }
         }
         _growupBtn.enable = _loc4_;
         refreshSkillItem();
      }
      
      private function refreshSkillItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:TreasureSkillItem = null;
         var _loc4_:SkillTempInfo = null;
         var _loc1_:Array = [];
         if(coreInfo && coreInfo.CoreSkills)
         {
            _loc1_ = coreInfo.CoreSkills.split(",");
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _skillList[_loc3_];
            if(_loc1_[_loc3_])
            {
               _loc4_ = TempleteManager.instance.skillTemplateDic[_loc1_[_loc3_]];
               _loc2_.data = _loc4_;
            }
            else
            {
               _loc2_.data = null;
            }
            _loc3_++;
         }
      }
      
      private function initSkillItem() : void
      {
         var _loc1_:TreasureSkillItem = null;
         var _loc2_:int = 0;
         _skillList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TreasureCoreFrame.item",[_loc2_ + 1]);
            _loc1_.x = 83 + _loc2_ * 97;
            _loc1_.y = 375;
            addToContent(_loc1_);
            _skillList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function get coreInfo() : TheseusTreasureCoreInfo
      {
         return TempleteManager.instance.theseusTreasureCoreCate.getTempInfoByLevel(model.coreLevel);
      }
      
      private function get nextCoreInfo() : TheseusTreasureCoreInfo
      {
         return TempleteManager.instance.theseusTreasureCoreCate.getTempInfoByLevel(model.coreLevel + 1);
      }
      
      private function get model() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_item1);
         _item1 = null;
         ObjectUtils.disposeObject(_item2);
         _item2 = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_txt2);
         _txt2 = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_profileBmp);
         _profileBmp = null;
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         ObjectUtils.disposeObject(_growupBtn);
         _growupBtn = null;
         ObjectUtils.disposeObject(_itemLock);
         _itemLock = null;
         ObjectUtils.disposeObject(_breakBtn);
         _breakBtn = null;
         for each(var _loc1_:TreasureSkillItem in _skillList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

