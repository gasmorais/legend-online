package forbiddenboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.manager.ForbiddenBossManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.PathManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ForbiddenBossFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _btn1:SelectedIconButton;
      
      private var _btn2:SelectedIconButton;
      
      private var _btn3:SelectedIconButton;
      
      private var _btn4:SelectedIconButton;
      
      private var _btn5:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _bg:ScaleFrameImage;
      
      private var _bossTxt:GradientText;
      
      private var _armorTxt:FilterFrameText;
      
      private var _armorNumTxt:FilterFrameText;
      
      private var _rewardsBtn:IconButton;
      
      private var _recordBtn:IconButton;
      
      private var _serverTxt:FilterFrameText;
      
      private var _siteTxt:FilterFrameText;
      
      private var _ascriptionTxt:FilterFrameText;
      
      private var _partakeTxt:FilterFrameText;
      
      private var _ascriptionNumTxt:FilterFrameText;
      
      private var _partakeNumTxt:FilterFrameText;
      
      private var _enterBtn:IconButton;
      
      private var _bossSpanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _ascriptionSpanel:ScrollPanel;
      
      private var _ascriptionHBox:HBox;
      
      private var _partakeSpanel:ScrollPanel;
      
      private var _partakeHBox:HBox;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _mc:MovieClip;
      
      private var _swfContainer:Sprite;
      
      private var _isLoading:Boolean = false;
      
      private var _selectedBossId:int = 0;
      
      private var _lock2:Image;
      
      private var _lock3:Image;
      
      private var _lock4:Image;
      
      private var _lock5:Image;
      
      private var _helpBtn:BaseButton;
      
      private var _red:Bitmap;
      
      private var _belongMaxTxt:FilterFrameText;
      
      private var _joinMaxTxt:FilterFrameText;
      
      public function ForbiddenBossFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         ForbiddenBossManager.instance.sendOpen();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,950,665);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("forbiddenBossFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.border");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.btn2");
         _btn3 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.btn3");
         _btn4 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.btn4");
         _btn5 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.btn5");
         _bg = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.bg");
         _bossTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.bossTxt");
         _armorTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.armorTxt");
         _armorNumTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.armorNumTxt");
         _rewardsBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.rewardsBtn");
         _recordBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.recordBtn");
         _serverTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.serverTxt");
         _siteTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.siteTxt");
         _ascriptionTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.ascriptionTxt");
         _partakeTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.partakeTxt");
         _ascriptionNumTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.ascriptionNumTxt");
         _partakeNumTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.partakeNumTxt");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.enterBtn");
         _bossSpanel = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.bossSpanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("forbiddenBossFrame.vBox");
         _ascriptionSpanel = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.ascriptionSpanel");
         _ascriptionHBox = ComponentFactory.Instance.creatCustomObject("forbiddenBossFrame.ascriptionHBox");
         _partakeSpanel = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.partakeSpanel");
         _partakeHBox = ComponentFactory.Instance.creatCustomObject("forbiddenBossFrame.partakeHBox");
         _lock2 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.lock2");
         _lock3 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.lock3");
         _lock4 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.lock4");
         _lock5 = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.lock5");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.helpBtn");
         _red = ComponentFactory.Instance.creatBitmap("asset.ForbiddenBossFrame.red");
         _belongMaxTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.belongMaxTxt");
         _joinMaxTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.joinMaxTxt");
         _swfContainer = new Sprite();
         _swfContainer.x = 580;
         _swfContainer.y = 370;
         _swfContainer.mouseEnabled = false;
         addToContent(_border);
         addToContent(_bg);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_btn3);
         addToContent(_btn4);
         addToContent(_btn5);
         addToContent(_lock2);
         addToContent(_lock3);
         addToContent(_lock4);
         addToContent(_lock5);
         addToContent(_bossTxt);
         addToContent(_armorTxt);
         addToContent(_armorNumTxt);
         addToContent(_swfContainer);
         addToContent(_rewardsBtn);
         addToContent(_recordBtn);
         addToContent(_serverTxt);
         addToContent(_siteTxt);
         addToContent(_ascriptionTxt);
         addToContent(_partakeTxt);
         addToContent(_ascriptionNumTxt);
         addToContent(_partakeNumTxt);
         addToContent(_enterBtn);
         addToContent(_bossSpanel);
         addToContent(_ascriptionSpanel);
         addToContent(_partakeSpanel);
         addToContent(_helpBtn);
         addToContent(_red);
         addToContent(_belongMaxTxt);
         addToContent(_joinMaxTxt);
         _bossSpanel.setView(_vBox);
         _ascriptionSpanel.setView(_ascriptionHBox);
         _partakeSpanel.setView(_partakeHBox);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_btn1);
         _group.addSelectItem(_btn2);
         _group.addSelectItem(_btn3);
         _group.addSelectItem(_btn4);
         _group.addSelectItem(_btn5);
         _group.selectIndex = 0;
         _itemGroup = new SelectedButtonGroup();
         _armorTxt.text = LanguageMgr.GetTranslation("forbiddenBossFrame.armorTxt.text");
         _serverTxt.text = LanguageMgr.GetTranslation("forbiddenBossFrame.serverTxt.text");
         _ascriptionTxt.text = LanguageMgr.GetTranslation("forbiddenBossFrame.ascriptionTxt.text");
         _partakeTxt.text = LanguageMgr.GetTranslation("forbiddenBossFrame.partakeTxt.text");
         refreshLock();
      }
      
      private function refreshLock() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 2;
         while(_loc2_ <= 5)
         {
            _loc1_ = int(TempleteManager.instance.royaltyTempCate.getForbiddenLv(_loc2_));
            if(RoyaltyBossManager.instance.model.royaltyLevel < _loc1_)
            {
               this["_lock" + _loc2_].visible = true;
               this["_lock" + _loc2_].tipData = LanguageMgr.GetTranslation("poseidon.shop.openLv",_loc1_);
               (this["_btn" + _loc2_] as SelectedIconButton).mouseEnabled = false;
            }
            else
            {
               this["_lock" + _loc2_].visible = false;
               (this["_btn" + _loc2_] as SelectedIconButton).mouseEnabled = true;
            }
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__groupChangeHandler);
         _rewardsBtn.addEventListener("click",__rewardsBtnClickHandler);
         _recordBtn.addEventListener("click",__recordBtnClickHandler);
         _itemGroup.addEventListener("change",__itemGroupChangeHandler);
         MsgMan.addObserver("FORBIDDEN_BOSS_USER_UPDATE",this,__updateUserHandler);
         MsgMan.addObserver("FORBIDDEN_BOSS_LIST_UPDATE",this,__updateListHandler);
         _enterBtn.addEventListener("click",__enterBtnClickHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",__groupChangeHandler);
         _rewardsBtn.removeEventListener("click",__rewardsBtnClickHandler);
         _recordBtn.removeEventListener("click",__recordBtnClickHandler);
         _itemGroup.removeEventListener("change",__itemGroupChangeHandler);
         MsgMan.removeObserver("FORBIDDEN_BOSS_USER_UPDATE",this,__updateUserHandler);
         MsgMan.removeObserver("FORBIDDEN_BOSS_LIST_UPDATE",this,__updateListHandler);
         _enterBtn.removeEventListener("click",__enterBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossFrame.helperFrame");
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("ForbiddenBoss_Killhp");
         var _loc4_:int = _loc2_ ? Number(_loc2_.ConfigValue) / 100 : 0;
         var _loc5_:String = LanguageMgr.GetTranslation("forbiddenBossFrame.helperFrame.helpTxt.text",_loc4_);
         _loc3_.helpHtmlStr = _loc5_;
         _loc3_.commitChanges();
         _loc3_.show();
      }
      
      private function __enterBtnClickHandler(param1:MouseEvent) : void
      {
         ForbiddenBossManager.instance.sendEnter(_selectedBossId);
         model.SelectBoss = _selectedBossId;
      }
      
      private function refreshMc(param1:String) : void
      {
         clearLoading();
         ObjectUtils.disposeAllChildren(_swfContainer);
         var _loc2_:String = PathManager.getForbiddenBossPath(param1);
         LoaderManagerII.instance.load(_loc2_,2,4,onLoadCompleteHandler);
         _isLoading = true;
      }
      
      private function clearLoading() : void
      {
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadCompleteHandler);
            _isLoading = false;
         }
      }
      
      private function clearMC() : void
      {
         if(_mc != null)
         {
            if(_mc.parent != null)
            {
               _mc.parent.removeChild(_mc);
            }
            _mc.stop();
            _mc = null;
         }
      }
      
      private function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _isLoading = false;
         if(param2 is MovieClip)
         {
            clearMC();
            _mc = param2 as MovieClip;
            _mc.play();
            _mc.mouseEnabled = false;
            _mc.mouseChildren = false;
            _swfContainer.addChild(_mc);
         }
      }
      
      private function __updateUserHandler(param1:String, param2:Object) : void
      {
         refreshNum();
         refreshRed();
         _siteTxt.text = model.ConsortiaName;
      }
      
      private function __updateListHandler(param1:String, param2:Object) : void
      {
         _siteTxt.text = model.ConsortiaName;
      }
      
      private function refreshNum() : void
      {
         var _loc11_:int = 0;
         var _loc6_:SimpleDictionary = ConfigInfoManager.instance.getForbiddenBossBelongLimit();
         var _loc15_:int = int(_loc6_[index]);
         var _loc13_:int = 0;
         var _loc4_:Boolean = true;
         var _loc10_:int = 0;
         if(model.belongRewardDic[index])
         {
            _loc13_ = int(model.belongRewardDic[index]);
         }
         if(_loc15_ == -1)
         {
            _ascriptionNumTxt.visible = false;
         }
         else
         {
            _ascriptionNumTxt.visible = true;
            _loc10_ = _loc15_ - _loc13_;
            _ascriptionNumTxt.htmlText = LanguageMgr.GetTranslation("forbiddenBossFrame.ascriptionNumTxt.text",_loc10_);
            if(_loc10_ <= 0)
            {
               _loc4_ = false;
            }
         }
         _belongMaxTxt.visible = index > 1;
         var _loc14_:int = int(ConfigInfoManager.instance.getForbiddenBossBelongMax());
         var _loc5_:int = int(OldPlayerReturnManager.instance.model.forbiddenBossCount);
         var _loc12_:int = 0;
         if(model.belongRewardDic[-1])
         {
            _loc12_ = int(model.belongRewardDic[-1]);
         }
         var _loc9_:int = _loc14_ + _loc5_ - _loc12_;
         if(_loc9_ < 0)
         {
            _loc9_ = 0;
         }
         _belongMaxTxt.text = LanguageMgr.GetTranslation("ForbiddenBossFrame.belongMaxTxt.text",_loc9_);
         var _loc7_:SimpleDictionary = ConfigInfoManager.instance.getForbiddenBossJoinLimit();
         var _loc16_:int = int(_loc7_[index]);
         var _loc3_:int = 0;
         if(model.joinRewardDic[index])
         {
            _loc3_ = int(model.joinRewardDic[index]);
         }
         if(_loc16_ == -1)
         {
            _partakeNumTxt.visible = false;
         }
         else
         {
            _partakeNumTxt.visible = true;
            _loc11_ = _loc16_ - _loc3_;
            _partakeNumTxt.htmlText = LanguageMgr.GetTranslation("forbiddenBossFrame.partakeNumTxt.text",_loc11_);
            if(_loc11_ <= 0)
            {
               _loc4_ = false;
            }
         }
         _joinMaxTxt.visible = index > 1;
         var _loc8_:int = int(ConfigInfoManager.instance.getForbiddenBossJoinMax());
         var _loc1_:int = 0;
         if(model.joinRewardDic[-1])
         {
            _loc1_ = int(model.joinRewardDic[-1]);
         }
         var _loc2_:int = _loc8_ + _loc5_ - _loc1_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         _joinMaxTxt.text = LanguageMgr.GetTranslation("ForbiddenBossFrame.joinMaxTxt.text",_loc2_);
         if(index > 1)
         {
            _loc4_ = true;
            if(_loc10_ == 0 || _loc9_ == 0)
            {
               _loc4_ = false;
            }
         }
         else
         {
            _loc4_ = true;
            if(_loc10_ == 0)
            {
               _loc4_ = false;
            }
         }
         _enterBtn.enable = _loc4_;
      }
      
      private function refreshRed() : void
      {
         for each(var _loc1_:int in model.firstRewardDic)
         {
            if(_loc1_ == 1)
            {
               _red.visible = true;
               return;
            }
         }
         _red.visible = false;
      }
      
      private function __rewardsBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("forbiddenboss",2);
      }
      
      private function __recordBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("forbiddenboss",3,index);
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __itemGroupChangeHandler(param1:Event) : void
      {
         var _loc3_:ForbiddenBossTempInfo = null;
         var _loc2_:Array = TempleteManager.instance.forbiddenBossTempCate.getTempInfoByCategory(index);
         if(_loc2_ && _loc2_[_itemGroup.selectIndex])
         {
            _loc3_ = _loc2_[_itemGroup.selectIndex];
            if(_loc3_)
            {
               _selectedBossId = _loc3_.Id;
               _bossTxt.text = _loc3_.bossName;
               _armorNumTxt.text = _loc3_.BAV.toString();
               refreshRewads(_loc3_.bossTempId);
               refreshMc(_loc3_.MarkImage);
               _armorTxt.visible = _loc3_.BAV != 0;
               _armorNumTxt.visible = _loc3_.BAV != 0;
            }
         }
      }
      
      private function refreshView() : void
      {
         _bg.setFrame(index);
         var _loc1_:Array = TempleteManager.instance.forbiddenBossTempCate.getTempInfoByCategory(index);
         refreshItem(_loc1_);
         refreshNum();
         refreshRed();
      }
      
      private function get index() : int
      {
         return _group.selectIndex + 1;
      }
      
      private function refreshItem(param1:Array) : void
      {
         var _loc2_:ForbiddenBossItem = null;
         var _loc3_:int = 0;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         _itemGroup.removeAllItem();
         _itemGroup.selectIndex = -1;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new ForbiddenBossItem(_loc3_);
            _loc2_.data = param1[_loc3_];
            _itemGroup.addSelectItem(_loc2_);
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
         if(param1.length > 0)
         {
            _itemGroup.selectIndex = 0;
         }
         _vBox.commitChanges();
         _bossSpanel.invalidateViewport();
      }
      
      private function refreshRewads(param1:int) : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc7_:ForbiddenBossTempInfo = TempleteManager.instance.forbiddenBossTempCate.getTempInfoById(param1);
         var _loc2_:Array = _loc7_.RewardShow1.split("|");
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         _ascriptionHBox.removeAllChild();
         _ascriptionHBox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_].split(",");
            if(_loc4_ && _loc4_.length == 2)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc4_[0];
               _loc6_.count = _loc4_[1];
               _loc3_.data = _loc6_;
               _ascriptionHBox.addChild(_loc3_);
            }
            _loc5_++;
         }
         _ascriptionHBox.commitChanges();
         _ascriptionSpanel.invalidateViewport();
         _loc2_ = _loc7_.RewardShow2.split("|");
         _partakeHBox.removeAllChild();
         _partakeHBox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_].split(",");
            if(_loc4_ && _loc4_.length == 2)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc4_[0];
               _loc6_.count = _loc4_[1];
               _loc3_.data = _loc6_;
               _partakeHBox.addChild(_loc3_);
            }
            _loc5_++;
         }
         _partakeHBox.commitChanges();
         _partakeSpanel.invalidateViewport();
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
      
      private function get model() : ForbiddenBossModel
      {
         return ForbiddenBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btn1);
         _btn1 = null;
         ObjectUtils.disposeObject(_btn2);
         _btn2 = null;
         ObjectUtils.disposeObject(_btn3);
         _btn3 = null;
         ObjectUtils.disposeObject(_btn4);
         _btn4 = null;
         ObjectUtils.disposeObject(_lock2);
         _lock2 = null;
         ObjectUtils.disposeObject(_lock3);
         _lock3 = null;
         ObjectUtils.disposeObject(_lock4);
         _lock4 = null;
         ObjectUtils.disposeObject(_bossTxt);
         _bossTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_armorNumTxt);
         _armorNumTxt = null;
         ObjectUtils.disposeObject(_swfContainer);
         _swfContainer = null;
         ObjectUtils.disposeObject(_rewardsBtn);
         _rewardsBtn = null;
         ObjectUtils.disposeObject(_recordBtn);
         _recordBtn = null;
         ObjectUtils.disposeObject(_serverTxt);
         _serverTxt = null;
         ObjectUtils.disposeObject(_siteTxt);
         _siteTxt = null;
         ObjectUtils.disposeObject(_ascriptionTxt);
         _ascriptionTxt = null;
         ObjectUtils.disposeObject(_partakeTxt);
         _partakeTxt = null;
         ObjectUtils.disposeObject(_ascriptionNumTxt);
         _ascriptionNumTxt = null;
         ObjectUtils.disposeObject(_partakeNumTxt);
         _partakeNumTxt = null;
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
         ObjectUtils.disposeObject(_bossSpanel);
         _bossSpanel = null;
         ObjectUtils.disposeObject(_ascriptionSpanel);
         _ascriptionSpanel = null;
         ObjectUtils.disposeObject(_partakeSpanel);
         _partakeSpanel = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_red);
         _red = null;
         ObjectUtils.disposeObject(_belongMaxTxt);
         _belongMaxTxt = null;
         ObjectUtils.disposeObject(_joinMaxTxt);
         _joinMaxTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_ascriptionHBox);
         _ascriptionHBox = null;
         ObjectUtils.disposeObject(_partakeHBox);
         _partakeHBox = null;
         ObjectUtils.disposeObject(_partakeSpanel);
         _partakeSpanel = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

