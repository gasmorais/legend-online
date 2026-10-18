package playerinfo.view
{
   import avatar.view.ShowAvatar;
   import bag.events.BagEvent;
   import cell.view.playerequip.HonorCell;
   import cell.view.playerequip.PlayerEquipCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import marry.view.MarryRingView;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class EquipInfoView extends Sprite implements Disposeable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _figure:ShowAvatar;
      
      private var _equipGirdBack:MovieClip;
      
      private var _fashionGirdBack:MovieClip;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _equipViewList:SimpleDictionary;
      
      private var _equipList:Vector.<PlayerEquipCell>;
      
      private var _fashionList:Vector.<PlayerEquipCell>;
      
      private var _equip:Sprite;
      
      private var _fashion:Sprite;
      
      private var _fashionBtn:IconButton;
      
      private var _equipBtn:IconButton;
      
      private var _attributeButton:BaseButton;
      
      private var _weapon:PlayerEquipCell;
      
      private var _headdress:PlayerEquipCell;
      
      private var _clothes:PlayerEquipCell;
      
      private var _necklace:PlayerEquipCell;
      
      private var _ring1:PlayerEquipCell;
      
      private var _ring2:PlayerEquipCell;
      
      private var _trinket1:PlayerEquipCell;
      
      private var _trinket2:PlayerEquipCell;
      
      private var _relic:PlayerEquipCell;
      
      private var _heraldry:PlayerEquipCell;
      
      private var _wing:PlayerEquipCell;
      
      private var _weaponFashion:PlayerEquipCell;
      
      private var _headdressFshion:PlayerEquipCell;
      
      private var _clothesFashion:PlayerEquipCell;
      
      private var _honerViewList:SimpleDictionary;
      
      private var _honerList:Vector.<HonorCell>;
      
      private var _honor1:HonorCell;
      
      private var _marryRing:MarryRingView;
      
      private var _jewelSuitBtn:ScaleFrameImage;
      
      private var _starSuitBtn:Image;
      
      private var _starSuitLevel:FilterFrameText;
      
      private var _thane:ThaneInfo;
      
      private var _equipDic:SimpleDictionary;
      
      private var _vipIconBtn:BaseButton;
      
      private var _NovipIconBtn:BaseButton;
      
      private var _fightBg:MovieClip;
      
      private var _fightText:Bitmap;
      
      private var _hGap:Bitmap;
      
      private var _fightValue:Sprite;
      
      private var _fightBmp:Bitmap;
      
      private var _jobChangeBtn:ScaleFrameImage;
      
      private var _fashionIdentityTip:Image;
      
      private var _fashionProgressBar:MovieClip;
      
      private var _fashionProgressTxt:FilterFrameText;
      
      private var _fashionLvlBmp:Bitmap;
      
      private var _fashionLvlTxt:FilterFrameText;
      
      private var _isCross:Boolean;
      
      private var _fightList:Array;
      
      private var _hBox:HBox;
      
      private var _checkEquipListView:EquipCheckList;
      
      public function EquipInfoView()
      {
         super();
         initView();
         initEvent();
         this.mouseEnabled = false;
      }
      
      public function get isCross() : Boolean
      {
         return _isCross;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         _isCross = param1;
         _attributeButton.visible = !_isCross;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerFigureBack");
         _fashionGirdBack = ComponentFactory.Instance.creatCustomObject("army.FashionGird");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerThaneLevelTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerEquipNameTxt");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerEquipConsortiaTxt");
         _vipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.vipIconBtn");
         _NovipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.NovipIconBtn");
         _fashionBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionBtn2");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("army.equipBtn");
         _attributeButton = ComponentFactory.Instance.creatComponentByStylename("army.AttributeButton");
         _fightBg = ComponentFactory.Instance.creatCustomObject("army.FightBg");
         _fightText = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightTxt");
         _hGap = ComponentFactory.Instance.creatBitmap("asset.playerinfo.hGapLine");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightNum");
         _fashionIdentityTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionIdentityTipImage");
         _fashionIdentityTip.tipData = LanguageMgr.GetTranslation("fashion.tip.total",0,0,0,0);
         _fashionProgressBar = ComponentFactory.Instance.creatCustomObject("playerinfo.ProgressBar");
         _fashionProgressTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ProgressLevelTxt");
         _fashionLvlBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.lvlBmp");
         _fashionLvlTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.fashionLevelTxt");
         _jobChangeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.JobChangeBtn");
         if(VersionSwitch.GOD_HALIDOM)
         {
            _equipGirdBack = ComponentFactory.Instance.creatCustomObject("playerinfo.EquipGird");
         }
         else
         {
            _equipGirdBack = ComponentFactory.Instance.creatCustomObject("playerinfo.EquipGird2");
         }
         _figure = new ShowAvatar(true);
         _figure.x = 60;
         _figure.y = 40;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _vocationIcon.visible = false;
         addChild(_back);
         addChild(_figure);
         _equip = new Sprite();
         _fashion = new Sprite();
         _fightValue = new Sprite();
         _fightValue.x = 163;
         _fightValue.y = 376;
         addChild(_equip);
         addChild(_fashion);
         _fashion.visible = false;
         _equip.addChild(_equipGirdBack);
         _equip.addChild(_vipIconBtn);
         _equip.addChild(_NovipIconBtn);
         _equip.addChild(_vocationIcon);
         _equip.addChild(_levelTxt);
         _equip.addChild(_nameTxt);
         _equip.addChild(_consortiaTxt);
         _fashion.addChild(_fashionGirdBack);
         _fashion.addChild(_equipBtn);
         addChild(_fightBg);
         addChild(_fightText);
         addChild(_hGap);
         _hGap.width = 371;
         _hGap.x = 3;
         _hGap.y = 349;
         addChild(_attributeButton);
         addChild(_fightValue);
         addChild(_jobChangeBtn);
         _jobChangeBtn.setFrame(1);
         _equipViewList = new SimpleDictionary(true);
         _equipList = new Vector.<PlayerEquipCell>();
         _fashionList = new Vector.<PlayerEquipCell>();
         _weapon = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWeaponCell");
         _weapon.sonType = 101;
         _headdress = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroHeaddressCell");
         _headdress.sonType = 103;
         _clothes = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroClothesCell");
         _clothes.sonType = 104;
         _necklace = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroNecklaceCell");
         _necklace.sonType = 106;
         _ring1 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroRing1Cell");
         _ring1.sonType = 107;
         _ring2 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroRing2Cell");
         _ring2.sonType = 107;
         _trinket1 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroTrinket1Cell");
         _trinket1.sonType = 108;
         _trinket2 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroTrinket2Cell");
         _trinket2.sonType = 108;
         _relic = ComponentFactory.Instance.creatCustomObject("playerinfo.HerorelicCell");
         _relic.sonType = 118;
         _heraldry = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroheraldryCell");
         _heraldry.sonType = 117;
         _headdressFshion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroHeaddressFashionCell");
         _headdressFshion.sonType = 110;
         _clothesFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroClothesFashionCell");
         _clothesFashion.sonType = 112;
         _weaponFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWeaponFashionCell");
         _weaponFashion.sonType = 111;
         _wing = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWingCell");
         _wing.sonType = 109;
         _equipList.push(_weapon);
         _equipList.push(_headdress);
         _equipList.push(_clothes);
         _equipList.push(_necklace);
         _equipList.push(_ring1);
         _equipList.push(_ring2);
         _equipList.push(_trinket1);
         _equipList.push(_trinket2);
         if(VersionSwitch.GOD_HALIDOM)
         {
            _equipList.push(_relic);
            _equipList.push(_heraldry);
         }
         _fashionList.push(_headdressFshion);
         _fashionList.push(_clothesFashion);
         _fashionList.push(_weaponFashion);
         _fashionList.push(_wing);
         _fashionList.push(_wing);
         for each(var _loc2_:PlayerEquipCell in _equipList)
         {
            _loc2_.acceptDrop = false;
            _equip.addChild(_loc2_);
         }
         for each(var _loc1_:PlayerEquipCell in _fashionList)
         {
            _loc1_.acceptDrop = false;
            _fashion.addChild(_loc1_);
         }
         _honerViewList = new SimpleDictionary(true);
         _honerList = new Vector.<HonorCell>();
         _honor1 = ComponentFactory.Instance.creatCustomObject("playerinfo.HonorCell1");
         _honor1.acceptDrop = false;
         _equip.addChild(_honor1);
         _honerList.push(_honor1);
         if(!VersionSwitch.GOD_HALIDOM)
         {
            _honor1.x = 15;
         }
         _jewelSuitBtn = ComponentFactory.Instance.creatComponentByStylename("playerinfo.JewelSuitBtn");
         _starSuitBtn = ComponentFactory.Instance.creatComponentByStylename("playerinfo.StarSuitBtn");
         _starSuitLevel = ComponentFactory.Instance.creatComponentByStylename("playerinfo.StarSuitLevel");
         _jewelSuitBtn.filters = [UIFilter.getGrayFilter()];
         _starSuitBtn.filters = [UIFilter.getGrayFilter()];
         _fashion.addChild(_fashionIdentityTip);
         _fashion.addChild(_fashionProgressBar);
         _fashion.addChild(_fashionProgressTxt);
         _fashion.addChild(_fashionLvlBmp);
         _fashion.addChild(_fashionLvlTxt);
         _equip.addChild(_fashionBtn);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("EquipInfoView.HBox");
         addChild(_hBox);
      }
      
      public function get equip() : Sprite
      {
         if(!_equip)
         {
            _equip = new Sprite();
         }
         return _equip;
      }
      
      private function initEvent() : void
      {
         _vipIconBtn.addEventListener("click",__openVipHandler);
         _NovipIconBtn.addEventListener("click",__openVipHandler);
         if(_fashionBtn)
         {
            _fashionBtn.addEventListener("click",__fashionHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.addEventListener("mouseDown",__fashionDownHandler);
         }
         if(_equipBtn)
         {
            _equipBtn.addEventListener("click",__equipHandler);
         }
         if(_attributeButton)
         {
            _attributeButton.addEventListener("click",__attributeHandler);
         }
         NotificationManager.instance.addEventListener("CHECKPLAYERITEMCLICK",__itemClickhandler);
      }
      
      private function removeEvent() : void
      {
         _vipIconBtn.removeEventListener("click",__openVipHandler);
         _NovipIconBtn.removeEventListener("click",__openVipHandler);
         if(_fashionBtn)
         {
            _fashionBtn.removeEventListener("click",__fashionHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.removeEventListener("mouseDown",__fashionDownHandler);
         }
         if(_equipBtn)
         {
            _equipBtn.removeEventListener("click",__equipHandler);
         }
         if(_attributeButton)
         {
            _attributeButton.removeEventListener("click",__attributeHandler);
         }
         NotificationManager.instance.removeEventListener("CHECKPLAYERITEMCLICK",__itemClickhandler);
      }
      
      private function __itemClickhandler(param1:NotificationEvent) : void
      {
         var _loc2_:* = param1.data;
         if(0 === _loc2_)
         {
            _equip.visible = false;
            _fashion.visible = true;
         }
      }
      
      private function __attributeHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new BagEvent("ATTRIBUTE_CLICK",null));
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      protected function __equipHandler(param1:MouseEvent) : void
      {
         _equip.visible = true;
         _fashion.visible = false;
      }
      
      private function __fashionDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      protected function __fashionHandler(param1:MouseEvent) : void
      {
         if(_checkEquipListView)
         {
            _checkEquipListView.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_checkEquipListView)
         {
            _checkEquipListView = ComponentFactory.Instance.creatCustomObject("playerinfo.equipCheckList",[_thane,isCross,_equipDic,_fightList]);
         }
         _checkEquipListView.addEventListener("dispose",__onSortListDispose);
         var _loc2_:Point = new Point(_fashionBtn.x,_fashionBtn.y);
         _checkEquipListView.x = localToGlobal(_loc2_).x - 23;
         _checkEquipListView.y = localToGlobal(_loc2_).y - 300;
         LayerManager.Instance.addToLayer(_checkEquipListView,7);
      }
      
      private function __onSortListDispose(param1:Event) : void
      {
         _checkEquipListView.removeEventListener("dispose",__onSortListDispose);
         _checkEquipListView = null;
      }
      
      public function initData(param1:ThaneInfo, param2:SimpleDictionary, param3:Boolean = false, param4:Array = null) : void
      {
         _thane = param1;
         _equipDic = new SimpleDictionary(true);
         _equipDic.setDictionary(param2);
         _isCross = param3;
         _fightList = param4;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:String = null;
         var _loc12_:String = null;
         var _loc1_:Array = null;
         var _loc7_:int = 0;
         var _loc11_:Array = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:SkillTempInfo = null;
         var _loc5_:String = null;
         var _loc9_:String = null;
         var _loc2_:String = null;
         if(_thane)
         {
            _loc3_ = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName1");
            _loc3_ = _thane.consortiaName ? _loc3_ + _thane.consortiaName : "";
            _levelTxt.text = LanguageMgr.GetTranslation("public.level2",_thane.grades);
            _nameTxt.text = _thane.nickName;
            _consortiaTxt.text = _loc3_;
            setLevelAndNamePos(_thane);
            NumberViewUtils.getNumberView(_thane.fightingCapacity,_fightValue,_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
            _fightText.x = (296 - _fightValue.width) / 2 + 12;
            _fightValue.x = _fightText.x + 85 - 5;
         }
         if(_thane.grades >= 35)
         {
            _jewelSuitBtn.tipData = _thane;
            if(_thane.jewelGrades >= 80 && _thane.vocationLevel > 0)
            {
               _jewelSuitBtn.setFrame(2);
               _jewelSuitBtn.filters = null;
            }
            else
            {
               _jewelSuitBtn.setFrame(1);
               _jewelSuitBtn.filters = null;
            }
         }
         var _loc10_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         if(_thane.grades >= 55)
         {
            _loc12_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FateTip1",_thane.fateTotalGp * 10);
            _loc10_.addItem(_loc12_,null);
            if(_thane.fateGrades)
            {
               _loc1_ = _thane.fateGrades.split("|");
            }
            else
            {
               _loc1_ = [];
            }
            _loc7_ = 0;
            while(_loc7_ < _loc1_.length)
            {
               _loc11_ = _loc1_[_loc7_].split(",");
               if(_loc11_.length >= 2)
               {
                  _loc8_ = int(_loc11_[0]);
                  _loc6_ = int(_loc11_[1]);
                  _loc4_ = TempleteManager.instance.getSkillTemplateInfoById(_loc8_);
                  _loc12_ = LanguageMgr.GetTranslation("public.grade") + "  " + _loc6_;
                  _loc5_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip","  " + _loc4_.TemplateName);
                  _loc9_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip",_loc12_);
                  _loc10_.addItem(_loc5_ + "       " + _loc9_,null);
               }
               _loc7_++;
            }
         }
         else
         {
            _loc2_ = "<font size=\'14\' color=\'ffffff\'>" + LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FrameTitle1") + "</font>";
            _loc10_.addItem(_loc2_,null);
            _loc2_ = "<font size=\'14\' color=\'ffffff\'>" + LanguageMgr.GetTranslation("playerinfo.view.EquipInfoView.WillOpenAt",55) + "</font>";
            _loc10_.addItem(_loc2_,null);
         }
         if(_isCross)
         {
            _jewelSuitBtn.tipData = null;
            _jewelSuitBtn.filters = [UIFilter.getGrayFilter()];
         }
         refreshVocation();
         refreshJobChangeBtn();
         refreshFashionTip();
         refreshHeroFigure();
         refreshHeroEquip();
         refreshHeroVIP();
      }
      
      private function refreshJobChangeBtn() : void
      {
         if(_thane.isOpenDragonTalker && Boolean(_thane.dragonTalkerInfo.isDragonTalker))
         {
            _jobChangeBtn.setFrame(4);
         }
         else
         {
            _jobChangeBtn.setFrame(_thane.templateInfo.Job);
         }
      }
      
      private function refreshFashionTip() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(_fashionIdentityTip && _thane)
         {
            _loc1_ = [_thane.baseProperty.fashionPower,_thane.baseProperty.fashionAgility,_thane.baseProperty.fashionIntellect,_thane.baseProperty.fashionPhysigue];
            _loc2_ = LanguageMgr.GetTranslation("fashion.tip.total2");
            _loc3_ = int(_loc1_.length);
            _loc4_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ += "\n" + LanguageMgr.GetTranslation("fashion.tip.total0" + (_loc5_ + 1),_loc1_[_loc5_],_loc4_);
               _loc5_ += 1;
            }
            _fashionIdentityTip.tipData = _loc2_;
         }
      }
      
      private function setLevelAndNamePos(param1:ThaneInfo) : void
      {
         if(param1.consortiaName)
         {
            _levelTxt.y = 12;
            _nameTxt.y = 12;
         }
         else
         {
            _levelTxt.y = 9;
            _nameTxt.y = 9;
         }
      }
      
      private function refreshVocation() : void
      {
         if(_thane && _thane.vocationLevel > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_thane.templateInfo.Job,_thane.vocationStep,_thane.vocationLevel);
            _vocationIcon.setFrame(_thane.vocationLevel);
            _vocationIcon.visible = true;
            _levelTxt.x = 45;
            _nameTxt.x = 85;
         }
         else
         {
            _vocationIcon.visible = false;
            _levelTxt.x = 9;
            _nameTxt.x = 50;
         }
      }
      
      private function refreshHeroFigure() : void
      {
         if(_thane)
         {
            if(_thane.vocationLevel > 0)
            {
               _back.setFrame(_thane.templateInfo.Job + 3);
            }
            else
            {
               _back.setFrame(_thane.templateInfo.Job);
            }
         }
         _figure.data = _thane;
      }
      
      private function refreshHeroEquip() : void
      {
         var _loc6_:BaseItemView = null;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         if(!_thane)
         {
            return;
         }
         _equipViewList.clear();
         for each(var _loc2_:PlayerEquipCell in _equipList)
         {
            _loc2_.data = null;
            _loc2_.bagType = 4;
            _loc2_.objectId = _thane.id;
            _equipViewList.add(_loc2_.pos + "_" + _thane.id + "_" + _loc2_.bagType,_loc2_);
         }
         for each(var _loc1_:PlayerEquipCell in _fashionList)
         {
            _loc1_.data = null;
            _loc1_.bagType = 4;
            _loc1_.objectId = _thane.id;
            _equipViewList.add(_loc1_.pos + "_" + _thane.id + "_" + _loc1_.bagType,_loc1_);
         }
         _honerViewList.clear();
         for each(var _loc7_:HonorCell in _honerList)
         {
            _loc7_.data = null;
            _loc7_.bagType = 3;
            _loc7_.objectId = _thane.id;
            _honerViewList.add(_loc7_.pos + "_" + _thane.id + "_" + _loc7_.bagType,_loc7_);
         }
         if(_equipDic)
         {
            for each(var _loc10_:Object in _equipDic)
            {
               if(_loc10_ is GoodsInfo)
               {
                  if((_loc10_ as GoodsInfo).bagType != 26)
                  {
                     _loc6_ = getItemViewByPos(_loc10_.pos,(_loc10_ as GoodsInfo).bagType);
                     if(_loc6_)
                     {
                        _loc6_.data = _loc10_ as GoodsInfo;
                     }
                  }
               }
            }
         }
         if(!StringHelper.isNullOrEmpty(_thane.nickNameB))
         {
            _marryRing = new MarryRingView(_thane);
            _marryRing.x = VersionSwitch.GOD_HALIDOM ? 180 : 70;
            _marryRing.y = 295;
            _equip.addChild(_marryRing);
         }
         var _loc3_:FashionInfoMsg = _thane.fashionMsg;
         _fashionLvlTxt.text = _loc3_.grades.toString();
         var _loc8_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.grades + 1,113);
         if(!_loc8_)
         {
            _fashionProgressTxt.text = "max";
            _loc4_ = 100;
         }
         else
         {
            _loc9_ = int(_loc3_.gp);
            _loc5_ = int(_loc8_.Data);
            _fashionProgressTxt.text = _loc9_ + "/" + _loc5_;
            _loc4_ = _loc9_ / _loc5_ * 100;
         }
         _fashionProgressBar.gotoAndStop(_loc4_);
      }
      
      private function refreshHeroVIP() : void
      {
         if(!_thane)
         {
            return;
         }
         if(!_thane.IsVipAndNoExpirt)
         {
            _vipIconBtn.visible = false;
            _NovipIconBtn.visible = true;
         }
         else
         {
            _vipIconBtn.visible = true;
            _NovipIconBtn.visible = false;
         }
      }
      
      public function getItemViewByPos(param1:int, param2:int = 4) : BaseItemView
      {
         if(!_thane)
         {
            return null;
         }
         var _loc3_:BaseItemView = _equipViewList[param1 + "_" + _thane.id + "_" + param2];
         if(!_loc3_)
         {
            _loc3_ = _honerViewList[param1 + "_" + _thane.id + "_" + param2];
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _thane = null;
         if(_equipDic)
         {
            _equipDic.clear();
         }
         _equipDic = null;
         _equipList = null;
         _equipViewList = null;
         _honerViewList = null;
         _honerList = null;
         _fashionList = null;
         ObjectUtils.disposeAllChildren(_fashion);
         _fashion = null;
         ObjectUtils.disposeAllChildren(_equip);
         _equip = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_equipGirdBack);
         _equipGirdBack = null;
         ObjectUtils.disposeObject(_fashionGirdBack);
         _fashionGirdBack = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_weapon);
         _weapon = null;
         ObjectUtils.disposeObject(_headdress);
         _headdress = null;
         ObjectUtils.disposeObject(_clothes);
         _clothes = null;
         ObjectUtils.disposeObject(_necklace);
         _necklace = null;
         ObjectUtils.disposeObject(_ring1);
         _ring1 = null;
         ObjectUtils.disposeObject(_ring2);
         _ring2 = null;
         ObjectUtils.disposeObject(_trinket1);
         _trinket1 = null;
         ObjectUtils.disposeObject(_trinket2);
         _trinket2 = null;
         ObjectUtils.disposeObject(_relic);
         _relic = null;
         ObjectUtils.disposeObject(_heraldry);
         _heraldry = null;
         ObjectUtils.disposeObject(_honor1);
         _honor1 = null;
         ObjectUtils.disposeObject(_jewelSuitBtn);
         _jewelSuitBtn = null;
         ObjectUtils.disposeObject(_starSuitBtn);
         _starSuitBtn = null;
         ObjectUtils.disposeObject(_starSuitLevel);
         _starSuitLevel = null;
         ObjectUtils.disposeObject(_wing);
         _wing = null;
         ObjectUtils.disposeObject(_weaponFashion);
         _weaponFashion = null;
         ObjectUtils.disposeObject(_headdressFshion);
         _headdressFshion = null;
         ObjectUtils.disposeObject(_clothesFashion);
         _clothesFashion = null;
         ObjectUtils.disposeObject(_fashionBtn);
         _fashionBtn = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_vipIconBtn);
         _vipIconBtn = null;
         ObjectUtils.disposeObject(_NovipIconBtn);
         _NovipIconBtn = null;
         ObjectUtils.disposeObject(_hGap);
         _hGap = null;
         ObjectUtils.disposeObject(_fightBg);
         _fightBg = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeObject(_attributeButton);
         _attributeButton = null;
         ObjectUtils.disposeObject(_marryRing);
         _marryRing = null;
         ObjectUtils.disposeObject(_jobChangeBtn);
         _jobChangeBtn = null;
         if(_checkEquipListView)
         {
            ObjectUtils.disposeObject(_checkEquipListView);
         }
         _checkEquipListView = null;
         _fightValue = null;
      }
      
      public function get hBox() : HBox
      {
         return _hBox;
      }
   }
}

