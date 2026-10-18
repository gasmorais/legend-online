package playerinfo.view
{
   import avatar.view.ShowAvatar;
   import bag.events.BagEvent;
   import cell.view.playerequip.HonorCell;
   import cell.view.playerequip.PlayerEquipCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import dragontalker.cell.DragonTalkerTalismanEquipCell;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import managers.VIPManager;
   import marry.view.MarryRingView;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.vip.VIPModel;
   import utils.LogicUtils;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.DragonTalkerFightMountTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.utils.ThaneEquipShowHelper;
   
   public class DragonTalkerEquipInfoView extends Component
   {
      
      private static const TALISMAN_COUNT:int = 6;
      
      private static var talismanPostions:Array = [[49,67],[23,135],[49,208],[255,67],[285,135],[255,208]];
      
      private var _figureBack:Image;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _consortiaText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _lvlText:FilterFrameText;
      
      private var _symbioteImage:Image;
      
      private var _battleBeastImage:Image;
      
      private var _talismanContiner:Component;
      
      private var _figure:ShowAvatar;
      
      private var _equipGirdBack:MovieClip;
      
      private var _fightBg:MovieClip;
      
      private var _fightText:Bitmap;
      
      private var _relic:PlayerEquipCell;
      
      private var _heraldry:PlayerEquipCell;
      
      private var _honor:HonorCell;
      
      private var _marryRing:MarryRingView;
      
      private var _vipIconBtn:BaseButton;
      
      private var _novipIconBtn:BaseButton;
      
      private var _fightBmp:Bitmap;
      
      private var _fightMc:MovieClip;
      
      private var _attributeButton:BaseButton;
      
      private var _jobChangeBtn:ScaleFrameImage;
      
      private var _preFightValue:int;
      
      private var _honerViewDic:SimpleDictionary;
      
      private var _equipViewDic:SimpleDictionary;
      
      private var _equipList:Vector.<PlayerEquipCell>;
      
      private var _headdressFshion:PlayerEquipCell;
      
      private var _clothesFashion:PlayerEquipCell;
      
      private var _wing:PlayerEquipCell;
      
      private var _weaponFashion:PlayerEquipCell;
      
      private var _talismanList:Vector.<DragonTalkerTalismanEquipCell>;
      
      private var _equipDataDic:SimpleDictionary;
      
      private var _curThaneInfo:ThaneInfo;
      
      private var _fashionBtn:IconButton;
      
      private var _returnBtn:IconButton;
      
      private var _equipSprite:Sprite;
      
      private var _fashionSprite:Sprite;
      
      private var _fashionGirdBack:MovieClip;
      
      private var _switchTip:TextButton;
      
      private var _fashionIdentityTip:BaseButton;
      
      private var _fashionProgressBar:MovieClip;
      
      private var _fashionProgressTxt:FilterFrameText;
      
      private var _fashionLvlBmp:Bitmap;
      
      private var _fashionLvlTxt:FilterFrameText;
      
      private var _fashionLvlStrip:StripView;
      
      private var _playFightMc:Boolean = false;
      
      public function DragonTalkerEquipInfoView()
      {
         super();
         initView();
         initTalismanView();
         initOtherEquipView();
         addEvent();
      }
      
      private function initView() : void
      {
         _figureBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.figureBack");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("army.ThaneLevelTxt");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("army.ThaneNameTxt");
         _consortiaText = ComponentFactory.Instance.creatComponentByStylename("army.ThaneConsortiaTxt");
         _symbioteImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipInfoView.symbioteImage");
         _battleBeastImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipInfoView.battleBeastImage");
         _talismanContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.talismanContiner");
         _vipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.vipIconBtn");
         _novipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.NovipIconBtn");
         _equipGirdBack = ComponentFactory.Instance.creatCustomObject("DragonTalkerEquipInfoView.EquipGird");
         _fightBg = ComponentFactory.Instance.creatCustomObject("army.FightBg");
         _fightText = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightTxt");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightNum");
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         _attributeButton = ComponentFactory.Instance.creatComponentByStylename("army.AttributeButton");
         _jobChangeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.JobChangeBtn");
         _fashionBtn = ComponentFactory.Instance.creatComponentByStylename("dragonTalkerEquipView.fashionBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("dragonTalkerEquipView.returnBtn");
         _headdressFshion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroHeaddressFashionCell");
         _clothesFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroClothesFashionCell");
         _weaponFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWeaponFashionCell");
         _wing = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWingCell");
         _figure = new ShowAvatar(true,null,false,true);
         _figure.x = 60;
         _figure.y = 40;
         _equipSprite = new Sprite();
         _fashionSprite = new Sprite();
         addChild(_figureBack);
         addChild(_figure);
         addChild(_fightBg);
         addChild(_fightText);
         addChild(_fightMc);
         _fightMc.x = 158;
         _fightMc.y = 376;
         addChild(_attributeButton);
         addChild(_jobChangeBtn);
         addChild(_equipSprite);
         addChild(_fashionSprite);
         _equipSprite.addChild(_vocationIcon);
         _equipSprite.addChild(_lvlText);
         _equipSprite.addChild(_nameText);
         _equipSprite.addChild(_consortiaText);
         _equipSprite.addChild(_vipIconBtn);
         _vipIconBtn.x = 319;
         _vipIconBtn.y = 28;
         _equipSprite.addChild(_novipIconBtn);
         _novipIconBtn.x = 319;
         _novipIconBtn.y = 28;
         _equipSprite.addChild(_symbioteImage);
         _equipSprite.addChild(_battleBeastImage);
         _equipSprite.addChild(_talismanContiner);
         _equipSprite.addChild(_equipGirdBack);
         if(VersionSwitch.DRAGONIC_FASHION)
         {
            _equipSprite.addChild(_fashionBtn);
         }
         _fashionGirdBack = ComponentFactory.Instance.creatCustomObject("army.FashionGird");
         _fashionIdentityTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionIdentityTip");
         _fashionIdentityTip.tipData = LanguageMgr.GetTranslation("fashion.tip.total",0,0,0,0);
         _fashionProgressBar = ComponentFactory.Instance.creatCustomObject("playerinfo.ProgressBar");
         _fashionProgressTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ProgressLevelTxt");
         _fashionLvlBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.lvlBmp");
         _fashionLvlTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.fashionLevelTxt");
         _switchTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitcTip");
         _fashionSprite.addChild(_fashionGirdBack);
         if(VersionSwitch.DRAGONIC_FASHION)
         {
            _fashionSprite.addChild(_returnBtn);
         }
         _fashionSprite.addChild(_fashionIdentityTip);
         _fashionSprite.addChild(_fashionProgressBar);
         _fashionSprite.addChild(_fashionProgressTxt);
         _fashionSprite.addChild(_fashionLvlBmp);
         _fashionSprite.addChild(_fashionLvlTxt);
         _fashionSprite.addChild(_headdressFshion);
         _fashionSprite.addChild(_clothesFashion);
         _fashionSprite.addChild(_wing);
         _fashionSprite.addChild(_weaponFashion);
         _fashionSprite.visible = false;
         _equipSprite.visible = true;
         this.mouseEnabled = false;
         _vocationIcon.visible = false;
         _figureBack.setFrame(2);
         _jobChangeBtn.setFrame(1);
      }
      
      private function initTalismanView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerTalismanEquipCell = null;
         _talismanList = new Vector.<DragonTalkerTalismanEquipCell>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerEquipView.equipCell",[_loc2_]);
            _talismanContiner.addChild(_loc1_);
            _loc1_.x = talismanPostions[_loc2_][0];
            _loc1_.y = talismanPostions[_loc2_][1];
            _talismanList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initOtherEquipView() : void
      {
         _honerViewDic = new SimpleDictionary(true);
         _equipViewDic = new SimpleDictionary(true);
         _equipList = new Vector.<PlayerEquipCell>();
         _relic = ComponentFactory.Instance.creatCustomObject("playerinfo.HerorelicCell");
         _heraldry = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroheraldryCell");
         _honor = ComponentFactory.Instance.creatCustomObject("playerinfo.HonorCell1");
         _relic.sonType = 118;
         _heraldry.sonType = 117;
         _relic.acceptDrop = false;
         _heraldry.acceptDrop = false;
         _honor.acceptDrop = false;
         if(!VersionSwitch.GOD_HALIDOM)
         {
            _honor.x = 15;
         }
         if(VersionSwitch.GOD_HALIDOM)
         {
            _equipSprite.addChild(_relic);
            _equipSprite.addChild(_heraldry);
            _equipList.push(_relic);
            _equipList.push(_heraldry);
         }
         _equipSprite.addChild(_honor);
      }
      
      private function addEvent() : void
      {
         _vipIconBtn.addEventListener("click",__openVipHandler);
         _novipIconBtn.addEventListener("click",__openVipHandler);
         if(_attributeButton)
         {
            _attributeButton.addEventListener("click",__attributeClickHandler);
         }
         if(_returnBtn)
         {
            _returnBtn.addEventListener("click",__returnBtnHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.addEventListener("click",__fashionBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         _vipIconBtn.removeEventListener("click",__openVipHandler);
         _novipIconBtn.removeEventListener("click",__openVipHandler);
         if(_attributeButton)
         {
            _attributeButton.removeEventListener("click",__attributeClickHandler);
         }
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",__returnBtnHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.removeEventListener("click",__fashionBtnHandler);
         }
      }
      
      private function __attributeClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new BagEvent("ATTRIBUTE_CLICK",null));
      }
      
      private function __returnBtnHandler(param1:MouseEvent) : void
      {
         _fashionSprite.visible = false;
         _equipSprite.visible = true;
      }
      
      private function __fashionBtnHandler(param1:MouseEvent) : void
      {
         _fashionSprite.visible = true;
         _equipSprite.visible = false;
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function refreshJobChangeBtn() : void
      {
         if(curThaneInfo.isOpenDragonTalker && Boolean(curThaneInfo.dragonTalkerInfo.isDragonTalker))
         {
            _jobChangeBtn.setFrame(4);
         }
         else
         {
            _jobChangeBtn.setFrame(curThaneInfo.templateInfo.Job);
         }
      }
      
      private function __upvipInfoHandler(param1:VIPEvent) : void
      {
         if(!curThaneInfo)
         {
            return;
         }
         if(!curThaneInfo.IsVipAndNoExpirt)
         {
            _vipIconBtn.visible = false;
            _novipIconBtn.visible = true;
         }
         else
         {
            _vipIconBtn.visible = true;
            _novipIconBtn.visible = false;
         }
      }
      
      public function get curThaneInfo() : ThaneInfo
      {
         return _curThaneInfo;
      }
      
      public function set curThaneInfo(param1:ThaneInfo) : void
      {
         _curThaneInfo = param1;
         refreshView();
      }
      
      public function initData(param1:ThaneInfo, param2:SimpleDictionary) : void
      {
         _equipDataDic = new SimpleDictionary(true);
         _equipDataDic.setDictionary(param2);
         curThaneInfo = param1;
      }
      
      protected function refreshView() : void
      {
         var _loc2_:String = null;
         var _loc1_:String = null;
         if(curThaneInfo.nickName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            _loc2_ = LanguageMgr.GetTranslation("public.nickName");
         }
         else
         {
            _loc2_ = curThaneInfo.nickName;
         }
         _loc1_ = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName");
         _loc1_ = curThaneInfo.consortiaName ? LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc1_,curThaneInfo.consortiaName) : "";
         _lvlText.text = LanguageMgr.GetTranslation("public.level2",curThaneInfo.grades);
         _nameText.text = _loc2_;
         _consortiaText.text = _loc1_;
         setLevelAndNamePos(curThaneInfo);
         setFightNumberView(curThaneInfo.fightingCapacity);
         refreshVocation();
         refreshHeroFigure();
         refreshJobChangeBtn();
         refreshTalismanView();
         refreshOtherEquipView();
         refreshDragonTalkerTips();
         refreshFashionTip();
         refreshHeroFigure();
         refreshFashionEquip();
         __upvipInfoHandler(null);
      }
      
      private function setFightNumberView(param1:int = 0) : void
      {
         if(_preFightValue == param1)
         {
            return;
         }
         _fightText.x = (296 - getNumWidth(param1)) / 2 + 15;
         _fightMc.x = _fightText.x + 70;
         if(!_playFightMc)
         {
            NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
            _fightMc.gotoAndStop(24);
            _preFightValue = param1;
            _playFightMc = true;
            return;
         }
         if(_preFightValue > 0)
         {
            NumberViewUtils.getNumberView(_preFightValue,_fightMc["old_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         }
         NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         _fightMc.gotoAndPlay(1);
         _preFightValue = param1;
      }
      
      private function getNumWidth(param1:int) : int
      {
         var _loc2_:String = null;
         _loc2_ = param1 + "";
         return _loc2_.length * 19;
      }
      
      private function setLevelAndNamePos(param1:ThaneInfo) : void
      {
         if(param1.consortiaName)
         {
            _lvlText.y = 12;
            _nameText.y = 12;
         }
         else
         {
            _lvlText.y = 9;
            _nameText.y = 9;
         }
      }
      
      private function refreshVocation() : void
      {
         if(curThaneInfo.vocationGrades > 0)
         {
            _vocationIcon.tipData = "<font color=\'#f6c503\' size=\'14\'>" + PlayerManager.instance.getVocationName(curThaneInfo.templateInfo.Job,curThaneInfo.vocationStep,curThaneInfo.vocationLevel) + "</font>";
            if(curThaneInfo.isHoly)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.holyTip");
            }
            else if(curThaneInfo.isAvenger)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.avengerTip");
            }
            else if(curThaneInfo.vocationIndex > 0)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.transferTip");
            }
            else
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.tip");
            }
            _vocationIcon.setFrame(curThaneInfo.vocationLevel);
            _vocationIcon.visible = true;
            _lvlText.x = 34;
            _nameText.x = 75;
         }
         else
         {
            _vocationIcon.visible = false;
            _lvlText.x = 9;
            _nameText.x = 50;
         }
      }
      
      private function refreshOtherEquipView() : void
      {
         var _loc1_:PlayerEquipCell = null;
         for each(var _loc2_:PlayerEquipCell in _equipList)
         {
            _loc2_.data = null;
            _loc2_.bagType = 4;
            _loc2_.objectId = curThaneInfo.id;
            _equipViewDic.add(_loc2_.pos + "_" + curThaneInfo.id + "_" + _loc2_.bagType,_loc2_);
         }
         if(_equipDataDic)
         {
            for each(var _loc3_:Object in _equipDataDic)
            {
               if(_loc3_ is GoodsInfo)
               {
                  if((_loc3_ as GoodsInfo).bagType != 26)
                  {
                     _loc1_ = getItemViewByPos(_loc3_.pos,(_loc3_ as GoodsInfo).bagType);
                     if(_loc1_)
                     {
                        _loc1_.data = _loc3_ as GoodsInfo;
                     }
                  }
               }
            }
         }
         if(!StringHelper.isNullOrEmpty(curThaneInfo.nickNameB))
         {
            if(!_marryRing)
            {
               _marryRing = new MarryRingView(curThaneInfo);
            }
            _marryRing.x = VersionSwitch.GOD_HALIDOM ? 180 : 70;
            _marryRing.y = 295;
            if(!_marryRing.parent)
            {
               _equipSprite.addChild(_marryRing);
            }
         }
      }
      
      private function refreshHeroFigure() : void
      {
         var _loc4_:ThaneInfo = new ThaneInfo();
         var _loc1_:Boolean = true;
         _loc4_.templateId = curThaneInfo.templateId;
         _loc4_.hideFashion = curThaneInfo.hideFashion;
         var _loc6_:GoodsInfo = new GoodsInfo();
         _loc6_.templateId = curThaneInfo.dragonTalkerInfo.dragonFashionWing;
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = curThaneInfo.dragonTalkerInfo.dragonFashionArm;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = curThaneInfo.dragonTalkerInfo.dragonFashionHat;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = curThaneInfo.dragonTalkerInfo.dragonFashionCloth;
         _loc4_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
         _loc4_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         _loc4_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         _loc4_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc2_);
         _figure.data = _loc4_;
         _wing.data = _loc6_;
         _weaponFashion.data = _loc5_;
         _headdressFshion.data = _loc3_;
         _clothesFashion.data = _loc2_;
      }
      
      private function refreshFashionEquip() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:FashionInfoMsg = _curThaneInfo.fashionMsg;
         _fashionLvlTxt.text = _loc1_.grades.toString();
         var _loc4_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc1_.grades + 1,113);
         if(!_loc4_)
         {
            _fashionProgressTxt.text = "max";
            _loc2_ = 100;
         }
         else
         {
            _loc5_ = int(_loc1_.gp);
            _loc3_ = int(_loc4_.Data);
            _fashionProgressTxt.text = _loc5_ + "/" + _loc3_;
            _loc2_ = _loc5_ / _loc3_ * 100;
         }
         _fashionProgressBar.gotoAndStop(_loc2_);
      }
      
      private function refreshTalismanView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerTalismanEquipCell = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = _talismanList[_loc2_];
            _loc1_.data = curThaneInfo.dragonTalkerInfo.getEquipInfoBySontype(_loc2_ + 401);
            _loc2_++;
         }
      }
      
      public function getItemViewByPos(param1:int, param2:int = 4) : PlayerEquipCell
      {
         var _loc3_:PlayerEquipCell = _equipViewDic[param1 + "_" + curThaneInfo.id + "_" + param2];
         if(!_loc3_)
         {
            _loc3_ = _honerViewDic[param1 + "_" + curThaneInfo.id + "_" + param2];
         }
         return _loc3_;
      }
      
      private function refreshDragonTalkerTips() : void
      {
         var _loc3_:int = 0;
         var _loc12_:String = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc14_:DragonTalkerSymbioteInfo = null;
         var _loc4_:int = 0;
         var _loc11_:String = null;
         var _loc2_:String = null;
         if(!curThaneInfo)
         {
            return;
         }
         var _loc7_:String = LanguageMgr.GetTranslation("public.level2",curThaneInfo.dragonTalkerInfo.fightMountGrade);
         var _loc1_:DragonTalkerFightMountTempInfo = dragonTalkerModel.battleBeastTempArr[curThaneInfo.dragonTalkerInfo.fightMountGrade - 1];
         var _loc6_:Array = _loc1_.hasValueAtt;
         var _loc9_:int = int(_loc6_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc9_)
         {
            _loc12_ = _loc6_[_loc3_];
            _loc8_ = int(_loc1_[_loc12_]);
            _loc7_ += "\n" + LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc12_,_loc8_);
            _loc3_++;
         }
         _loc7_ += "\n" + LanguageMgr.GetTranslation("DragonTalkerBattleBeastPropItem.titleText.text",_loc1_.HitPoint);
         _battleBeastImage.tipData = _loc7_;
         var _loc13_:String = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.title.text");
         var _loc10_:int = int(curThaneInfo.dragonTalkerInfo.symbiontList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc14_ = curThaneInfo.dragonTalkerInfo.symbiontList[_loc5_];
            _loc4_ = _loc5_ + 1;
            _loc11_ = LanguageMgr.GetTranslation("DragonTalkerBattleEquipInfoView.equipType.content" + _loc4_);
            _loc2_ = LanguageMgr.GetTranslation("public.level2",_loc14_.sortGrade);
            _loc13_ += "\n" + LanguageMgr.GetTranslation("DragonTalkerBattleEquipInfoView.symbioteTips.content",_loc4_,_loc11_,_loc14_.sortAddPercent,_loc2_);
            _loc5_++;
         }
         _symbioteImage.tipData = _loc13_;
      }
      
      private function refreshFashionTip() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(_fashionIdentityTip && _curThaneInfo)
         {
            _loc1_ = [_curThaneInfo.baseProperty.fashionPower,_curThaneInfo.baseProperty.fashionAgility,_curThaneInfo.baseProperty.fashionIntellect,_curThaneInfo.baseProperty.fashionPhysigue];
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
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_honor);
         _honor = null;
         ObjectUtils.disposeObject(_figureBack);
         _figureBack = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_relic);
         _relic = null;
         ObjectUtils.disposeObject(_heraldry);
         _heraldry = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_nameText);
         _consortiaText = null;
         ObjectUtils.disposeObject(_consortiaText);
         _consortiaText = null;
         ObjectUtils.disposeObject(_lvlText);
         _vipIconBtn = null;
         ObjectUtils.disposeObject(_vipIconBtn);
         _vipIconBtn = null;
         ObjectUtils.disposeObject(_novipIconBtn);
         _novipIconBtn = null;
         ObjectUtils.disposeObject(_fightBg);
         _fightBg = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         ObjectUtils.disposeObject(_attributeButton);
         _attributeButton = null;
         ObjectUtils.disposeObject(_marryRing);
         _marryRing = null;
         ObjectUtils.disposeObject(_symbioteImage);
         _symbioteImage = null;
         ObjectUtils.disposeObject(_battleBeastImage);
         _battleBeastImage = null;
         ObjectUtils.disposeViolentMc(_equipGirdBack);
         _equipGirdBack = null;
         ObjectUtils.disposeObject(_talismanContiner);
         _talismanContiner = null;
         ObjectUtils.disposeObject(_jobChangeBtn);
         _jobChangeBtn = null;
         LogicUtils.disposeDisplayCollection(_equipViewDic);
         _equipViewDic = null;
         LogicUtils.disposeDisplayCollection(_equipList);
         _equipList = null;
         LogicUtils.disposeDisplayCollection(_honerViewDic);
         _honerViewDic = null;
         LogicUtils.disposeDisplayCollection(_talismanList);
         _talismanList = null;
         ObjectUtils.disposeObject(_fashionGirdBack);
         _fashionGirdBack = null;
         ObjectUtils.disposeObject(_switchTip);
         _switchTip = null;
         ObjectUtils.disposeObject(_fashionIdentityTip);
         _fashionIdentityTip = null;
         ObjectUtils.disposeObject(_fashionProgressBar);
         _fashionProgressBar = null;
         ObjectUtils.disposeObject(_fashionProgressTxt);
         _fashionProgressTxt = null;
         ObjectUtils.disposeObject(_fashionLvlBmp);
         _fashionLvlBmp = null;
         ObjectUtils.disposeObject(_fashionLvlTxt);
         _fashionLvlTxt = null;
         ObjectUtils.disposeObject(_fashionBtn);
         _fashionBtn = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_headdressFshion);
         _headdressFshion = null;
         ObjectUtils.disposeObject(_clothesFashion);
         _clothesFashion = null;
         ObjectUtils.disposeObject(_wing);
         _wing = null;
         ObjectUtils.disposeObject(_weaponFashion);
         _weaponFashion = null;
         super.dispose();
      }
   }
}

