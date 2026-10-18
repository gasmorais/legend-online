package playerinfo
{
   import armyII.viewII.dragonsoul.DragonSoulView;
   import armyII.viewII.holydragonsoul.HolyDragonSoulView;
   import armyII.viewII.tattoo.TattooView;
   import bag.events.BagEvent;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.avenger.AvengerHoleMsg;
   import com.road.yishi.proto.avenger.AvengerSkillMsg;
   import com.road.yishi.proto.campaign.MountInfoMsg;
   import com.road.yishi.proto.dragontalker.SymbiontGp;
   import com.road.yishi.proto.dragontalker.TalismanMsg;
   import com.road.yishi.proto.goddess.GoddessEquipInfoMsg;
   import com.road.yishi.proto.pet.PetHallowInfoMsg;
   import com.road.yishi.proto.player.ArtifactInfoMsg;
   import com.road.yishi.proto.simple.DetailRspMsg;
   import com.road.yishi.proto.simple.SimpleArmyPawnMsg;
   import com.road.yishi.proto.simple.SimpleHeroMsg;
   import com.road.yishi.proto.simple.SimpleItemInfoMsg;
   import com.road.yishi.proto.simple.SimpleMagicCardInfoMsg;
   import com.road.yishi.proto.simple.SimpleStarAdditionMsg;
   import com.road.yishi.proto.simple.SimpleStarInfoMsg;
   import com.road.yishi.proto.simple.SimpleWatchMsg;
   import com.road.yishi.proto.tattoo.TattooEnhanceMsg;
   import com.road.yishi.proto.tattoo.TattooHoleMsg;
   import com.road.yishi.proto.theseus.TheseusEquipMsg;
   import com.road.yishi.proto.theseus.TheseusRageMsg;
   import com.road.yishi.proto.theseus.WarSoulMsg;
   import com.road.yishi.proto.titan.TitanDataMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import mvc.module.card.MagicCardFightInfo;
   import mvc.module.children.ChildData;
   import mvc.module.dragonTitan.DragonTitanData;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import mvc.module.goddess.GoddessEquipInfo;
   import mvc.module.goddess.GoddessInfo;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.perkinlab.PerkinLabThaneInfo;
   import mvc.module.pet.PetData;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.sort.SortData;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarTroughInfo;
   import mvc.module.tattoo.TattooHole;
   import mvc.module.tattoo.TattooHoleInfoII;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import mvc.module.theseus.TheseusYiCellInfo;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import mvc.module.theseus.WarSoulModel;
   import playerinfo.view.DragonTalkerEquipInfoView;
   import playerinfo.view.EquipInfoView;
   import playerinfo.view.InfoView;
   import playerinfo.view.MountInfoView;
   import playerinfo.view.ThaneAttributeFrame;
   import playerinfo.view.playerattribute.PlayerTotalAttributeView;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ArtifactThaneInfo;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.SimpleMountInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.RequestInfoEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SpaceTemplateManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerInfoFrameII extends Frame implements IManualSize
   {
      
      private var _attributeView:PlayerTotalAttributeView;
      
      private var _back:Scale9CornerImage;
      
      private var _currentCount:int = 0;
      
      private var _currentSelected:Object;
      
      private var _equipBtn:SelectedIconButton;
      
      private var _equipDic:SimpleDictionary;
      
      private var _equipInfoView:EquipInfoView;
      
      private var _infoBtn:SelectedIconButton;
      
      private var _infoView:InfoView;
      
      private var _isCross:Boolean = false;
      
      private var _showMountBtn:Boolean = true;
      
      private var _starImg:Bitmap;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _thane:ThaneInfo;
      
      private var _totalCount:int = 2;
      
      private var cloth:GoodsInfo;
      
      private var _attackAttrbite:ThaneAttributeFrame;
      
      private var _rect:Rectangle;
      
      private var _isRobot:Boolean;
      
      private var _cardFightInfoList:Array;
      
      private var _guardButton:SelectedIconButton;
      
      private var _guardView:DisplayObject;
      
      private var _dragonSoulButton:SelectedIconButton;
      
      private var _dragonSoulView:DragonSoulView;
      
      private var _holyDragonSoulButton:SelectedIconButton;
      
      private var _holyDragonSoulView:HolyDragonSoulView;
      
      private var _tattooButton:SelectedIconButton;
      
      private var _tattooView:TattooView;
      
      private var _dragonTalkerBtn:SelectedIconButton;
      
      private var _dragonTalkerView:DragonTalkerEquipInfoView;
      
      private var _btnHBox:HBox;
      
      private var _data:Object;
      
      public function PlayerInfoFrameII()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,410,560);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _btnHBox = ComponentFactory.Instance.creatComponentByStylename("ArmyFrameII.BtnHBox");
         titleText = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.info");
         _back = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoBack");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("army.HeroEquipButton");
         _guardButton = ComponentFactory.Instance.creatComponentByStylename("army.BattleGuardButton");
         _guardButton.y = -7;
         _dragonSoulButton = ComponentFactory.Instance.creatComponentByStylename("army.DragonSoulButton");
         _dragonSoulButton.y = -7;
         _holyDragonSoulButton = ComponentFactory.Instance.creatComponentByStylename("army.HolyDragonSoulButton");
         _holyDragonSoulButton.y = -7;
         _tattooButton = ComponentFactory.Instance.creatComponentByStylename("army.TattooButton");
         _tattooButton.y = -7;
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("army.InformationButton");
         _starImg = ComponentFactory.Instance.creatBitmap("asset.playerinfo.StarBtn");
         _dragonTalkerBtn = ComponentFactory.Instance.creatComponentByStylename("PlayerInfoFrameII.dragonTalkerBtn");
         addToContent(_back);
         _btnHBox.addChild(_equipBtn);
         addToContent(_btnHBox);
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_equipBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabGroup.addEventListener("change",__panelChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4125,__receiveEquipHandler);
         PlayerManager.instance.addEventListener("REQUEST_SIMPLEANDSNS_INFO",__simpleInfoHandler);
         PlayerManager.instance.addEventListener("QUERY_PETDATA_RESULT",__queryPetDataResultHandler);
         NotificationManager.instance.addEventListener("CHECKPLAYERITEMCLICK",__itemClickhandler);
         PlayerManager.instance.addEventListener("QUERY_CHILDDATA_RESULT",__queryChildDataResultHandler);
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:GoodsInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         _data = param1;
         if(!param1)
         {
            return;
         }
         _equipDic = null;
         _thane = null;
         _tabGroup.selectIndex = -1;
         var _loc7_:Boolean = true;
         if(param1 is SortData)
         {
            _thane = (param1 as SortData).army.baseHero;
            _equipDic = new SimpleDictionary(true);
            _equipDic.setDictionary(_thane.equipDic);
            _thane.hideFashion = (param1 as SortData).HideFashion;
            _loc2_ = _equipDic["2_" + _thane.id + "_" + 4];
            _loc3_ = _equipDic["0_" + _thane.id + "_" + 4];
            _loc6_ = _equipDic["8_" + _thane.id + "_" + 4];
            _loc4_ = _equipDic["9_" + _thane.id + "_" + 4];
            _loc8_ = _equipDic["10_" + _thane.id + "_" + 4];
            _loc5_ = _equipDic["11_" + _thane.id + "_" + 4];
            _thane.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc2_);
            _thane.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
            _thane.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
            _thane.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
            _thane.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
            _thane.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
            __attributeHandler(null);
            _cardFightInfoList = (param1 as SortData).activeMagicCards;
            __panelChangeHandler(null);
         }
         else if(param1 is ThaneInfo)
         {
            _thane = param1 as ThaneInfo;
            _isRobot = _thane.isRobot;
            if(isPerkinThaneInfo)
            {
               _equipDic = new SimpleDictionary(true);
               _equipDic.setDictionary(_thane.equipDic);
               _cardFightInfoList = (_thane as PerkinLabThaneInfo).activeMagicCards;
               __attributeHandler(null);
            }
            else if(!isCross)
            {
               _loc7_ = false;
               PlayerManager.instance.sendRequestSimpleAndSnsInfo(_thane.userId,1);
               PlayerManager.instance.sendRequestEquip(_thane.userId,1,true,true,true);
            }
            else
            {
               __attributeHandler(null);
            }
         }
         else
         {
            _loc7_ = false;
            PlayerManager.instance.sendRequestSimpleAndSnsInfo(int(param1),1);
            PlayerManager.instance.sendRequestEquip(int(param1),1,true,true,true);
         }
         if(_thane)
         {
            showBtns();
         }
         if(_loc7_)
         {
            resetGroupIndex();
         }
      }
      
      private function resetGroupIndex() : void
      {
         if(_thane && _thane.dragonTalkerInfo.isDragonTalker)
         {
            _tabGroup.selectIndex = 1;
         }
         else
         {
            _tabGroup.selectIndex = 0;
         }
      }
      
      private function get isPerkinThaneInfo() : Boolean
      {
         if(_thane.hasOwnProperty("isPerkinLabCrossInfo") && _thane["isPerkinLabCrossInfo"])
         {
            return true;
         }
         return false;
      }
      
      private function showBtns() : void
      {
         if(_thane.grades >= 55)
         {
            _btnHBox.removeAllChild();
            _btnHBox.addChild(_equipBtn);
            if(_thane.isOpenDragonTalker)
            {
               _btnHBox.addChild(_dragonTalkerBtn);
            }
            _btnHBox.addChild(_guardButton);
            if(_thane.grades >= 40 && _thane.dragonSoulType == 153)
            {
               _btnHBox.addChild(_holyDragonSoulButton);
            }
            else if(_thane.grades >= 40 && _thane.dragonSoulType != 0)
            {
               _btnHBox.addChild(_dragonSoulButton);
            }
            if(_thane.vocationGrades > 0)
            {
               _btnHBox.addChild(_tattooButton);
            }
            _tabGroup.removeAllItem();
            _tabGroup.addSelectItem(_equipBtn);
            _tabGroup.addSelectItem(_dragonTalkerBtn);
            _tabGroup.addSelectItem(_guardButton);
            if(_thane.grades >= 40 && _thane.dragonSoulType == 153)
            {
               _tabGroup.addSelectItem(_holyDragonSoulButton);
            }
            else if(_thane.grades >= 40 && _thane.dragonSoulType != 0)
            {
               _tabGroup.addSelectItem(_dragonSoulButton);
            }
            if(_thane.vocationGrades > 0)
            {
               _tabGroup.addSelectItem(_tattooButton);
            }
         }
      }
      
      public function get isCross() : Boolean
      {
         return _isCross;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         _isCross = param1;
         if(_equipBtn)
         {
            _equipBtn.visible = true;
         }
         if(_infoBtn)
         {
            _infoBtn.visible = true;
         }
         if(_equipInfoView)
         {
            _equipInfoView.isCross = param1;
         }
         if(_isCross)
         {
            _showMountBtn = false;
            if(_infoBtn)
            {
               _infoBtn.visible = false;
            }
         }
      }
      
      public function show() : void
      {
         isCross = _isCross;
         LayerManager.Instance.addToLayer(this,3,true,true);
         if(_thane && _thane.dragonTalkerInfo.isDragonTalker)
         {
            _tabGroup.selectIndex = 1;
         }
      }
      
      public function get showMountBtn() : Boolean
      {
         return _showMountBtn;
      }
      
      public function set showMountBtn(param1:Boolean) : void
      {
         _showMountBtn = param1;
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
      
      private function __panelChangeHandler(param1:Event) : void
      {
         clean();
         SoundManager.instance.play("022");
         var _loc2_:ISelectable = _tabGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _equipBtn:
               if(!_equipInfoView)
               {
                  _equipInfoView = ComponentFactory.Instance.creatCustomObject("playerinfo.EquipInfoView");
               }
               if(!_attackAttrbite)
               {
                  __attributeHandler(null);
               }
               addToContent(_equipInfoView);
               _equipInfoView.initData(_thane,_equipDic,_isCross,_cardFightInfoList);
               _currentSelected = _equipInfoView;
               _equipInfoView.addEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               if(_dragonTalkerView)
               {
                  _dragonTalkerView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.switchPanel(1);
               }
               break;
            case _dragonTalkerBtn:
               if(!_dragonTalkerView)
               {
                  _dragonTalkerView = ComponentFactory.Instance.creatCustomObject("playerinfo.dragonTalkerView");
               }
               addToContent(_dragonTalkerView);
               if(!_attackAttrbite)
               {
                  __attributeHandler(null);
               }
               _currentSelected = _dragonTalkerView;
               _dragonTalkerView.initData(_thane,_equipDic);
               _dragonTalkerView.addEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               if(_equipInfoView)
               {
                  _equipInfoView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.switchPanel(1);
               }
               break;
            case _infoBtn:
               if(!_infoView)
               {
                  _infoView = ComponentFactory.Instance.creatCustomObject("playerinfo.PlayerInfoView");
               }
               _infoView.initData(_thane,_equipDic);
               _currentSelected = _infoView;
               addToContent(_infoView);
               if(_equipInfoView)
               {
                  _equipInfoView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_dragonTalkerView)
               {
                  _dragonTalkerView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.dispose();
                  _attackAttrbite = null;
               }
               break;
            case _guardButton:
               if(!_guardView)
               {
                  _guardView = ComponentFactory.Instance.creat("armyII.viewII.battleGuard.BattleGuardView",[true,_thane]);
                  _guardView.x = 3;
                  _guardView.y = 19;
               }
               if(!_attackAttrbite)
               {
                  __attributeHandler(null);
               }
               _guardView["data"] = _thane.battleGuardInfo;
               _currentSelected = _guardView;
               addToContent(_guardView);
               if(_equipInfoView)
               {
                  _equipInfoView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_dragonTalkerView)
               {
                  _dragonTalkerView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.switchPanel(2);
               }
               break;
            case _dragonSoulButton:
               if(!_dragonSoulView)
               {
                  _dragonSoulView = ComponentFactory.Instance.creat("armyII.viewII.dragonsoul.DragonSoulView",[false,_thane]);
                  _dragonSoulView.x = 3;
                  _dragonSoulView.y = 19;
               }
               if(!_attackAttrbite)
               {
                  __attributeHandler(null);
               }
               _currentSelected = _dragonSoulView;
               addToContent(_dragonSoulView);
               if(_equipInfoView)
               {
                  _equipInfoView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_dragonTalkerView)
               {
                  _dragonTalkerView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.switchPanel(1);
               }
               break;
            case _holyDragonSoulButton:
               if(!_holyDragonSoulView)
               {
                  _holyDragonSoulView = ComponentFactory.Instance.creat("armyII.viewII.holydragonsoul.HolyDragonSoulView",[false,_thane]);
                  _holyDragonSoulView.x = 3;
                  _holyDragonSoulView.y = 19;
               }
               if(!_attackAttrbite)
               {
                  __attributeHandler(null);
               }
               _currentSelected = _holyDragonSoulView;
               addToContent(_holyDragonSoulView);
               if(_equipInfoView)
               {
                  _equipInfoView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_dragonTalkerView)
               {
                  _dragonTalkerView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.switchPanel(1);
               }
               break;
            case _tattooButton:
               if(!_tattooView)
               {
                  _tattooView = new TattooView(false,_thane);
                  _tattooView.y = 17;
                  addToContent(_tattooView);
               }
               if(!_attackAttrbite)
               {
                  __attributeHandler(null);
               }
               _currentSelected = _tattooView;
               addToContent(_tattooView);
               if(_equipInfoView)
               {
                  _equipInfoView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_dragonTalkerView)
               {
                  _dragonTalkerView.removeEventListener("ATTRIBUTE_CLICK",__attributeHandler);
               }
               if(_attackAttrbite)
               {
                  _attackAttrbite.switchPanel(1);
               }
         }
      }
      
      private function __receiveEquipHandler(param1:SLGSocketEvent) : void
      {
         var _loc39_:SimpleHeroMsg = null;
         var _loc28_:DragonTalkerSymbioteInfo = null;
         var _loc52_:DragonTalkerTalismanInfo = null;
         var _loc47_:Array = null;
         var _loc23_:TattooHoleMsg = null;
         var _loc53_:int = 0;
         var _loc59_:TattooHole = null;
         var _loc5_:Array = null;
         var _loc19_:TattooHoleInfoII = null;
         var _loc24_:DragonTitanData = null;
         var _loc15_:TitanDataMsg = null;
         var _loc65_:Array = null;
         var _loc64_:PetHallowsInfo = null;
         var _loc61_:GoddessInfo = null;
         var _loc54_:GoddessEquipInfo = null;
         var _loc62_:MonsterInfo = null;
         var _loc50_:AvengerModel = null;
         var _loc27_:AvengerSkillInfo = null;
         var _loc4_:AvengerDevilArmorHoleInfo = null;
         var _loc35_:TheseussoulModel = null;
         var _loc60_:WarFrameItemInfo = null;
         var _loc31_:TheseusYiCellInfo = null;
         var _loc44_:WarSoulModel = null;
         var _loc57_:TheseusWarsoulItemInfo = null;
         var _loc67_:ArtifactThaneInfo = null;
         var _loc12_:ArtifactInfoMsg = null;
         var _loc42_:int = 0;
         var _loc26_:int = 0;
         var _loc34_:int = 0;
         var _loc22_:Array = null;
         var _loc66_:* = null;
         var _loc45_:Array = null;
         var _loc13_:ThaneInfo = null;
         var _loc55_:int = 0;
         var _loc32_:SimpleArmyPawnMsg = null;
         var _loc40_:SimpleItemInfoMsg = null;
         var _loc8_:GoodsInfo = null;
         var _loc9_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc18_:GoodsInfo = null;
         var _loc30_:GoodsInfo = null;
         var _loc51_:GoodsInfo = null;
         var _loc33_:GoodsInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc10_:SimpleStarInfoMsg = null;
         var _loc38_:StarInfo = null;
         var _loc49_:SimpleMagicCardInfoMsg = null;
         var _loc46_:MagicCardFightInfo = null;
         var _loc20_:int = 0;
         var _loc7_:SimpleStarAdditionMsg = null;
         var _loc63_:int = 0;
         var _loc37_:StarTroughInfo = null;
         var _loc17_:BattleGuardSocketInfo = null;
         var _loc41_:PackageIn = param1.data as PackageIn;
         var _loc2_:DetailRspMsg = new DetailRspMsg();
         _loc2_ = _loc41_.readBody(_loc2_) as DetailRspMsg;
         if(_loc2_.army.hasSimpleHero)
         {
            _loc39_ = _loc2_.army.simpleHero;
            if(_thane && _thane.userId != _loc39_.playerId)
            {
               return;
            }
            if(!_thane)
            {
               _thane = new ThaneInfo();
            }
            _thane.id = _loc39_.heroId;
            _thane.nickName = _loc39_.nickName;
            _thane.nickNameB = _loc39_.nickNameB;
            _thane.marryRingGrade = _loc39_.ringGrade;
            _thane.templateId = _loc39_.tempateId;
            _thane.consortiaID = _loc2_.army.consortiaId;
            _thane.consortiaName = _loc2_.army.consortiaName;
            _thane.hideFashion = _loc2_.hideFashion;
            _thane.charms = _loc39_.totalCharm;
            _thane.honer = _loc39_.totalGeste;
            _thane.appellId = _loc2_.army.appellid;
            _thane.attackProrerty.totalPhyAttack = _loc39_.totalPhyAttack;
            _thane.attackProrerty.totalPhyDefence = _loc39_.totalPhyDefence;
            _thane.attackProrerty.totalMagicAttack = _loc39_.totalMagicAttack;
            _thane.attackProrerty.totalMagicDefence = _loc39_.totalMagicDefence;
            _thane.attackProrerty.totalLive = _loc39_.totalLive;
            _thane.attackProrerty.totalForceHit = _loc39_.totalForceHit;
            _thane.attackProrerty.totalConatArmy = _loc39_.totalConatArmy;
            _thane.baseProperty.totalPower = _loc39_.totalPower;
            _thane.baseProperty.totalAgility = _loc39_.totalAgility;
            _thane.baseProperty.totalIntellect = _loc39_.totalIntellect;
            _thane.baseProperty.totalCaptain = _loc39_.totalCaptain;
            _thane.baseProperty.totalPhysique = _loc39_.totalPhysique;
            _thane.attackProrerty.totalParry = _loc39_.totalParry;
            _thane.attackProrerty.totalIntensity = _loc39_.totalStrength;
            _thane.attackProrerty.totalTenacity = _loc39_.totalTenacity;
            _thane.attackProrerty.totalPenetrate = _loc39_.totalPenetrate;
            _thane.attackProrerty.totalDingli = _loc39_.totalStunAttr;
            _thane.attackProrerty.basePhyAttack = _loc39_.basePhyAttack;
            _thane.attackProrerty.basePhyDefence = _loc39_.basePhyDefence;
            _thane.attackProrerty.baseMagicAttack = _loc39_.baseMagicAttack;
            _thane.attackProrerty.baseMagicDefence = _loc39_.baseMagicDefence;
            _thane.attackProrerty.baseLive = _loc39_.baseLive;
            _thane.attackProrerty.baseForceHit = _loc39_.baseForceHit;
            _thane.attackProrerty.baseConatArmy = _loc39_.baseConatArmy;
            _thane.attackProrerty.baseParry = _loc39_.baseParry;
            _thane.attackProrerty.baseIntensity = _loc39_.baseStrength;
            _thane.attackProrerty.baseTenacity = _loc39_.baseTenacity;
            _thane.attackProrerty.basePenetrate = _loc39_.basePenetrate;
            _thane.attackProrerty.baseDingli = _loc39_.baseStunAttr;
            _thane.IsVipAndNoExpirt = _loc2_.army.isVip;
            _thane.vipType = _loc2_.army.vipType;
            _thane.jewelGrades = _loc2_.army.storeGrade;
            _thane.seniorStoreGrade = _loc2_.army.seniorStoreGrade;
            _thane.fateTotalGp = _loc2_.army.fateTotalGp;
            _thane.fateGrades = _loc2_.army.fateGrades;
            _thane.conciseGrades = _loc2_.army.equipmentRefiningGrade;
            _thane.baseProperty.totalBattleWill = _loc39_.reduceResi;
            _thane.baseProperty.totalFireResi = _loc39_.fireResi;
            _thane.baseProperty.totalWaterResi = _loc39_.waterResi;
            _thane.baseProperty.totalWindResi = _loc39_.windResi;
            _thane.baseProperty.totalElecResi = _loc39_.electResi;
            _thane.baseProperty.totalLightResi = _loc39_.lightResi;
            _thane.baseProperty.totalDarkResi = _loc39_.darkResi;
            _thane.baseProperty.totalStrikeResi = _loc39_.totalResiPenetrate;
            _thane.baseProperty.totalResistResi = _loc39_.totalReduceResiAgainst;
            _thane.baseProperty.hasSetBattleInfoFlag = true;
            _thane.baseProperty.fashionPower = _loc39_.fashionAddPower;
            _thane.baseProperty.fashionAgility = _loc39_.fashionAddArmor;
            _thane.baseProperty.fashionIntellect = _loc39_.fashionAddIntellect;
            _thane.baseProperty.fashionPhysigue = _loc39_.fashionAddLife;
            _thane.baseProperty.hasSetFashionProperty = true;
            if(_loc2_.dragonTalkerInfo)
            {
               _thane.isOpenDragonTalker = _loc2_.dragonTalkerInfo.isOpen;
               _thane.dragonTalkerInfo.isDragonTalker = _loc2_.dragonTalkerInfo.isNowDragonTalker;
               _thane.dragonTalkerInfo.battleBeastId = _loc2_.dragonTalkerInfo.currentFightMount;
               _thane.dragonTalkerInfo.fightMountGp = _loc2_.dragonTalkerInfo.fightMountGp;
               _thane.dragonTalkerInfo.symbiontList = _loc2_.dragonTalkerInfo.symbiontGpList;
               if(_loc2_.dragonTalkerInfo.fashions)
               {
                  _thane.dragonTalkerInfo.dragonFashionWing = _loc2_.dragonTalkerInfo.fashions.dragonWingAvata;
                  _thane.dragonTalkerInfo.dragonFashionHat = _loc2_.dragonTalkerInfo.fashions.dragonHatAvata;
                  _thane.dragonTalkerInfo.dragonFashionArm = _loc2_.dragonTalkerInfo.fashions.dragonArmAvata;
                  _thane.dragonTalkerInfo.dragonFashionCloth = _loc2_.dragonTalkerInfo.fashions.dragonClothAvata;
               }
               if(_loc2_.dragonTalkerInfo.symbiontGpList)
               {
                  _thane.dragonTalkerInfo.symbiontList = [];
                  for each(var _loc68_:SymbiontGp in _loc2_.dragonTalkerInfo.symbiontGpList)
                  {
                     _loc28_ = new DragonTalkerSymbioteInfo();
                     _loc28_.index = _loc68_.index;
                     _loc28_.currentExp = _loc68_.totalGp;
                     _thane.dragonTalkerInfo.symbiontList.push(_loc28_);
                  }
               }
               if(_loc2_.talismanInfo)
               {
                  _thane.dragonTalkerInfo.talismanList = [];
                  for each(var _loc29_:TalismanMsg in _loc2_.talismanInfo)
                  {
                     _loc52_ = new DragonTalkerTalismanInfo();
                     _loc52_.id = _loc29_.id;
                     _loc52_.tempId = _loc29_.templateId;
                     _loc52_.pos = _loc29_.pos;
                     _loc52_.equipPos = _loc29_.equipslot;
                     _loc52_.isExist = _loc29_.isExist;
                     _loc52_.grade = _loc29_.grade;
                     _loc52_.exp = _loc29_.gp;
                     _loc52_.randomSkillList = _loc29_.randomSkillList;
                     _loc52_.newSkillId = _loc29_.newSkillId;
                     _loc52_.oldSkillIndex = _loc29_.oldSkillIndex;
                     _loc52_.count = _loc29_.count;
                     _loc52_.isNew = _loc29_.isNew;
                     _loc52_.isSelf = false;
                     _thane.dragonTalkerInfo.talismanList.push(_loc52_);
                  }
               }
            }
            _loc47_ = [];
            if(_loc2_.holeInfo)
            {
               _loc53_ = 0;
               while(_loc53_ < _loc2_.holeInfo.length)
               {
                  _loc23_ = _loc2_.holeInfo[_loc53_];
                  _loc59_ = new TattooHole();
                  _loc59_.index = _loc53_ + 1;
                  _loc59_.oldTattooType = _loc23_.oldTattooType;
                  _loc59_.oldAddProperty = _loc23_.oldAddProperty;
                  _loc59_.oldAddingValue = _loc23_.oldAddingValue;
                  _loc59_.oldReduceProperty = _loc23_.oldReduceProperty;
                  _loc59_.oldReduceValue = _loc23_.oldReduceValue;
                  _loc59_.newTattooType = _loc23_.newTattooType;
                  _loc59_.newAddProperty = _loc23_.newAddProperty;
                  _loc59_.newAddingValue = _loc23_.newAddingValue;
                  _loc59_.newReduceProperty = _loc23_.newReduceProperty;
                  _loc59_.newReduceValue = _loc23_.newReduceValue;
                  _loc47_.push(_loc59_);
                  _loc53_++;
               }
            }
            _thane.holes = _loc47_;
            _loc5_ = [];
            if(_loc2_.tattooEnhanceInfo)
            {
               for each(var _loc58_:TattooEnhanceMsg in _loc2_.tattooEnhanceInfo.tattooEnhance)
               {
                  _loc19_ = new TattooHoleInfoII();
                  _loc19_.holeId = _loc58_.holdId;
                  _loc19_.property = _loc58_.property;
                  _loc19_.level = _loc58_.level;
                  _loc19_.enable = _loc58_.enable;
                  _loc5_.push(_loc19_);
               }
            }
            _thane.tattooPrintHoles = _loc5_;
            _loc24_ = new DragonTitanData();
            if(_loc2_.titanInfo)
            {
               _loc15_ = _loc2_.titanInfo;
               _loc24_.userId = _loc15_.userId;
               _loc24_.templateId = _loc15_.templateId;
               _loc24_.starExp = _loc15_.starExp;
               _loc24_.starLevel = _loc15_.starLevel;
               _loc24_.devourTitan = _loc15_.devourTitan;
               _loc24_.attack = _loc15_.attack;
               _loc24_.defence = _loc15_.defence;
               _loc24_.magicAttack = _loc15_.magicAttack;
               _loc24_.magicDefence = _loc15_.magicDefence;
               _loc24_.live = _loc15_.live;
               _loc24_.forceHit = _loc15_.forceHit;
               _loc24_.parry = _loc15_.parry;
               _loc24_.strength = _loc15_.strength;
               _loc24_.tenacity = _loc15_.tenacity;
               _loc24_.reduceResi = _loc15_.reduceResi;
               _loc24_.fireResi = _loc15_.fireResi;
               _loc24_.waterResi = _loc15_.waterResi;
               _loc24_.electResi = _loc15_.electResi;
               _loc24_.windResi = _loc15_.windResi;
               _loc24_.darkResi = _loc15_.darkResi;
               _loc24_.lightResi = _loc15_.lightResi;
               _loc24_.penetrate = _loc15_.penetrate;
               _loc24_.stunAttr = _loc15_.stunAttr;
            }
            _thane.titanInfo = _loc24_;
            _loc65_ = [];
            if(_loc2_.petHallowInfo)
            {
               for each(var _loc43_:PetHallowInfoMsg in _loc2_.petHallowInfo)
               {
                  _loc64_ = new PetHallowsInfo();
                  _loc64_.hallowTempId = _loc43_.hallowTempId;
                  _loc64_.hallowType = _loc43_.hallowSonType;
                  _loc64_.lookFightPower = _loc43_.attackData;
                  _loc65_.push(_loc64_);
               }
            }
            _thane.petHallowsArr = _loc65_;
            _loc61_ = new GoddessInfo();
            if(_loc2_.goddessInfo)
            {
               _loc61_.userId = _loc2_.goddessInfo.userId;
               _loc61_.templateId = _loc2_.goddessInfo.templateId;
               _loc61_.grade = _loc2_.goddessInfo.grade;
               _loc61_.step = _loc2_.goddessInfo.step;
               _loc61_.devote = _loc2_.goddessInfo.devote;
               _loc61_.attack = _loc2_.goddessInfo.attack;
               _loc61_.defance = _loc2_.goddessInfo.defance;
               _loc61_.magicAttack = _loc2_.goddessInfo.magicAttack;
               _loc61_.magicDefance = _loc2_.goddessInfo.magicDefance;
               _loc61_.live = _loc2_.goddessInfo.live;
               _loc61_.isActive = true;
               for each(var _loc21_:GoddessEquipInfoMsg in _loc2_.goddessInfo.equipInfos)
               {
                  _loc54_ = _loc61_.equips[_loc21_.equipType];
                  if(!_loc54_)
                  {
                     _loc54_ = new GoddessEquipInfo();
                     _loc54_.equipType = _loc21_.equipType;
                     _loc61_.equips[_loc21_.equipType] = _loc54_;
                  }
                  _loc54_.equipAdvanceLevel = _loc21_.equipAdvanceLevel;
                  _loc54_.equipCurBlessing = _loc21_.equipCurBlessing;
                  _loc54_.equipStrengthenLevel = _loc21_.equipStrengthenLevel;
                  _loc54_.ownerId = _loc2_.goddessInfo.templateId;
               }
            }
            _thane.goddessInfo = _loc61_;
            _loc62_ = new MonsterInfo();
            if(_loc2_.monsterInfo)
            {
               _loc62_.monsterId = _loc2_.monsterInfo.monsterId;
               _loc62_.isExist = _loc2_.monsterInfo.isExist;
               _loc62_.firstValue = _loc2_.monsterInfo.first;
               _loc62_.enterWar = _loc2_.monsterInfo.isFight;
               _loc62_.isLock = _loc2_.monsterInfo.isLock;
               _loc62_.name = _loc2_.monsterInfo.name;
               _loc62_.fightPower = _loc2_.monsterInfo.fightPower;
               _loc62_.type = _loc2_.monsterInfo.type;
               _loc62_.star = _loc2_.monsterInfo.star;
               _loc62_.grade = _loc2_.monsterInfo.level;
               _loc62_.curExp = _loc2_.monsterInfo.exp;
               _loc62_.stageGrade = _loc2_.monsterInfo.stageLevel;
               _loc62_.stageExp = _loc2_.monsterInfo.stateExp;
               _loc62_.skillExpValue = _loc2_.monsterInfo.skills;
               _loc62_.isFollow = _loc2_.monsterInfo.isFollow;
               _loc62_.setOtherData();
            }
            _thane.monsterInfo = _loc62_;
            _loc50_ = new AvengerModel();
            if(_loc2_.avengerInfo)
            {
               if(_loc2_.avengerInfo.hasGrade)
               {
                  _loc50_.bodyInfo.grade = _loc2_.avengerInfo.grade;
               }
               if(_loc2_.avengerInfo.hasExp)
               {
                  _loc50_.bodyInfo.exp = _loc2_.avengerInfo.exp;
               }
               for each(var _loc36_:AvengerSkillMsg in _loc2_.avengerInfo.skillDatas)
               {
                  _loc27_ = _loc50_.skillDic[_loc36_.skillSonType];
                  if(!_loc27_)
                  {
                     _loc27_ = new AvengerSkillInfo();
                     _loc50_.skillDic.add(_loc36_.skillSonType,_loc27_);
                  }
                  _loc27_.skillTempId = _loc36_.skillId;
                  _loc27_.skillSontype = _loc36_.skillSonType;
                  _loc27_.isFight = _loc36_.isUse;
                  _loc27_.attack = _loc36_.attack;
                  _loc27_.defence = _loc36_.defence;
                  _loc27_.magicDefence = _loc36_.magicDefence;
                  _loc27_.live = _loc36_.live;
                  _loc27_.forceHit = _loc36_.forcehit;
                  _loc27_.parry = _loc36_.parry;
                  _loc27_.penetrate = _loc36_.penetrate;
                  _loc27_.reduceResi = _loc36_.reduceResi;
                  _loc27_.fireResi = _loc36_.fireResi;
                  _loc27_.waterResi = _loc36_.waterResi;
                  _loc27_.electResi = _loc36_.electResi;
                  _loc27_.windResi = _loc36_.windResi;
                  _loc27_.darkResi = _loc36_.darkResi;
                  _loc27_.lightResi = _loc36_.lightResi;
                  _loc27_.needItems = _loc36_.itemInfo;
               }
               for each(var _loc56_:AvengerHoleMsg in _loc2_.avengerInfo.holeDatas)
               {
                  _loc4_ = _loc50_.devilArmorInfo.holeDic[_loc56_.pos];
                  if(!_loc4_)
                  {
                     _loc4_ = new AvengerDevilArmorHoleInfo();
                     _loc50_.devilArmorInfo.holeDic.add(_loc56_.pos,_loc4_);
                  }
                  _loc4_.pos = _loc56_.pos;
                  _loc4_.grade = _loc56_.grade;
                  _loc4_.exp = _loc56_.exp;
                  _loc4_.inlayItem = _loc56_.inlayItem;
               }
               if(_loc2_.avengerInfo.hasArmorGrade)
               {
                  _loc50_.devilArmorInfo.grade = _loc2_.avengerInfo.armorGrade;
               }
               if(_loc2_.avengerInfo.hasArmorExp)
               {
                  _loc50_.devilArmorInfo.exp = _loc2_.avengerInfo.armorExp;
               }
            }
            _thane.avengerInfo = _loc50_;
            _loc35_ = new TheseussoulModel();
            if(_loc2_.theseusInfo)
            {
               _loc35_.propertys.armour = _loc2_.theseusInfo.armour;
               _loc35_.level = _loc2_.theseusInfo.level;
               if(_loc2_.theseusInfo.theseusEquipList)
               {
                  for each(var _loc25_:TheseusEquipMsg in _loc2_.theseusInfo.theseusEquipList)
                  {
                     _loc60_ = new WarFrameItemInfo();
                     _loc60_.id = _loc25_.id;
                     _loc60_.type = _loc25_.type;
                     _loc60_.pos = _loc25_.pos;
                     _loc60_.templateId = _loc25_.templateId;
                     _loc60_.strengthen = _loc25_.strengthen;
                     _loc60_.reform = _loc25_.quality;
                     _loc60_.isEquip = _loc25_.isEquip;
                     _loc60_.isExist = _loc25_.isExist;
                     _loc60_.count = _loc25_.count;
                     _loc35_.updateSuite1(_loc25_.equipPos,_loc60_.id,"suite" + _loc60_.warTempInfo.Property1);
                     _loc35_.putItem(_loc60_.id,_loc60_);
                  }
               }
               _loc35_.hokeInfo = _loc2_.theseusInfo.hokeInfo;
               _loc35_.coreLevel = _loc2_.theseusInfo.coreLevel;
            }
            if(_loc2_.rageInfo)
            {
               for each(var _loc14_:TheseusRageMsg in _loc2_.rageInfo.rages)
               {
                  _loc31_ = new TheseusYiCellInfo();
                  _loc31_.pos = _loc14_.pos;
                  _loc31_.level = _loc14_.level;
                  _loc35_.yiDic.add(_loc31_.pos,_loc31_);
               }
            }
            _thane.theseusInfo = _loc35_;
            _loc44_ = new WarSoulModel();
            if(_loc2_.warSoulInfo)
            {
               _loc44_.fightIdx = _loc2_.warSoulInfo.fightIdx;
               for each(var _loc11_:WarSoulMsg in _loc2_.warSoulInfo.warSouls)
               {
                  _loc57_ = new TheseusWarsoulItemInfo();
                  _loc57_.id = _loc11_.id;
                  _loc57_.warSoulId = _loc11_.warSoulId;
                  _loc57_.star = _loc11_.star;
                  _loc57_.strengthen = _loc11_.strengthen;
                  _loc57_.reform = _loc11_.reform;
                  _loc57_.reformBuff = _loc11_.reformBuff;
                  _loc57_.learnSkill = _loc11_.learnSkill;
                  _loc57_.ramdomSkills = _loc11_.ramdomSkills;
                  _loc57_.isEquip = _loc11_.isEquip;
                  _loc57_.isExist = _loc11_.isExist;
                  _loc57_.isLock = _loc11_.isLock;
                  _loc44_.putItem(_loc57_.id,_loc57_);
               }
            }
            _thane.warSoulInfo = _loc44_;
            _loc67_ = new ArtifactThaneInfo();
            if(_loc2_.artifactInfo)
            {
               _loc12_ = _loc2_.artifactInfo;
               _loc67_.templateId = _loc12_.templateId;
               _loc67_.level = _loc12_.level;
               _loc67_.fightPower = _loc12_.fightPower;
               _loc67_.attack = _loc12_.attack;
               _loc67_.magicAttack = _loc12_.magicAttack;
               _loc67_.defences = _loc12_.defences;
               _loc67_.magicDefences = _loc12_.magicDefences;
               _loc67_.penetrate = _loc12_.penetrate;
               _loc67_.parry = _loc12_.parry;
               _loc67_.live = _loc12_.live;
               _loc67_.skills = _loc12_.skills;
               _loc67_.addPer = _loc12_.addPer;
            }
            _thane.artifactInfo = _loc67_;
            if(_loc2_.army.hasDragonGrade)
            {
               _loc22_ = _loc2_.army.dragonGrade.split("|");
               for each(_loc66_ in _loc22_)
               {
                  _loc45_ = _loc66_.split(",");
                  if(int(_loc45_[0]) > _loc42_)
                  {
                     _loc42_ = int(_loc45_[0]);
                     _loc26_ = int(_loc45_[1]);
                     _loc34_ = int(_loc45_[2]);
                  }
               }
               _thane.dragonSoulType = _loc42_;
               _thane.dragonSoulGrade = _loc26_;
               _thane.dragonSoulGp = _loc34_;
            }
            if(_loc2_.army.hasTransferGrade)
            {
               _thane.vocationGrades = _loc2_.army.transferGrade;
            }
            if(_loc2_.army.hasChangeBranch)
            {
               _thane.vocationIndex = _loc2_.army.changeBranch;
            }
            if(_isRobot)
            {
               _loc13_ = SpaceTemplateManager.instance.getRobotInfo(_thane.userId);
               _thane.nickName = _loc13_.nickName;
               _thane.state = _loc13_.state;
            }
         }
         if(_loc2_.army.armyPawn.length > 0)
         {
            _loc55_ = 0;
            while(_loc55_ < _loc2_.army.armyPawn.length)
            {
               _loc32_ = _loc2_.army.armyPawn[_loc55_] as SimpleArmyPawnMsg;
               _loc55_++;
            }
         }
         _loc53_ = 0;
         while(_loc53_ < _loc2_.item.length)
         {
            _loc40_ = _loc2_.item[_loc53_] as SimpleItemInfoMsg;
            _loc8_ = new GoodsInfo();
            _loc8_.id = _loc40_.id;
            _loc8_.bagType = _loc40_.bagType;
            _loc8_.objectId = _loc40_.objectId;
            _loc8_.pos = _loc40_.pos;
            _loc8_.templateId = _loc40_.templateId;
            _loc8_.isBinds = _loc40_.bind;
            _loc8_.count = _loc40_.count;
            _loc8_.beginDate = DateFormatter.parse(_loc40_.beginDate,"YYYY-MM-DD hh:mm:ss");
            _loc8_.validDate = _loc40_.validDate;
            _loc8_.strengthenGrade = _loc40_.strengthenGrade;
            _loc8_.join1 = _loc40_.join_1;
            _loc8_.join2 = _loc40_.join_2;
            _loc8_.join3 = _loc40_.join_3;
            _loc8_.join4 = _loc40_.join_4;
            _loc8_.randomSkill1 = _loc40_.randomSkill_1;
            _loc8_.randomSkill2 = _loc40_.randomSkill_2;
            _loc8_.randomSkill3 = _loc40_.randomSkill_3;
            _loc8_.randomSkill4 = _loc40_.randomSkill_4;
            _loc8_.randomSkill5 = _loc40_.randomSkill_5;
            _loc8_.mouldGrade = _loc40_.mouldGrade;
            if(_loc40_.hasLifeSkill)
            {
               _loc8_.enchantSkillId = _loc40_.lifeSkill;
            }
            equipDic[_loc8_.pos + "_" + _loc8_.objectId + "_" + _loc8_.bagType] = _loc8_;
            _loc53_++;
         }
         _thane.fashionMsg.gp = _loc39_.fashionGp;
         _thane.fashionMsg.grades = _loc39_.fashionGrades;
         var _loc48_:int = int(_thane.id);
         if(_loc39_.fashionHat)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.pos = 9;
            _loc9_.bagType = 4;
            _loc9_.templateId = int(_loc39_.fashionHat);
            equipDic[_loc9_.pos + "_" + _loc48_ + "_" + _loc9_.bagType] = _loc9_;
         }
         if(_loc39_.fashionCloth)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.pos = 10;
            _loc9_.bagType = 4;
            _loc9_.templateId = int(_loc39_.fashionCloth);
            equipDic[_loc9_.pos + "_" + _loc48_ + "_" + _loc9_.bagType] = _loc9_;
         }
         if(_loc39_.fashionArm)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.pos = 11;
            _loc9_.bagType = 4;
            _loc9_.templateId = int(_loc39_.fashionArm);
            equipDic[_loc9_.pos + "_" + _loc48_ + "_" + _loc9_.bagType] = _loc9_;
         }
         if(_loc39_.fashionWing)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.pos = 8;
            _loc9_.bagType = 4;
            _loc9_.templateId = int(_loc39_.fashionWing);
            equipDic[_loc9_.pos + "_" + _loc48_ + "_" + _loc9_.bagType] = _loc9_;
         }
         if(_equipDic)
         {
            _loc3_ = _equipDic["2_" + _thane.id + "_" + 4];
            _loc18_ = _equipDic["0_" + _thane.id + "_" + 4];
            _loc30_ = _equipDic["8_" + _thane.id + "_" + 4];
            _loc51_ = _equipDic["9_" + _thane.id + "_" + 4];
            _loc33_ = _equipDic["10_" + _thane.id + "_" + 4];
            _loc6_ = _equipDic["11_" + _thane.id + "_" + 4];
            _thane.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
            _thane.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc18_);
            _thane.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc30_);
            _thane.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc51_);
            _thane.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc33_);
            _thane.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
         }
         _loc53_ = 0;
         while(_loc53_ < _loc2_.star.length)
         {
            _loc10_ = _loc2_.star[_loc53_] as SimpleStarInfoMsg;
            _loc38_ = new StarInfo();
            _loc38_.id = _loc10_.id;
            _loc38_.bagType = _loc10_.bagType;
            _loc38_.pos = _loc10_.pos;
            _loc38_.tempId = _loc10_.templateId;
            _loc38_.gp = _loc10_.gp;
            _loc38_.grade = _loc10_.grade;
            equipDic[_loc38_.pos + "_0_" + _loc38_.bagType] = _loc38_;
            _loc53_++;
         }
         _cardFightInfoList = [];
         _loc53_ = 0;
         while(_loc53_ < _loc2_.cardInfos.length)
         {
            _loc49_ = _loc2_.cardInfos[_loc53_] as SimpleMagicCardInfoMsg;
            _loc46_ = new MagicCardFightInfo();
            _loc46_.templeteId = _loc49_.templateId;
            _loc46_.gardes = _loc49_.grades;
            _cardFightInfoList.push(_loc46_);
            _loc53_++;
         }
         if(_loc2_.starAdd)
         {
            _loc20_ = int(_loc2_.starAdd.length);
            _loc63_ = 0;
            while(_loc63_ < _loc20_)
            {
               _loc7_ = _loc2_.starAdd[_loc63_] as SimpleStarAdditionMsg;
               _loc37_ = new StarTroughInfo();
               _loc37_.pos = _loc7_.pos;
               _loc37_.grade = _loc7_.grade;
               _thane.starTroughs[_loc7_.pos] = _loc37_;
               _loc63_++;
            }
         }
         for each(var _loc16_:SimpleWatchMsg in _loc2_.watch)
         {
            _loc17_ = _thane.battleGuardInfo.getSocketInfo(_loc16_.gridType,_loc16_.gridPos - 1);
            _loc17_.addItem(_loc16_.jion1,0);
            _loc17_.addItem(_loc16_.jion2,1);
            _loc17_.addItem(_loc16_.jion3,2);
            _loc17_.state = 1;
            _loc17_.commit();
         }
         showBtns();
         tryShow();
         _thane.equipDic = new SimpleDictionary(true);
         _thane.equipDic.setDictionary(equipDic);
      }
      
      private function get equipDic() : SimpleDictionary
      {
         if(!_equipDic)
         {
            _equipDic = new SimpleDictionary(true);
         }
         return _equipDic;
      }
      
      private function __showMountInfoFrame(param1:SLGSocketEvent) : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4459,__showMountInfoFrame);
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountInfoMsg = new MountInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MountInfoMsg;
         var _loc4_:SimpleMountInfo = SimpleMountInfo.createFromMountInfoMsg(_loc2_);
         if(_thane.vocationGrades <= 0)
         {
            _loc4_.star = -1;
         }
         var _loc5_:MountInfoView = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountInfoView");
         _loc5_.data = _loc4_;
         _loc5_.show();
      }
      
      private function __simpleInfoHandler(param1:RequestInfoEvent) : void
      {
         if(param1.orientation != 1)
         {
            return;
         }
         if(_thane)
         {
            if(_thane.userId != param1.data.userId)
            {
               return;
            }
            copyThaneInfo(_thane,param1.data);
         }
         else
         {
            _thane = param1.data;
         }
         tryShow();
      }
      
      private function clean() : void
      {
         if(_equipInfoView && _equipInfoView.parent)
         {
            _equipInfoView.parent.removeChild(_equipInfoView);
         }
         if(_attributeView && _attributeView.parent)
         {
            _attributeView.parent.removeChild(_attributeView);
         }
         if(_infoView && _infoView.parent)
         {
            _infoView.parent.removeChild(_infoView);
         }
         if(_guardView && _guardView.parent)
         {
            _guardView.parent.removeChild(_guardView);
         }
         if(_dragonTalkerView && _dragonTalkerView.parent)
         {
            _dragonTalkerView.parent.removeChild(_dragonTalkerView);
         }
         if(_tattooView && _tattooView.parent)
         {
            _tattooView.parent.removeChild(_tattooView);
         }
      }
      
      private function copyThaneInfo(param1:ThaneInfo, param2:ThaneInfo) : void
      {
         var _loc3_:ThaneInfo = null;
         param1.userId = param2.userId;
         param1.nickName = param2.nickName;
         param1.templateId = param2.job;
         param1.hideFashion = param2.hideFashion;
         param1.job = param2.job;
         param1.sexs = param2.sexs;
         param1.pics = param2.pics;
         param1.camp = param2.camp;
         param1.state = param2.state;
         param1.consortiaID = param2.consortiaID;
         param1.strategy = param2.strategy;
         param1.consortiaName = param2.consortiaName;
         param1.consortiaOffer = param2.consortiaOffer;
         param1.consortiaTotalOffer = param2.consortiaTotalOffer;
         param1.claimId = param2.claimId;
         param1.claimName = param2.claimName;
         param1.grades = param2.grades;
         param1.gp = param2.gp;
         param1.offlineGp = param2.offlineGp;
         param1.repute = param2.repute;
         param1.logOutTime = param2.logOutTime;
         param1.dutyId = param2.dutyId;
         param1.parameter1 = param2.parameter1;
         param1.playerOrdeInfo = param2.playerOrdeInfo;
         param1.fightingCapacity = param2.fightingCapacity;
         param1.matchWin = param2.matchWin;
         param1.matchFailed = param2.matchFailed;
         param1.right = param2.right;
         param1.relation = param2.relation;
         param1.friendGp = param2.friendGp;
         param1.friendGrade = param2.friendGrade;
         param1.snsInfo = param2.snsInfo;
         param1.jewelGrades = param2.jewelGrades;
         param1.fateTotalGp = param2.fateTotalGp;
         param1.fateGrades = param2.fateGrades;
         if(_isRobot)
         {
            _loc3_ = SpaceTemplateManager.instance.getRobotInfo(_thane.userId);
            param1.nickName = _loc3_.nickName;
            param1.state = _loc3_.state;
         }
      }
      
      private function needShowPetImg() : Boolean
      {
         if(!_thane)
         {
            return false;
         }
         return _thane.grades >= 50;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tabGroup)
         {
            _tabGroup.removeEventListener("change",__panelChangeHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4125,__receiveEquipHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4459,__showMountInfoFrame);
         PlayerManager.instance.removeEventListener("REQUEST_SIMPLEANDSNS_INFO",__simpleInfoHandler);
         PlayerManager.instance.removeEventListener("QUERY_PETDATA_RESULT",__queryPetDataResultHandler);
         if(_attackAttrbite)
         {
            _attackAttrbite.removeEventListener("response",__hideHandler);
         }
         NotificationManager.instance.removeEventListener("CHECKPLAYERITEMCLICK",__itemClickhandler);
         PlayerManager.instance.removeEventListener("QUERY_CHILDDATA_RESULT",__queryChildDataResultHandler);
      }
      
      private function __itemClickhandler(param1:NotificationEvent) : void
      {
         switch(param1.data)
         {
            case 0:
               break;
            case 1:
               sendRequestPetInfo(null);
               break;
            case 2:
               sendRequestMountInfo(null);
               break;
            case 3:
               sendRequestChildInfo(null);
               break;
            case 5:
               showTitanInfo();
               break;
            case 6:
               showArtifactInfo();
               break;
            case 7:
               showGoddessInfo();
               break;
            case 8:
               showMonsterInfo();
               break;
            case 9:
               showRevengerInfo();
               break;
            case 10:
               showDevilArmorInfo();
               break;
            case 11:
               showGoddessEquipInfo();
               break;
            case 12:
               showTheseusoulInfo();
         }
      }
      
      private function showMonsterInfo() : void
      {
         if(!_thane.monsterInfo || _thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noMonsterInfo.enterwar"));
            return;
         }
         if(_thane.monsterInfo && _thane.monsterInfo.tempInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noMonsterInfo.inwar"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("monster","LOOK_UP_MONSTER",_thane.monsterInfo);
      }
      
      private function showRevengerInfo() : void
      {
         if(!_thane.avengerInfo || !_thane.isAvenger)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noRevengerInfo.enterwar"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("avenger","OTHER_INFO_FRAME",_thane);
      }
      
      private function showDevilArmorInfo() : void
      {
         if(!_thane.isAvenger || !_thane.avengerInfo || !_thane.avengerInfo.devilArmorInfo || !_thane.avengerInfo.devilArmorInfo)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noDevilArmorInfo.Info"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("avenger","OTHER_INFO_DEVILARMOR_FRAME",_thane.avengerInfo);
      }
      
      private function showGoddessEquipInfo() : void
      {
         if(!_thane.goddessInfo || _thane.goddessInfo.templateId <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noGoddessInfo.enterwar"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("goddess","LOOK_UP_GODDESS_EQUIP",_thane.goddessInfo);
      }
      
      private function showTheseusoulInfo() : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseussoul",3,_thane);
      }
      
      private function __attributeHandler(param1:BagEvent) : void
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,212,520);
         }
         TweenLite.killTweensOf(_rect);
         if(_attackAttrbite && _currentCount > _totalCount)
         {
            _currentCount = 2;
            _attackAttrbite.thane = _thane;
            return;
         }
         _currentCount = 2;
         if(!_attackAttrbite)
         {
            _attackAttrbite = ComponentFactory.Instance.creatComponentByStylename("army.ThaneAttribute");
            _attackAttrbite.addEventListener("response",__hideHandler);
            _attackAttrbite.thane = _thane;
            _attackAttrbite.x = -197;
            _attackAttrbite.y = 20;
            addChild(_attackAttrbite);
            _rect.x = -232;
            _attackAttrbite.scrollRect = _rect;
            TweenLite.to(_rect,0.7,{
               "x":-20,
               "onUpdate":updateRec
            });
         }
         else if(_rect.x < -20 || _attackAttrbite.x != -197 || _attackAttrbite.y != 40)
         {
            _attackAttrbite.dispose();
            _attackAttrbite = null;
         }
         else
         {
            _rect.x = -20;
            TweenLite.to(_rect,0.7,{
               "x":-232,
               "onUpdate":updateRec,
               "onComplete":completeTween
            });
         }
      }
      
      private function updateRec() : void
      {
         if(_attackAttrbite)
         {
            _attackAttrbite.scrollRect = _rect;
         }
      }
      
      private function completeTween() : void
      {
         TweenLite.killTweensOf(_rect);
         if(_attackAttrbite)
         {
            _attackAttrbite.dispose();
            _attackAttrbite = null;
         }
      }
      
      private function __hideHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
         {
            param1.currentTarget.removeEventListener("response",__hideHandler);
            __attributeHandler(null);
         }
      }
      
      private function sendRequestPetInfo(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!needShowPetImg())
         {
            return;
         }
         if(!_thane.isXmlItem && !isPerkinThaneInfo)
         {
            PlayerManager.instance.lookingPlayerName = _thane.nickName;
            PlayerManager.instance.sendRequestPetData(_thane.userId);
         }
         else if(_thane.enterWarPet)
         {
            showPetTipData(_thane.enterWarPet);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("playerinfo.PlayerInfoFrameII.notHasPet");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function sendRequestChildInfo(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!needShowChild())
         {
            return;
         }
         if(!_thane.isXmlItem && !isPerkinThaneInfo)
         {
            PlayerManager.instance.lookingPlayerName = _thane.nickName;
            PlayerManager.instance.sendRequistChildData(_thane.userId);
         }
         else if(_thane.enterChildData)
         {
            showChildData(_thane.enterChildData);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("playerinfo.PlayerInfoFrameII.notHasChild");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function needShowChild() : Boolean
      {
         return _thane && _thane.grades >= 70;
      }
      
      private function showTitanInfo() : void
      {
         if(!_thane.titanInfo || _thane.titanInfo.templateId <= 0 || _thane.titanInfo.userId <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noTitanInfo"));
            return;
         }
         FrameControllerManager.instance.dragonTitanControler.titanData = _thane.titanInfo;
         FrameControllerManager.instance.openControllerByInfo("dragontitan","TITAN_DATA_CHECK");
      }
      
      private function showArtifactInfo() : void
      {
         if(!_thane.artifactInfo || _thane.artifactInfo.templateId <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noArtifactInfo"));
            return;
         }
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.OPEN);
         FrameControllerManager.instance.openControllerByInfo("ancientartifact",2,_thane.artifactInfo);
      }
      
      private function showGoddessInfo() : void
      {
         if(!_thane.goddessInfo || _thane.goddessInfo.templateId <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.noGoddessInfo.enterwar"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("goddess","LOOK_UP_GODDESS",_thane.goddessInfo);
      }
      
      private function sendRequestMountInfo(param1:MouseEvent) : void
      {
         var _loc2_:MountInfoView = null;
         if(_data is SortData || isPerkinThaneInfo)
         {
            if(!_thane)
            {
               return;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("playerinfo.MountInfoView");
            _loc2_.data = _thane.mountInfo;
            _loc2_.show();
         }
         else
         {
            SocketManager.instance.addEventListener("SLGSocketEvent" + 4459,__showMountInfoFrame);
            MountsManager.instance.mountOperateSend(5,0,0,_thane.userId);
         }
      }
      
      private function __queryPetDataResultHandler(param1:RequestInfoEvent) : void
      {
         if(isDie)
         {
            return;
         }
         var _loc2_:PetData = param1.info as PetData;
         if(!_loc2_ || _loc2_.userId != _thane.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PlayerInfoFrameII.petBtn.notEnterWarPet"));
            return;
         }
         showPetTipData(_loc2_);
      }
      
      private function __queryChildDataResultHandler(param1:RequestInfoEvent) : void
      {
         var _loc2_:String = null;
         if(isDie)
         {
            return;
         }
         var _loc3_:ChildData = param1.info as ChildData;
         if(_loc3_)
         {
            showChildData(_loc3_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("playerinfo.PlayerInfoFrameII.notHasChild");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function showChildData(param1:ChildData) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","look_information",param1);
      }
      
      private function showPetTipData(param1:PetData) : void
      {
         FrameControllerManager.instance.openControllerByInfo("pet","LOOKUP_FRAME",param1);
      }
      
      private function tryShow() : void
      {
         _currentCount = _currentCount + 1;
         if(_currentCount % 2 == 0)
         {
            __attributeHandler(null);
            if(_thane && _thane.dragonTalkerInfo.isDragonTalker)
            {
               _tabGroup.selectIndex = 1;
            }
            else
            {
               _tabGroup.selectIndex = 0;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(_rect);
         _rect = null;
         ObjectUtils.disposeObject(_starImg);
         _starImg = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_attackAttrbite);
         _attackAttrbite = null;
         if(_equipDic)
         {
            _equipDic.clear();
            _equipDic = null;
         }
         ObjectUtils.disposeObject(_tattooButton);
         _tattooButton = null;
         ObjectUtils.disposeObject(_guardButton);
         _guardButton = null;
         ObjectUtils.disposeObject(_guardView);
         _guardView = null;
         ObjectUtils.disposeObject(_dragonSoulButton);
         _dragonSoulButton = null;
         ObjectUtils.disposeObject(_dragonSoulView);
         _dragonSoulView = null;
         ObjectUtils.disposeObject(_tattooView);
         _tattooView = null;
         ObjectUtils.disposeObject(_dragonTalkerBtn);
         _dragonTalkerBtn = null;
         ObjectUtils.disposeObject(_dragonTalkerView);
         _dragonTalkerView = null;
         super.dispose();
      }
   }
}

