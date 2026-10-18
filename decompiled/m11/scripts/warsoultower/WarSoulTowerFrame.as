package warsoultower
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.WarSoulTowerLevelTempInfo;
   import yishi.datas.templates.WarSoulTowerStageTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.manager.WarSoulTowerManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class WarSoulTowerFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _leftBorder:ScaleBitmapImage;
      
      private var _rewardsBg:Bitmap;
      
      private var _rewardsTxt:GradientText;
      
      private var _leftBtn:IconButton;
      
      private var _rightBtn:IconButton;
      
      private var _passSprite:Sprite;
      
      private var _stageSprite:Sprite;
      
      private var _mutiImg:MutipleImage;
      
      private var _rightImg:MutipleImage;
      
      private var _currentLevelTxt:GradientText;
      
      private var _highestLevelTxt:GradientText;
      
      private var _challengeBtn:IconButton;
      
      private var _challengeNumBg:Bitmap;
      
      private var _challengeNumTxt:FilterFrameText;
      
      private var _passVBox:VBox;
      
      private var _repeatVBox:VBox;
      
      private var _armorTxt:FilterFrameText;
      
      private var _skillTxt:FilterFrameText;
      
      private var _passTxt:FilterFrameText;
      
      private var _repeatTxt:FilterFrameText;
      
      private var _itemVBox:VBox;
      
      private var _spanel:ScrollPanel;
      
      private var _levelList:Vector.<WarSoulTowerLevelItem>;
      
      private var _helpBtn:BaseButton;
      
      public function WarSoulTowerFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         WarSoulTowerManager.instance.sendOpen();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,717);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("warSoulTowerFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerFrame.bg");
         _leftBorder = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.leftBorder");
         _rewardsBg = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerFrame.rewardsBg");
         _rewardsTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.rewardsTxt");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.leftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.rightBtn");
         _passSprite = new Sprite();
         _stageSprite = new Sprite();
         _mutiImg = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.mutiImg");
         _rightImg = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.rightImg");
         _currentLevelTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.currentLevelTxt");
         _highestLevelTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.highestLevelTxt");
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.challengeBtn");
         _challengeNumBg = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerFrame.challengeNumBg");
         _challengeNumTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.challengeNumTxt");
         _passVBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerFrame.passVBox");
         _repeatVBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerFrame.repeatVBox");
         _armorTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.armorTxt");
         _skillTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.skillTxt");
         _passTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.passTxt");
         _repeatTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.repeatTxt");
         _itemVBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerFrame.itemVBox");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.spanel");
         _levelList = new Vector.<WarSoulTowerLevelItem>();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.helpBtn");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_leftBorder);
         addToContent(_rewardsBg);
         addToContent(_rewardsTxt);
         addToContent(_leftBtn);
         addToContent(_rightBtn);
         addToContent(_passSprite);
         addToContent(_stageSprite);
         addToContent(_rightImg);
         addToContent(_currentLevelTxt);
         addToContent(_highestLevelTxt);
         addToContent(_challengeBtn);
         addToContent(_challengeNumBg);
         addToContent(_challengeNumTxt);
         addToContent(_armorTxt);
         addToContent(_skillTxt);
         addToContent(_helpBtn);
         _passSprite.addChild(_mutiImg);
         _passSprite.addChild(_passVBox);
         _passSprite.addChild(_repeatVBox);
         _passSprite.addChild(_passTxt);
         _passSprite.addChild(_repeatTxt);
         _stageSprite.addChild(_spanel);
         _spanel.setView(_itemVBox);
         _passTxt.text = LanguageMgr.GetTranslation("warSoulTowerFrame.passTxt.text");
         _repeatTxt.text = LanguageMgr.GetTranslation("warSoulTowerFrame.repeatTxt.text");
         __leftBtnClickHandler(null);
         initLevelItem();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _leftBtn.addEventListener("click",__leftBtnClickHandler);
         _rightBtn.addEventListener("click",__rightBtnClickHandler);
         MsgMan.addObserver("WARSOULTOWER_UPDATE",this,__updateWarSoulTowerHandler);
         _challengeBtn.addEventListener("click",__challengeBtnClickHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _leftBtn.removeEventListener("click",__leftBtnClickHandler);
         _rightBtn.removeEventListener("click",__rightBtnClickHandler);
         MsgMan.removeObserver("WARSOULTOWER_UPDATE",this,__updateWarSoulTowerHandler);
         _challengeBtn.removeEventListener("click",__challengeBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __updateWarSoulTowerHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __challengeBtnClickHandler(param1:MouseEvent) : void
      {
         WarSoulTowerManager.instance.sendBattle();
      }
      
      private function __leftBtnClickHandler(param1:MouseEvent) : void
      {
         _rewardsTxt.text = LanguageMgr.GetTranslation("warSoulTowerFrame.rewardsTxt.text1");
         _leftBtn.enable = false;
         _rightBtn.enable = true;
         _passSprite.visible = true;
         _stageSprite.visible = false;
      }
      
      private function __rightBtnClickHandler(param1:MouseEvent) : void
      {
         _rewardsTxt.text = LanguageMgr.GetTranslation("warSoulTowerFrame.rewardsTxt.text2");
         _leftBtn.enable = true;
         _rightBtn.enable = false;
         _passSprite.visible = false;
         _stageSprite.visible = true;
      }
      
      private function initStageItem() : void
      {
         var _loc2_:WarSoulTowerStageItem = null;
         var _loc4_:WarSoulTowerStageTempInfo = null;
         var _loc3_:int = 0;
         _itemVBox.removeAllChild();
         _itemVBox.beginChanges();
         var _loc1_:Array = TempleteManager.instance.warSoulTowerStageTempCate.getInfoArr();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc2_ = new WarSoulTowerStageItem();
            _loc2_.data = _loc4_;
            _itemVBox.addChild(_loc2_);
            _loc3_++;
         }
         _itemVBox.commitChanges();
         _spanel.invalidateViewport();
      }
      
      private function initLevelItem() : void
      {
         var _loc1_:WarSoulTowerLevelItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 15)
         {
            _loc1_ = new WarSoulTowerLevelItem();
            _loc1_.x = 295 + 85 * (_loc2_ % 5);
            _loc1_.y = 460 - 180 * (int(_loc2_ / 5)) - 20 * (_loc2_ % 5);
            addToContent(_loc1_);
            _levelList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshLevelItem() : void
      {
         var _loc1_:WarSoulTowerLevelItem = null;
         var _loc2_:WarSoulTowerLevelTempInfo = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 15)
         {
            _loc1_ = _levelList[_loc3_];
            _loc2_ = TempleteManager.instance.warSoulTowerLevelTempCate.getTempInfoByLevelId(model.beginLevel + _loc3_);
            _loc1_.data = _loc2_;
            _loc3_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:WarSoulTowerLevelTempInfo = null;
         var _loc2_:WarSoulTowerItem = null;
         var _loc6_:int = 0;
         var _loc1_:Array = null;
         var _loc7_:int = 0;
         var _loc4_:SkillTempInfo = null;
         _currentLevelTxt.text = model.currentLevel.toString();
         _highestLevelTxt.text = model.highestLevel.toString();
         _challengeNumTxt.text = LanguageMgr.GetTranslation("warSoulTowerFrame.challengeNumTxt.text",model.challengeTimes);
         _passVBox.removeAllChild();
         _repeatVBox.removeAllChild();
         _loc6_ = 5;
         while(_loc6_ >= 1)
         {
            _loc3_ = model.highestLevel + _loc6_;
            _loc5_ = TempleteManager.instance.warSoulTowerLevelTempCate.getTempInfoByLevelId(_loc3_);
            if(_loc5_)
            {
               _loc2_ = new WarSoulTowerItem(1);
               _loc2_.data = _loc5_;
               _passVBox.addChild(_loc2_);
            }
            _loc6_--;
         }
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc3_ = model.highestLevel - _loc6_;
            _loc5_ = TempleteManager.instance.warSoulTowerLevelTempCate.getTempInfoByLevelId(_loc3_);
            if(_loc5_)
            {
               _loc2_ = new WarSoulTowerItem(2);
               _loc2_.data = _loc5_;
               _repeatVBox.addChild(_loc2_);
            }
            _loc6_++;
         }
         _passTxt.visible = _passVBox.numChildren == 0;
         _repeatTxt.visible = _repeatVBox.numChildren == 0;
         initStageItem();
         refreshLevelItem();
         _skillTxt.text = "";
         _loc5_ = TempleteManager.instance.warSoulTowerLevelTempCate.getTempInfoByLevelId(model.currentLevel);
         if(_loc5_)
         {
            _armorTxt.text = _loc5_.NeedArmourValue.toString();
            _loc1_ = _loc5_.BossSkill.split(",");
            _loc7_ = 0;
            while(_loc7_ < _loc1_.length)
            {
               _loc4_ = TempleteManager.instance.skillTemplateDic[_loc1_[_loc7_]];
               if(_loc4_)
               {
                  _skillTxt.text += _loc4_.Description + "\n";
               }
               _loc7_++;
            }
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
      
      private function get model() : WarSoulTowerModel
      {
         return WarSoulTowerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftBorder);
         _leftBorder = null;
         ObjectUtils.disposeObject(_rewardsBg);
         _rewardsBg = null;
         ObjectUtils.disposeObject(_rewardsTxt);
         _rewardsTxt = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeObject(_mutiImg);
         _mutiImg = null;
         ObjectUtils.disposeObject(_rightImg);
         _rightImg = null;
         ObjectUtils.disposeObject(_currentLevelTxt);
         _currentLevelTxt = null;
         ObjectUtils.disposeObject(_highestLevelTxt);
         _highestLevelTxt = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_challengeNumBg);
         _challengeNumBg = null;
         ObjectUtils.disposeObject(_challengeNumTxt);
         _challengeNumTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_skillTxt);
         _skillTxt = null;
         ObjectUtils.disposeObject(_passTxt);
         _passTxt = null;
         ObjectUtils.disposeObject(_repeatTxt);
         _repeatTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(_passVBox);
         _passVBox = null;
         ObjectUtils.disposeAllChildren(_repeatVBox);
         _repeatVBox = null;
         ObjectUtils.disposeAllChildren(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

