package playerinfo.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class EquipCheckList extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _lvTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _thane:ThaneInfo;
      
      private var _isCross:Boolean;
      
      private var _equipDic:SimpleDictionary;
      
      private var _fateTipInfo:MultipleDictionaryInfo;
      
      private var _fashionItem:TextButton;
      
      private var _line01:Bitmap;
      
      private var _soulItem:TextButton;
      
      private var _line02:Bitmap;
      
      private var _seniorJewelItem:TextButton;
      
      private var _line03:Bitmap;
      
      private var _fateRotaryItem:TextButton;
      
      private var _line04:Bitmap;
      
      private var _childItem:TextButton;
      
      private var _childSprite:Component;
      
      private var _childOverImg:Scale9CornerImage;
      
      private var _line07:Bitmap;
      
      private var _line08:Bitmap;
      
      private var _line09:Bitmap;
      
      private var _line10:Bitmap;
      
      private var _petItem:TextButton;
      
      private var _petSprite:Component;
      
      private var _petOverImg:Scale9CornerImage;
      
      private var _line05:Bitmap;
      
      private var _mountItem:TextButton;
      
      private var _line06:Bitmap;
      
      private var _starItem:TextButton;
      
      private var _soulSprite:Component;
      
      private var _soulImg:Scale9CornerImage;
      
      private var _fateSprite:Component;
      
      private var _fateImg:Scale9CornerImage;
      
      private var _starSprite:Component;
      
      private var _starImg:Scale9CornerImage;
      
      private var _conciseImg:Image;
      
      private var _conciseItem:TextButton;
      
      private var _conciseSprite:Component;
      
      private var _dragonTitanItem:TextButton;
      
      private var _petHallowsImage:Image;
      
      private var _petHallowsItem:TextButton;
      
      private var _petHallowsSprite:Component;
      
      private var _fightList:Array;
      
      private var _artifactItem:TextButton;
      
      private var _line11:Bitmap;
      
      private var _line12:Bitmap;
      
      private var _goddessItem:TextButton;
      
      private var _goddessSprite:Component;
      
      private var _line13:Bitmap;
      
      private var _monsterItem:TextButton;
      
      private var _monsterSprite:Component;
      
      private var _line14:Bitmap;
      
      private var _revengerItem:TextButton;
      
      private var _revengerSprite:Component;
      
      private var _line15:Bitmap;
      
      private var _devilArmorItem:TextButton;
      
      private var _devilArmorSprite:Component;
      
      private var _line16:Bitmap;
      
      private var _goddessEquipItem:TextButton;
      
      private var _goddessEquipSprite:Component;
      
      private var _line17:Bitmap;
      
      private var _theseusoulItem:TextButton;
      
      private var _theseusoulSprite:Component;
      
      private var _line18:Bitmap;
      
      private var _scrolPanel:ScrollPanel;
      
      public function EquipCheckList(param1:ThaneInfo, param2:Boolean, param3:SimpleDictionary, param4:Array)
      {
         super();
         _thane = param1;
         _isCross = param2;
         _equipDic = param3;
         _fightList = param4;
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkmenuBg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkVbox");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.JewelSuitLevel");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ScrollPanel");
         addChild(_bg);
         addChild(_scrolPanel);
         _bg.width = 200;
         _bg.height = 294;
         _scrolPanel.width = 200;
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vbox,true);
         _scrolPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         _fashionItem.addEventListener("click",__itemclickHandler);
         _petItem.addEventListener("click",__itemclickHandler);
         _mountItem.addEventListener("click",__itemclickHandler);
         _childItem.addEventListener("click",__itemclickHandler);
         _dragonTitanItem.addEventListener("click",__itemclickHandler);
         _artifactItem.addEventListener("click",__itemclickHandler);
         _goddessItem.addEventListener("click",__itemclickHandler);
         _monsterItem.addEventListener("click",__itemclickHandler);
         _revengerItem.addEventListener("click",__itemclickHandler);
         _devilArmorItem.addEventListener("click",__itemclickHandler);
         _goddessEquipItem.addEventListener("click",__itemclickHandler);
         _theseusoulItem.addEventListener("click",__itemclickHandler);
         _petSprite.addEventListener("mouseOver",_sOverHandler);
         _petSprite.addEventListener("mouseOut",_sOutHandler);
         _soulSprite.addEventListener("mouseOver",_sOverHandler);
         _soulSprite.addEventListener("mouseOut",_sOutHandler);
         _fateSprite.addEventListener("mouseOver",_sOverHandler);
         _fateSprite.addEventListener("mouseOut",_sOutHandler);
         _starSprite.addEventListener("mouseOver",_sOverHandler);
         _starSprite.addEventListener("mouseOut",_sOutHandler);
         _conciseSprite.addEventListener("mouseOver",_sOverHandler);
         _conciseSprite.addEventListener("mouseOut",_sOutHandler);
         _petHallowsSprite.addEventListener("mouseOver",_sOverHandler);
         _petHallowsSprite.addEventListener("mouseOut",_sOutHandler);
         if(_monsterSprite)
         {
            _monsterSprite.addEventListener("mouseOver",_sOverHandler);
            _monsterSprite.addEventListener("mouseOut",_sOutHandler);
         }
         if(_revengerSprite)
         {
            _revengerSprite.addEventListener("mouseOver",_sOverHandler);
            _revengerSprite.addEventListener("mouseOut",_sOutHandler);
         }
         if(_devilArmorSprite)
         {
            _devilArmorSprite.addEventListener("mouseOver",_sOverHandler);
            _devilArmorSprite.addEventListener("mouseOut",_sOutHandler);
         }
         if(_goddessEquipSprite)
         {
            _goddessEquipSprite.addEventListener("mouseOver",_sOverHandler);
            _goddessEquipSprite.addEventListener("mouseOut",_sOutHandler);
         }
      }
      
      private function __itemclickHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _fashionItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",0);
               break;
            case _petItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",1);
               break;
            case _mountItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",2);
               break;
            case _childItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",3);
               break;
            case _dragonTitanItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",5);
               break;
            case _artifactItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",6);
               break;
            case _goddessItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",7);
               break;
            case _monsterItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",8);
               break;
            case _revengerItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",9);
               break;
            case _devilArmorItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",10);
               break;
            case _goddessEquipItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",11);
               break;
            case _theseusoulItem:
               NotificationManager.instance.sendNotification("CHECKPLAYERITEMCLICK",12);
         }
         this.dispose();
      }
      
      private function initData() : void
      {
         var _loc12_:Sprite = null;
         var _loc9_:MultipleDictionaryInfo = null;
         var _loc11_:String = null;
         var _loc1_:Array = null;
         var _loc6_:int = 0;
         var _loc10_:Array = null;
         var _loc16_:int = 0;
         var _loc14_:int = 0;
         var _loc2_:SkillTempInfo = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc5_:Sprite = null;
         var _loc15_:Sprite = null;
         var _loc7_:Sprite = null;
         var _loc17_:Sprite = null;
         var _loc3_:Sprite = null;
         if(_lvTxt && _lvTxt.parent)
         {
            _lvTxt.parent.removeChild(_lvTxt);
         }
         if(_petSprite && _petSprite.parent)
         {
            _petSprite.parent.removeChild(_petSprite);
         }
         if(_soulSprite && _soulSprite.parent)
         {
            _soulSprite.parent.removeChild(_soulSprite);
         }
         if(_fateSprite && _fateSprite.parent)
         {
            _fateSprite.parent.removeChild(_fateSprite);
         }
         if(_conciseSprite && _conciseSprite.parent)
         {
            _conciseSprite.parent.removeChild(_conciseSprite);
         }
         if(_starSprite && _starSprite.parent)
         {
            _starSprite.parent.removeChild(_starSprite);
         }
         if(_childSprite && _childSprite.parent)
         {
            _childSprite.parent.removeChild(_childSprite);
         }
         if(_petHallowsSprite && _petHallowsSprite.parent)
         {
            _petHallowsSprite.parent.removeChild(_petHallowsSprite);
         }
         ObjectUtils.disposeAllChildren(_vbox);
         _fashionItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkFashionItemBtn");
         _fashionItem.text = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.checkFashion");
         _soulItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkSoulItemBtn");
         _soulItem.text = LanguageMgr.GetTranslation("HigherGradeOpenTipView.content19");
         _soulSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.SoulItem");
         _soulImg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _soulImg.alpha = 0;
         _seniorJewelItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkSeniorJewelItemBtn");
         _seniorJewelItem.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
         _fateRotaryItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkFateRotaryItemBtn");
         _fateRotaryItem.text = LanguageMgr.GetTranslation("faterotary.FateRotaryRunFrame.FrameTitle");
         _fateSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.fateItem");
         _fateImg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _fateImg.alpha = 0;
         _childItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkChildBtn");
         _childItem.text = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.checkChild");
         _childSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _childOverImg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _petItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkPetBtn");
         _petItem.text = LanguageMgr.GetTranslation("PetAddPointTip.btnTxt");
         _petSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _petOverImg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _mountItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkMountBtn");
         _mountItem.text = LanguageMgr.GetTranslation("tasktracetip.view.VipMountActivateTipView.text");
         _monsterItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.monsterItemBtn");
         _monsterItem.text = LanguageMgr.GetTranslation("playerInfo.checkMonster.frameTitle");
         _monsterSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _revengerItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.revengerItemBtn");
         _revengerItem.text = LanguageMgr.GetTranslation("playerInfo.checkAvanger.frameTitle");
         _revengerSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _devilArmorItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.devilArmorBtn");
         _devilArmorItem.text = LanguageMgr.GetTranslation("playerInfo.devilArmor.frameTitle");
         _devilArmorSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _goddessEquipItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.goddessEquipBtn");
         _goddessEquipItem.text = LanguageMgr.GetTranslation("playerInfo.goddessEquip.frameTitle");
         _goddessEquipSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _theseusoulItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.theseusoulEquipBtn");
         _theseusoulItem.text = LanguageMgr.GetTranslation("playerinfo.theseusoulEquipBtn.frameTitle");
         _theseusoulSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petNotOpenItem");
         _starItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkStarBtn");
         _starItem.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.title");
         _starSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.starItem");
         _starImg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _starImg.alpha = 0;
         _line01 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line02 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line03 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line04 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line05 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line06 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line07 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line08 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line09 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line10 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line11 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line12 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line13 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line14 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line15 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line16 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line17 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _line18 = ComponentFactory.Instance.creatBitmap("asset.playerinfo.checkPlayerLine");
         _conciseImg = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _conciseItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.conciseItem");
         _conciseItem.text = LanguageMgr.GetTranslation("armyII.viewII.equip.ConciseFrame.TitleTxt");
         _conciseSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.conciseSprite");
         _conciseImg.alpha = 0;
         _dragonTitanItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkDragonTitanItemBtn");
         _dragonTitanItem.text = LanguageMgr.GetTranslation("playerinfo.checkDragonTitan");
         _artifactItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.rareweaponItemBtn");
         _artifactItem.text = LanguageMgr.GetTranslation("playerinfo.checkArtifact");
         _petHallowsImage = ComponentFactory.Instance.creatComponentByStylename("playerinfo.selectedBg");
         _petHallowsItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.checkPetHallowsItemBtn");
         _petHallowsItem.text = LanguageMgr.GetTranslation("playerinfo.checkPetHallowsItem.text");
         _petHallowsSprite = ComponentFactory.Instance.creatComponentByStylename("playerinfo.petHallowsSprite");
         _petHallowsImage.alpha = 0;
         _goddessItem = ComponentFactory.Instance.creatComponentByStylename("playerinfo.goddessItemBtn");
         _goddessItem.text = LanguageMgr.GetTranslation("playerinfo.goddessItem.text");
         _goddessSprite = new Component();
         var _loc4_:int = 0;
         _vbox.beginChanges();
         if(VersionSwitch.THESESOUL && _thane.vocationIndex > 0)
         {
            _vbox.addChild(_theseusoulSprite);
            _theseusoulSprite.addChild(_theseusoulItem);
            _theseusoulSprite.addChild(_line18);
            _theseusoulSprite.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.theseusoulCheck");
         }
         if(VersionSwitch.DEVIL_ARMOR && Boolean(VersionSwitch.AVENGER) && Boolean(_thane.isAvenger))
         {
            _vbox.addChild(_devilArmorSprite);
            _devilArmorSprite.addChild(_devilArmorItem);
            _devilArmorSprite.addChild(_line16);
            _devilArmorSprite.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.devilArmorCheck");
         }
         if(VersionSwitch.GODDESS_OPEN && _thane.vocationGrades > 0 && Boolean(VersionSwitch.GODDESS_EQUIP))
         {
            _vbox.addChild(_goddessEquipSprite);
            _goddessEquipSprite.addChild(_goddessEquipItem);
            _goddessEquipSprite.addChild(_line17);
            _goddessEquipItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.goddessEquipCheck");
         }
         if(_thane.grades >= 70 && Boolean(VersionSwitch.MONSTER))
         {
            _vbox.addChild(_monsterSprite);
            _monsterSprite.addChild(_monsterItem);
            _monsterSprite.addChild(_line14);
            _monsterSprite.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.monsterCheck");
         }
         if(VersionSwitch.AVENGER && Boolean(_thane.isAvenger))
         {
            _vbox.addChild(_revengerSprite);
            _revengerSprite.addChild(_revengerItem);
            _revengerSprite.addChild(_line15);
            _revengerSprite.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.revengerCheck");
         }
         if(VersionSwitch.GODDESS_OPEN && _thane.vocationGrades > 0)
         {
            _vbox.addChild(_goddessSprite);
            _goddessSprite.addChild(_goddessItem);
            _goddessSprite.addChild(_line13);
            _goddessItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.goddessCheck");
         }
         if(_thane.isChangeJob)
         {
            _vbox.addChild(_petHallowsSprite);
            _petHallowsSprite.addChild(_petHallowsItem);
            _petHallowsSprite.addChild(_line10);
            _petHallowsSprite.addChild(_petHallowsImage);
            _petHallowsSprite.tipData = _thane;
         }
         if(_thane.titanInfo && _thane.titanInfo.templateId > 0)
         {
            _loc12_ = new Sprite();
            _vbox.addChild(_loc12_);
            _loc12_.addChild(_dragonTitanItem);
            _loc12_.addChild(_line09);
            _dragonTitanItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.itemTips04");
         }
         if(VersionSwitch.EQUIP_CONCISE && _thane.vocationGrades > 0)
         {
            _vbox.addChild(_conciseSprite);
            _conciseSprite.addChild(_conciseItem);
            _conciseSprite.addChild(_line08);
            _conciseSprite.addChild(_conciseImg);
            _conciseSprite.tipData = _thane;
         }
         if(_thane.grades >= 35)
         {
            _vbox.addChild(_soulSprite);
            if(_thane.jewelGrades >= 80 && _thane.vocationLevel > 0)
            {
               _soulSprite.addChild(_seniorJewelItem);
               _soulSprite.addChild(_line01);
               _seniorJewelItem.tipData = _thane;
            }
            else
            {
               _soulSprite.addChild(_soulItem);
               _soulSprite.addChild(_line02);
               _soulItem.tipData = _thane;
            }
            _soulSprite.addChild(_soulImg);
            _soulSprite.tipData = _thane;
         }
         if(_thane.grades >= 55)
         {
            _vbox.addChild(_fateSprite);
            _fateSprite.addChild(_fateRotaryItem);
            _fateSprite.addChild(_line03);
            _fateSprite.addChild(_fateImg);
            _loc9_ = new MultipleDictionaryInfo();
            _loc11_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FateTip1",_thane.fateTotalGp * 10);
            _loc9_.addItem(_loc11_,null);
            if(_thane.fateGrades)
            {
               _loc1_ = _thane.fateGrades.split("|");
            }
            else
            {
               _loc1_ = [];
            }
            _loc6_ = 0;
            while(_loc6_ < _loc1_.length)
            {
               _loc10_ = _loc1_[_loc6_].split(",");
               if(_loc10_.length >= 2)
               {
                  _loc16_ = int(_loc10_[0]);
                  _loc14_ = int(_loc10_[1]);
                  _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc16_);
                  _loc11_ = LanguageMgr.GetTranslation("public.grade") + "  " + _loc14_;
                  _loc13_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip","  " + _loc2_.TemplateName);
                  _loc8_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip",_loc11_);
                  _loc9_.addItem(_loc13_ + "       " + _loc8_,null);
               }
               _loc6_++;
            }
            _fateSprite.tipData = _loc9_;
         }
         if(_thane.grades >= 70)
         {
            _loc5_ = new Sprite();
            _vbox.addChild(_loc5_);
            _loc5_.addChild(_childItem);
            _childItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.checkChild");
            _loc5_.addChild(_line07);
         }
         if(_thane.grades >= 50)
         {
            _loc15_ = new Sprite();
            _vbox.addChild(_loc15_);
            _loc15_.addChild(_petItem);
            _petItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.itemTips01");
            _loc15_.addChild(_line04);
         }
         if(_thane.grades >= 18)
         {
            _loc7_ = new Sprite();
            _vbox.addChild(_loc7_);
            _loc7_.addChild(_mountItem);
            _mountItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.itemTips02");
            _loc7_.addChild(_line05);
         }
         if(_thane.grades >= 18)
         {
            _vbox.addChild(_starSprite);
            _starSprite.addChild(_starItem);
            _starSprite.addChild(_line06);
            _starSprite.addChild(_starImg);
            _starSprite.tipData = StarHelper.checkExistStarInfoInDic(_equipDic) ? {
               "starList":_equipDic,
               "troughList":_thane.starTroughs
            } : "0";
         }
         if(_thane.artifactInfo && _thane.artifactInfo.templateId > 0)
         {
            _loc17_ = new Sprite();
            _vbox.addChild(_loc17_);
            _loc17_.addChild(_artifactItem);
            _loc17_.addChild(_line11);
            _artifactItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.itemTips05");
         }
         if(_thane.grades >= 10)
         {
            _loc3_ = new Sprite();
            _vbox.addChild(_loc3_);
            _loc3_.addChild(_fashionItem);
            _loc3_.addChild(_line12);
            _fashionItem.tipData = LanguageMgr.GetTranslation("playerinfo.view.EquipCheckList.itemTips03");
         }
         _vbox.commitChanges();
         _scrolPanel.invalidateViewport();
      }
      
      private function removeEvent() : void
      {
         _fashionItem.removeEventListener("click",__itemclickHandler);
         _petItem.removeEventListener("click",__itemclickHandler);
         _mountItem.removeEventListener("click",__itemclickHandler);
         _childItem.removeEventListener("click",__itemclickHandler);
         _dragonTitanItem.removeEventListener("click",__itemclickHandler);
         _artifactItem.removeEventListener("click",__itemclickHandler);
         _goddessItem.removeEventListener("click",__itemclickHandler);
         _monsterItem.removeEventListener("click",__itemclickHandler);
         _revengerItem.removeEventListener("click",__itemclickHandler);
         _devilArmorItem.removeEventListener("click",__itemclickHandler);
         _goddessEquipItem.removeEventListener("click",__itemclickHandler);
         _theseusoulItem.removeEventListener("click",__itemclickHandler);
         if(_petSprite)
         {
            _petSprite.removeEventListener("mouseOver",_sOverHandler);
            _petSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_soulSprite)
         {
            _soulSprite.removeEventListener("mouseOver",_sOverHandler);
            _soulSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_fateSprite)
         {
            _fateSprite.removeEventListener("mouseOver",_sOverHandler);
            _fateSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_starSprite)
         {
            _starSprite.removeEventListener("mouseOver",_sOverHandler);
            _starSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_conciseSprite)
         {
            _conciseSprite.removeEventListener("mouseOver",_sOverHandler);
            _conciseSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_petHallowsSprite)
         {
            _petHallowsSprite.removeEventListener("mouseOver",_sOverHandler);
            _petHallowsSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_goddessSprite)
         {
            _goddessSprite.removeEventListener("mouseOver",_sOverHandler);
            _goddessSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_monsterSprite)
         {
            _monsterSprite.removeEventListener("mouseOver",_sOverHandler);
            _monsterSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_revengerSprite)
         {
            _revengerSprite.removeEventListener("mouseOver",_sOverHandler);
            _revengerSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_devilArmorSprite)
         {
            _devilArmorSprite.removeEventListener("mouseOver",_sOverHandler);
            _devilArmorSprite.removeEventListener("mouseOut",_sOutHandler);
         }
         if(_goddessEquipSprite)
         {
            _goddessEquipSprite.removeEventListener("mouseOver",_sOverHandler);
            _goddessEquipSprite.removeEventListener("mouseOut",_sOutHandler);
         }
      }
      
      private function __refreshPos(param1:NotificationEvent) : void
      {
         var _loc2_:Point = param1.data as Point;
         this.x = _loc2_.x;
         this.y = _loc2_.y - _vbox.numChildren * 44;
      }
      
      private function _sOverHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _petSprite:
               _petOverImg.alpha = 1;
               _petItem.filters = [UIFilter.getBlackFilter()];
               break;
            case _soulSprite:
               _soulImg.alpha = 1;
               break;
            case _fateSprite:
               _fateImg.alpha = 1;
               break;
            case _starSprite:
               _starImg.alpha = 1;
               break;
            case _conciseSprite:
               _conciseImg.alpha = 1;
               break;
            case _petHallowsSprite:
               _petHallowsImage.alpha = 1;
         }
      }
      
      private function _sOutHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _petSprite:
               _petOverImg.alpha = 0;
               _petItem.filters = [UIFilter.getBlackFilter()];
               break;
            case _soulSprite:
               _soulImg.alpha = 0;
               break;
            case _fateSprite:
               _fateImg.alpha = 0;
               break;
            case _starSprite:
               _starImg.alpha = 0;
               break;
            case _conciseSprite:
               _conciseImg.alpha = 0;
               break;
            case _petHallowsSprite:
               _petHallowsImage.alpha = 0;
         }
      }
      
      override public function get height() : Number
      {
         return 294;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_petSprite);
         _petSprite = null;
         ObjectUtils.disposeObject(_petOverImg);
         _petOverImg = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("dispose"));
      }
   }
}

