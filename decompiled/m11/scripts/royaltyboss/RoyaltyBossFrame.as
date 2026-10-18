package royaltyboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.royaltyboss.RoyaltyBossModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.RoyaltyBossTempInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class RoyaltyBossFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _bossTxt:GradientText;
      
      private var _itemList:Vector.<RoyaltyBossItem>;
      
      private var _rankBtn:TextButton;
      
      private var _rollPanel:HRollItemPanel;
      
      private var _group:SelectedButtonGroup;
      
      private var _list:Array;
      
      private var _propertyImg:Bitmap;
      
      private var _propertyLevelTxt:FilterFrameText;
      
      private var _fightTxt:GradientText;
      
      private var _fightNumTxt:FilterFrameText;
      
      private var _unlockTxt:GradientText;
      
      private var _levelSprite:Sprite;
      
      private var _numImg:BitmapData;
      
      private var _line:Bitmap;
      
      private var _propertySpanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _allTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _leftImg:Bitmap;
      
      private var _rightImg:Bitmap;
      
      private var _fightAllTxt:GradientText;
      
      public function RoyaltyBossFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,760,565);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("royaltyBossFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossFrame.bg");
         _bossTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.bossTxt");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.rankBtn");
         _rollPanel = ComponentFactory.Instance.creatCustomObject("royaltyBossFrame.rollPanel");
         _rollPanel.initParams("royaltyBossFrame.rollPanel.HBox","royaltyBossFrame.rollPanel.LeftBtn","royaltyBossFrame.rollPanel.RightBtn",3,101,108,18);
         _propertyImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossFrame.propertyImg");
         _propertyLevelTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.propertyLevelTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.fightTxt");
         _fightNumTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.fightNumTxt");
         _unlockTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.unlockTxt");
         _numImg = ComponentFactory.Instance.creatBitmapData("asset.RoyaltyLevelItem.numImg");
         _line = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossFrame.line");
         _propertySpanel = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.propertySpanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("royaltyBossFrame.vBox");
         _allTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.allTxt");
         _leftImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossFrame.leftImg");
         _rightImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyBossFrame.rightImg");
         _fightAllTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.fightAllTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.helpBtn");
         _levelSprite = new Sprite();
         _propertySpanel.setView(_vBox);
         addToContent(_border);
         addToContent(_bg);
         addToContent(_bossTxt);
         addToContent(_rankBtn);
         addToContent(_rollPanel);
         addToContent(_propertyImg);
         addToContent(_propertyLevelTxt);
         addToContent(_fightTxt);
         addToContent(_fightNumTxt);
         addToContent(_unlockTxt);
         addToContent(_levelSprite);
         addToContent(_line);
         addToContent(_propertySpanel);
         addToContent(_allTxt);
         addToContent(_leftImg);
         addToContent(_rightImg);
         addToContent(_fightAllTxt);
         addToContent(_helpBtn);
         _allTxt.visible = false;
         _leftImg.visible = false;
         _rightImg.visible = false;
         _fightAllTxt.visible = false;
         _allTxt.text = LanguageMgr.GetTranslation("royaltyBossFrame.allTxt.text");
         _fightAllTxt.text = LanguageMgr.GetTranslation("royaltyBossFrame.fightAllTxt.text");
         _bossTxt.text = LanguageMgr.GetTranslation("royaltyBossFrame.bossTxt.text");
         _rankBtn.text = LanguageMgr.GetTranslation("royaltyBossFrame.rankBtn.text");
         _fightTxt.text = LanguageMgr.GetTranslation("royaltyBossFrame.fightTxt.text");
         _unlockTxt.text = LanguageMgr.GetTranslation("royaltyBossFrame.unlockTxt.text");
         initItem();
         initPanel();
      }
      
      private function initPanel() : void
      {
         var _loc1_:RoyaltyLevelItem = null;
         var _loc2_:int = 0;
         _group = new SelectedButtonGroup();
         _list = [];
         var _loc4_:SimpleDictionary = TempleteManager.instance.royaltyTempCate.dic;
         _loc2_ = 1;
         while(_loc2_ <= _loc4_.keys.length)
         {
            _loc1_ = new RoyaltyLevelItem(_loc2_);
            _group.addSelectItem(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
         _rollPanel.updateList(_list);
         var _loc3_:int = model.royaltyLevel < 1 ? 0 : model.royaltyLevel - 1;
         _group.selectIndex = _loc3_;
         _rollPanel.skip(_loc3_);
      }
      
      private function initItem() : void
      {
         var _loc1_:RoyaltyBossItem = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:RoyaltyBossTempInfo = null;
         _itemList = new Vector.<RoyaltyBossItem>();
         _loc3_ = 1;
         while(_loc3_ < 4)
         {
            _loc2_ = model.passBossLevel + _loc3_;
            _loc4_ = TempleteManager.instance.royaltyBossTempCate.getTempInfoByLevel(_loc2_);
            if(_loc4_)
            {
               _loc1_ = new RoyaltyBossItem(_loc3_);
               _loc1_.data = _loc4_;
               _loc1_.x = 35 + _loc3_ % 2 * 125;
               _loc1_.y = 65 + (_loc3_ - 1) * 110;
               addToContent(_loc1_);
               _itemList.push(_loc1_);
            }
            _loc3_++;
         }
         if(_itemList.length <= 0)
         {
            _allTxt.visible = true;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__onTabBtnHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",__onTabBtnHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("royaltyBossFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         MsgMan.addObserver("ROYALTY_RANKDATA_LOAD_COMPLETE",this,__loadCompleteHandler);
         RoyaltyBossManager.instance.loadRoyaltyRankData();
      }
      
      private function __loadCompleteHandler(param1:String, param2:Object) : void
      {
         MsgMan.removeObserver("ROYALTY_RANKDATA_LOAD_COMPLETE",this,__loadCompleteHandler);
         FrameControllerManager.instance.openControllerByInfo("royaltyboss",3);
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc7_:int = 0;
         var _loc4_:RoyaltyPropertyItem = null;
         var _loc14_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc20_:int = 0;
         var _loc23_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:int = 0;
         var _loc21_:int = 0;
         var _loc16_:int = 0;
         var _loc18_:int = 0;
         var _loc22_:int = 0;
         var _loc15_:RoyaltyTempInfo = null;
         var _loc6_:SecretMapLevelTemplate = null;
         var _loc19_:SkillTempInfo = null;
         var _loc3_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = model.royaltyLevel + 1;
         NumberViewUtils.refreshValue(_loc10_,_levelSprite,_numImg,18,23,16,18,"0123456789");
         _levelSprite.x = _loc10_ >= 10 ? 591 : 600;
         _levelSprite.y = 404;
         var _loc1_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc10_);
         if(_loc1_)
         {
            _loc7_ = _loc1_.BossLevel - model.passBossLevel;
            _fightNumTxt.text = _loc7_.toString();
         }
         else
         {
            _levelSprite.visible = false;
            _fightNumTxt.visible = false;
            _fightTxt.visible = false;
            _unlockTxt.visible = false;
            _line.visible = false;
            _leftImg.visible = true;
            _rightImg.visible = true;
            _fightAllTxt.visible = true;
         }
         var _loc13_:int = _group.selectIndex + 1;
         _propertyLevelTxt.text = _loc13_.toString();
         _vBox.removeAllChild();
         _vBox.beginChanges();
         var _loc24_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc13_);
         if(_loc24_)
         {
            _loc14_ = 0;
            _loc2_ = 0;
            _loc8_ = 0;
            _loc20_ = 0;
            _loc23_ = 0;
            _loc11_ = 0;
            _loc12_ = 0;
            _loc5_ = 0;
            _loc17_ = 0;
            _loc21_ = 0;
            _loc16_ = 0;
            _loc18_ = 0;
            _loc22_ = 0;
            _loc15_ = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc13_ - 1);
            if(_loc15_)
            {
               _loc14_ = _loc24_.OpenTheseus - _loc15_.OpenTheseus;
               _loc2_ = _loc24_.OpenForbidenBoss - _loc15_.OpenForbidenBoss;
               _loc8_ = _loc24_.OpenShopLevel - _loc15_.OpenShopLevel;
               _loc20_ = _loc24_.OpenOutsideTreasureHoke - _loc15_.OpenOutsideTreasureHoke;
               _loc23_ = _loc24_.OpenInsideTreasureHoke - _loc15_.OpenInsideTreasureHoke;
               _loc11_ = _loc24_.OpenCoreTreasureHoke - _loc15_.OpenCoreTreasureHoke;
               _loc12_ = _loc24_.OpenSecret - _loc15_.OpenSecret;
               _loc5_ = _loc24_.OpenWarSoul - _loc15_.OpenWarSoul;
               _loc17_ = _loc24_.OpenWarSoulTower - _loc15_.OpenWarSoulTower;
               _loc21_ = _loc24_.OpenFinalRoad - _loc15_.OpenFinalRoad;
               _loc16_ = _loc24_.OpenTower - _loc15_.OpenTower;
               _loc18_ = _loc24_.OpenSlate - _loc15_.OpenSlate;
               _loc22_ = _loc24_.OpenDungeon - _loc15_.OpenDungeon;
            }
            else
            {
               _loc14_ = int(_loc24_.OpenTheseus);
               _loc2_ = int(_loc24_.OpenForbidenBoss);
               _loc8_ = int(_loc24_.OpenShopLevel);
               _loc20_ = int(_loc24_.OpenOutsideTreasureHoke);
               _loc23_ = int(_loc24_.OpenInsideTreasureHoke);
               _loc11_ = int(_loc24_.OpenCoreTreasureHoke);
               _loc12_ = int(_loc24_.OpenSecret);
               _loc5_ = int(_loc24_.OpenWarSoul);
               _loc17_ = int(_loc24_.OpenWarSoulTower);
               _loc21_ = int(_loc24_.OpenFinalRoad);
               _loc16_ = int(_loc24_.OpenTower);
               _loc18_ = int(_loc24_.OpenSlate);
               _loc22_ = int(_loc24_.OpenDungeon);
            }
            if(_loc14_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openTheseus.text",_loc24_.OpenTheseus);
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc2_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openForbidenBoss.text" + _loc24_.OpenForbidenBoss);
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc8_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openShopLevel.text",_loc24_.OpenShopLevel);
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc20_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openOutsideTreasureHoke.text");
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc23_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openInsideTreasureHoke.text");
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc11_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openCoreTreasureHoke.text",_loc24_.OpenCoreTreasureHoke);
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc12_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc6_ = TempleteManager.instance.secretMapCate.getTempInfo(_loc24_.OpenSecret);
               if(_loc6_)
               {
                  _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openSecret.text",_loc6_.MapName);
               }
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc16_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openthesstower.text");
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc18_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openthessalte.text");
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc22_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openthesdungeon.text");
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc5_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openWarSoul.text" + _loc24_.OpenWarSoul);
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc17_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openWarSoulTower.text");
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            if(_loc21_ > 0)
            {
               _loc4_ = new RoyaltyPropertyItem();
               _loc4_.txt = LanguageMgr.GetTranslation("royaltyBossFrame.openFinalRoad.text" + _loc24_.OpenFinalRoad);
               _loc4_.frame = 2;
               _vBox.addChild(_loc4_);
            }
            _loc19_ = TempleteManager.instance.skillTemplateDic[_loc24_.SkillId];
            if(_loc19_)
            {
               _loc3_ = _loc19_.Description.split("|");
               _loc9_ = 0;
               while(_loc9_ < _loc3_.length)
               {
                  _loc4_ = new RoyaltyPropertyItem();
                  _loc4_.txt = _loc3_[_loc9_];
                  _loc4_.frame = 1;
                  _vBox.addChild(_loc4_);
                  _loc9_++;
               }
            }
            _vBox.commitChanges();
            _propertySpanel.invalidateViewport();
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : RoyaltyBossModel
      {
         return RoyaltyBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:RoyaltyBossItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         for each(var _loc2_:RoyaltyLevelItem in _list)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _list = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bossTxt);
         _bossTxt = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_rollPanel);
         _rollPanel = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_propertyImg);
         _propertyImg = null;
         ObjectUtils.disposeObject(_propertyLevelTxt);
         _propertyLevelTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_fightNumTxt);
         _fightNumTxt = null;
         ObjectUtils.disposeObject(_unlockTxt);
         _unlockTxt = null;
         ObjectUtils.disposeObject(_levelSprite);
         _levelSprite = null;
         ObjectUtils.disposeObject(_numImg);
         _numImg = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_propertySpanel);
         _propertySpanel = null;
         ObjectUtils.disposeObject(_leftImg);
         _leftImg = null;
         ObjectUtils.disposeObject(_rightImg);
         _rightImg = null;
         ObjectUtils.disposeObject(_fightAllTxt);
         _fightAllTxt = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

